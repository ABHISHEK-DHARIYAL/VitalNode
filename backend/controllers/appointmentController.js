const db = require("../db/db");

// Create a new appointment
exports.createAppointment = async (req, res) => {
  const { patient_id, doctor_id, appointment_date, reason } = req.body;
  try {
    await db.query(
      'INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES (?, ?, ?, ?, "Scheduled")',
      [patient_id, doctor_id, appointment_date, reason]
    );
    res.redirect("/appointments");
  } catch (err) {
    res.status(500).send("Error creating appointment");
  }
};

// Filter appointments for Dashboard
exports.getTodayAppointments = async (req, res) => {
  try {
    const [rows] = await db.query(`
            SELECT a.*, p.first_name, d.name as doctor_name 
            FROM appointments a
            JOIN patients p ON a.patient_id = p.patient_id
            JOIN doctors d ON a.doctor_id = d.doctor_id
            WHERE DATE(a.appointment_date) = CURDATE()
            ORDER BY a.appointment_date ASC
        `);
    return rows; // Used by analyticsController or API
  } catch (err) {
    console.error(err);
  }
};
