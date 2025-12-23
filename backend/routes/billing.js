const express = require("express");
const router = express.Router();
const db = require("../db/db");
const pdfController = require("../controllers/pdfController");

// Get all bills
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query(`
            SELECT b.*, p.first_name, p.last_name 
            FROM billing b 
            JOIN patients p ON b.patient_id = p.patient_id
        `);
    res.render("billing", { bills: rows });
  } catch (err) {
    res.status(500).send("Error fetching bills");
  }
});

// Route for downloading PDF
router.get("/download/:id", pdfController.generateInvoice);

module.exports = router;
