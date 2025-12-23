const express = require("express");
const router = express.Router();
const db = require("../db/db");

// 1. GET: List All Patients (This powers the EJS loop)
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM patients ORDER BY created_at DESC"
    );
    res.render("patients", { patients: rows });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error fetching patients list");
  }
});

// 2. POST: Add Patient (Already created by you)
router.post("/add", async (req, res) => {
  const { first_name, last_name, email, phone, dob, gender } = req.body;

  if (!first_name || !last_name || phone.length !== 10) {
    return res.status(400).send("Invalid input data");
  }

  try {
    await db.query(
      "INSERT INTO patients (first_name, last_name, email, phone, dob, gender) VALUES (?, ?, ?, ?, ?, ?)",
      [first_name, last_name, email, phone, dob, gender]
    );
    res.redirect("/patients");
  } catch (err) {
    res.status(500).send("Error saving patient");
  }
});

// 3. GET: Search Patient (AJAX search)
router.get("/search", async (req, res) => {
  const { query } = req.query;
  try {
    const [results] = await db.query(
      "SELECT * FROM patients WHERE first_name LIKE ? OR email LIKE ?",
      [`%${query}%`, `%${query}%`]
    );
    res.json(results);
  } catch (err) {
    res.status(500).json({ error: "Search failed" });
  }
});

module.exports = router;
