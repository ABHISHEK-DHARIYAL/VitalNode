const express = require("express");
const router = express.Router();
const db = require("../db/db");
const appointmentController = require("../controllers/appointmentController");

// 1. GET: Show all appointments (Used for the Appointments Page)
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        a.appointment_id,
        a.appointment_date,
        a.reason,
        a.status,

        p.first_name AS patient_fname,
        p.last_name  AS patient_lname,

        d.first_name AS doctor_fname,
        d.last_name  AS doctor_lname

      FROM appointments a
      JOIN patients p ON a.patient_id = p.patient_id
      JOIN doctors d ON a.doctor_id = d.doctor_id
      ORDER BY a.appointment_date DESC
    `);

    res.render("appointments", { appointments: rows });
  } catch (err) {
    console.error(err);
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
