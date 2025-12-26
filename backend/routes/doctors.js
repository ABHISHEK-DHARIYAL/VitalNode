const express = require("express");
const router = express.Router();
const db = require("../db/db");

router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
        d.doctor_id,
        d.first_name,
        d.last_name,
        d.specialization,
        COUNT(DISTINCT a.patient_id) AS total_patients
      FROM doctors d
      LEFT JOIN appointments a 
        ON d.doctor_id = a.doctor_id
      GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization
      ORDER BY d.specialization
    `);

    res.render("doctors", { doctors: rows });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error fetching doctors");
  }
});

router.get("/:id/patients", async (req, res) => {
  try {
    const doctorId = req.params.id;

    // Doctor details
    const [[doctor]] = await db.query(
      `
      SELECT doctor_id, first_name, last_name, specialization
      FROM doctors
      WHERE doctor_id = ?
      `,
      [doctorId]
    );

    // Patients treated by this doctor
    const [patients] = await db.query(
      `
      SELECT DISTINCT
        p.patient_id,
        p.first_name,
        p.last_name,
        p.phone,
        MAX(a.appointment_date) AS last_visit
      FROM appointments a
      JOIN patients p ON a.patient_id = p.patient_id
      WHERE a.doctor_id = ?
      GROUP BY p.patient_id
      ORDER BY last_visit DESC
      `,
      [doctorId]
    );

    res.render("doctorPatients", {
      doctor,
      patients,
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error loading doctor patients");
  }
});

module.exports = router;
