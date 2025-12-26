const express = require("express");
const router = express.Router();
const db = require("../db/db");
const pdfController = require("../controllers/pdfController");

// Get all bills
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT
        b.bill_id,
        b.amount,
        b.status,
        b.date_issued,

        p.first_name AS patient_fname,
        p.last_name  AS patient_lname

      FROM billing b
      JOIN patients p ON b.patient_id = p.patient_id
      ORDER BY b.date_issued DESC
    `);

    res.render("billing", { bills: rows });
  } catch (err) {
    console.error(err);
    res.status(500).send("Error fetching bills");
  }
});

// Route for downloading PDF
router.get("/download/:id", pdfController.generateInvoice);

module.exports = router;
