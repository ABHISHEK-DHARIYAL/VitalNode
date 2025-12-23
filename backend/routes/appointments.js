const express = require("express");
const router = express.Router();
const db = require("../db/db");
const appointmentController = require("../controllers/appointmentController");

// 1. GET: Show all appointments (Used for the Appointments Page)
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
            SELECT a.*, p.first_name, p.last_name, d.name as doctor_name 
            FROM appointments a
            JOIN patients p ON a.patient_id = p.patient_id
            JOIN doctors d ON a.doctor_id = d.doctor_id
            ORDER BY a.appointment_date DESC
        `);
    res.render("appointments", { appointments: rows });
  } catch (err) {
    res.status(500).send("Error loading appointments");
  }
});

// 2. POST: Create a new appointment (Satisfies your Create Appointment prompt)
router.post("/add", appointmentController.createAppointment);

// 3. GET: Filter appointments by date (Satisfies your Appointment Filtering prompt)
router.get("/filter", async (req, res) => {
  const { date } = req.query;
  try {
    const [rows] = await db.query(
      "SELECT * FROM appointments WHERE DATE(appointment_date) = ?",
      [date]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Filtering failed" });
  }
});

module.exports = router;
