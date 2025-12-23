const express = require("express");
const router = express.Router();
const db = require("../db/db");

// Fetch device data for monitoring
router.get("/", async (req, res) => {
  try {
    const [devices] = await db.query("SELECT * FROM medical_device_data");
    res.render("analytics", { devices }); // Reusing analytics view for device monitoring
  } catch (err) {
    res.status(500).send("Device data error");
  }
});

module.exports = router;
