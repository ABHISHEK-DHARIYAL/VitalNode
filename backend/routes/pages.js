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

// Main Page
router.get("/analytics", analyticsController.getDetailedAnalytics);

// JSON API for the Chart
router.get("/analytics/data", analyticsController.getAnalyticsData);

module.exports = router;
