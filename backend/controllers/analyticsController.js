const db = require("../db/db");

// 1. Dashboard Logic (The KPI cards and Today's List)
exports.getDashboardStats = async (req, res) => {
  try {
    // Fetch various stats from the database
    const [patients] = await db.query("SELECT COUNT(*) as total FROM patients");
    const [doctors] = await db.query("SELECT COUNT(*) as total FROM doctors");
    const [appointmentsCount] = await db.query(
      "SELECT COUNT(*) as total FROM appointments WHERE DATE(appointment_date) = CURDATE()"
    );
    const [unpaid] = await db.query(
      "SELECT COUNT(*) as total FROM billing WHERE status = 'Unpaid'"
    );

    const [revenue] = await db.query(`
            SELECT MONTHNAME(date_issued) as month, SUM(amount) as total 
            FROM billing 
            WHERE status = 'Paid' 
            GROUP BY month, MONTH(date_issued) 
            ORDER BY MONTH(date_issued) ASC
        `);

    const [todayAppointmentsList] = await db.query(`
            SELECT a.appointment_date, a.status, p.first_name, 
                   d.first_name as doc_fname, d.last_name as doc_lname 
            FROM appointments a
            JOIN patients p ON a.patient_id = p.patient_id
            JOIN doctors d ON a.doctor_id = d.doctor_id
            WHERE DATE(a.appointment_date) = CURDATE()
            ORDER BY a.appointment_date ASC
        `);

    res.render("dashboard", {
      stats: {
        totalPatients: patients[0].total,
        totalDoctors: doctors[0].total,
        todayAppointments: appointmentsCount[0].total,
        unpaidBills: unpaid[0].total,
      },
      revenueData: revenue,
      todayList: todayAppointmentsList,
    });
  } catch (err) {
    console.error("Dashboard Error:", err);
    res.status(500).send("Error loading dashboard");
  }
};

// 2. Detailed Analytics Page (The Devices Table)
exports.getDetailedAnalytics = async (req, res) => {
  try {
    const [deviceRows] = await db.query("SELECT * FROM hospital_devices");
    res.render("analytics", { devices: deviceRows });
  } catch (err) {
    console.error("Analytics Page Error:", err);
    res.render("analytics", { devices: [] });
  }
};

// 3. JSON Data for Charts (Called by fetch in analytics.ejs)
exports.getAnalyticsData = async (req, res) => {
  try {
    const [revenue] = await db.query(`
            SELECT MONTHNAME(date_issued) as month, SUM(amount) as total_revenue 
            FROM billing 
            WHERE status = 'Paid' 
            GROUP BY month, MONTH(date_issued) 
            ORDER BY MONTH(date_issued) ASC
        `);
    res.json(revenue);
  } catch (err) {
    console.error("Chart Data Error:", err);
    res.status(500).json({ error: "Failed to fetch chart data" });
  }
};
