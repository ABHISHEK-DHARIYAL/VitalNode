const db = require("../db/db");

// 1. GET all patients (To show in the table)
exports.getAllPatients = async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT * FROM patients ORDER BY created_at DESC"
    );
    res.render("patients", { patients: rows });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error fetching patients");
  }
};

// 2. POST add new patient (From your Modal)
exports.addPatient = async (req, res) => {
  const { first_name, last_name, dob, gender, phone, email, address } =
    req.body;

  try {
    await db.query(
      "INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [first_name, last_name, dob, gender, phone, email, address]
    );
    // After saving, go back to the patients list
    res.redirect("/patients");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error registering patient");
  }
};
