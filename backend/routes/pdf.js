const express = require("express");
const router = express.Router();
const pdfController = require("../controllers/pdfController");

// This tells Express: When GET /pdf/download/1 is called, use the controller function
router.get("/download/:id", pdfController.generateInvoice);

// THIS IS THE LINE THAT FIXES YOUR CRASH
module.exports = router;
