const express = require("express");
const router = express.Router();
const db = require("../db/db");
const analyticsController = require("../controllers/analyticsController"); // Double check this path!

// 1. Dashboard (KPIs handled by controller)
router.get("/", analyticsController.getDashboardStats);

// 2. Patients Page (Fetched from DB)
router.get("/patients", async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM patients ORDER BY created_at DESC"
    );
    res.render("patients", { patients: rows });
  } catch (err) {
    res.render("patients", { patients: [] });
  }
});

// 3. Doctors Page (Fetched from DB) - FIXED THE CRASH HERE
router.get("/doctors", async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM doctors ORDER BY specialization"
    );
    res.render("doctors", { doctors: rows }); // Sending 'doctors' variable to EJS
  } catch (err) {
    console.error(err);
    res.render("doctors", { doctors: [] });
  }
});

// 4. Appointments Page (Fetched from DB with Joins)
router.get("/appointments", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT a.*, p.first_name as p_name, d.first_name as d_name, d.last_name as d_lname 
      FROM appointments a
      JOIN patients p ON a.patient_id = p.patient_id
      JOIN doctors d ON a.doctor_id = d.doctor_id
      ORDER BY a.appointment_date DESC
    `);
    res.render("appointments", { appointments: rows });
  } catch (err) {
    res.render("appointments", { appointments: [] });
  }
});

// 5. Billing Page
router.get("/billing", async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM billing ORDER BY date_issued DESC"
    );
    res.render("billing", { bills: rows });
  } catch (err) {
    res.render("billing", { bills: [] });
  }
});

// Main Page
router.get("/analytics", analyticsController.getDetailedAnalytics);

// JSON API for the Chart
router.get("/analytics/data", analyticsController.getAnalyticsData);

module.exports = router;
