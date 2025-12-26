const express = require("express");
const path = require("path");
const app = express();
require("dotenv").config();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

// View Engine
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

// Import Routes
const pageRoutes = require("./routes/pages");
const patientRoutes = require("./routes/patients");
const appointmentRoutes = require("./routes/appointments");
const billingRoutes = require("./routes/billing");

// Add these to your existing server.js imports
const doctorRoutes = require("./routes/doctors");
const analyticsRoutes = require("./routes/analytics");
const pdfRoutes = require("./routes/pdf");
const deviceRoutes = require("./routes/devices");

// Use Routes
app.use("/", pageRoutes); // Handles Dashboard & Navigation
app.use("/patients", patientRoutes);
app.use("/appointments", appointmentRoutes);
app.use("/billing", billingRoutes);

// Register the routes
app.use("/doctors", doctorRoutes);
app.use("/analytics", analyticsRoutes);
app.use("/pdf", pdfRoutes);
app.use("/devices", deviceRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () =>
  console.log(`Server running on http://localhost:${PORT}`)
);
