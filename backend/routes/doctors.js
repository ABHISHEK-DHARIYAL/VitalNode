const express = require("express");
const router = express.Router();
const db = require("../db/db");

router.get("/", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM doctors ORDER BY name ASC");
    res.render("doctors", { doctors: rows });
  } catch (err) {
    res.status(500).send("Error fetching doctors");
  }
});

module.exports = router;
