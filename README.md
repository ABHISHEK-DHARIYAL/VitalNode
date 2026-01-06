# 🏥 VitalNode - Hospital Management System

**VitalNode** is a robust, full-stack hospital management application designed to streamline healthcare operations. It features a comprehensive dashboard for real-time tracking, relational data management for patients and doctors, and advanced analytics for medical equipment monitoring.

---

## 🚀 Key Features

### 📊 Comprehensive Dashboard
* **Real-time KPIs:** View total patients, active doctors, today's appointments, and pending bills at a glance.
* **Dynamic Schedule:** Automatically fetches and displays appointments specifically for the current date using `CURDATE()`.
* **Revenue Tracking:** Integrated bar charts showing monthly income trends via Chart.js.

### 🏥 Patient & Doctor Management
* **Centralized Registry:** Full CRUD-ready structure for managing patient records efficiently.
* **Medical Team Directory:** Categorized view of doctors organized by their specific specializations.
* **Search & Filter:** Optimized frontend JavaScript filtering for instant record lookup without page reloads.

### 📅 Appointment System
* **Relational Data:** Leverages SQL Joins to seamlessly connect Patients, Doctors, and Appointment slots.
* **Status Monitoring:** Track the lifecycle of appointments through *Scheduled*, *Completed*, or *Cancelled* states.

### 📈 Advanced Analytics
* **Device Monitoring:** Track the status, maintenance history, and usage levels of critical hospital machinery (e.g., MRI, Ventilators).
* **Interactive Charts:** Data-driven insights powered by **Chart.js** with asynchronous data fetching from dedicated API endpoints.

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend** | HTML5, CSS3, JavaScript (ES6+), Bootstrap 5 |
| **Backend** | Node.js, Express.js |
| **Database** | MySQL (Relational Management) |
| **Visualization** | Chart.js |

---

## 🗄️ Database Schema Highlights

The project utilizes a highly structured relational database to ensure data integrity across the following key tables:

* **`patients`**: Stores demographic and contact information.
* **`doctors`**: Managed by specialization and availability.
* **`appointments`**: A bridge table linking patients and doctors with timestamps.
* **`billing`**: Tracks financial transactions and payment statuses.
* **`hospital_devices`**: Metadata for medical equipment maintenance tracking.

---

## 📱 Mobile Responsiveness

VitalNode is fully responsive and optimized for both Android and iOS devices:
* **Bootstrap 5:** Utilizes a fluid grid system for all screen sizes.
* **Custom Media Queries:** Optimized for table horizontal scrolling and touch-friendly buttons.
* **Accessibility:** Features a sticky navigation bar with a mobile hamburger menu.

---

## 🔧 Installation & Setup

### 1. Clone the repository
```bash
node -v
npm -v
mysql --version
git clone [https://github.com/ABHISHEK-DHARIYAL/VitalNode.git](https://github.com/ABHISHEK-DHARIYAL/VitalNode.git)
cd VitalNode/backend
npm install
npm run dev
