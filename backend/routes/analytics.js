const express = require("express");
const router = express.Router();
const db = require("../db/db");

router.get("/data", async (req, res) => {
  try {
    const [revenue] = await db.query(`
            SELECT 
                MONTHNAME(date_issued) AS month, 
                SUM(amount) AS total_revenue 
            FROM billing 
            WHERE status = 'Paid' 
            GROUP BY MONTH(date_issued)
            ORDER BY MONTH(date_issued) ASC
        `);
    res.json(revenue); // Sends data to frontend charts (like Chart.js)
  } catch (err) {
    res.status(500).json({ error: "Could not fetch analytics" });
  }
});

module.exports = router;
