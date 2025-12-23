🏥 VitalNode - Hospital Management System
VitalNode is a robust, full-stack hospital management application designed to streamline healthcare operations. It features a comprehensive dashboard for real-time tracking, relational data management for patients and doctors, and advanced analytics for medical equipment monitoring.

🚀 Features
📊 Comprehensive Dashboard
Real-time KPIs: View total patients, active doctors, today's appointments, and pending bills at a glance.

Dynamic Schedule: Automatically fetches and displays appointments specifically for the current date (CURDATE()).

Revenue Tracking: Integrated bar charts showing monthly income trends.

🏥 Patient & Doctor Management
Centralized Registry: Full CRUD-ready structure for patient records.

Medical Team Directory: Categorized view of doctors by specialization.

Search & Filter: Frontend JavaScript filtering for instant record lookup without page reloads.

📅 Appointment System
Relational Data: Uses SQL Joins to connect Patients, Doctors, and Appointment slots.

Status Monitoring: Track appointments through Scheduled, Completed, or Cancelled states.

📈 Advanced Analytics
Device Monitoring: Track the status, maintenance history, and usage levels of critical hospital machinery (MRI, Ventilators, etc.).

Interactive Charts: Powered by Chart.js with asynchronous data fetching from a dedicated API endpoint.

🗄️ Database Schema (DBMS Highlights)
The project utilizes a relational structure to ensure data integrity.

Key Tables:

patients: Stores demographic and contact information.

doctors: Managed by specialization and availability.

appointments: A bridge table linking patients and doctors with timestamps.

billing: Tracks financial transactions and payment statuses.

hospital_devices: Metadata for medical equipment maintenance tracking.

📱 Mobile Responsiveness
VitalNode is fully responsive and tested for Android and iOS devices:

Bootstrap 5: Utilizes a fluid grid system.

Custom Media Queries: Optimized for table horizontal scrolling and touch-friendly buttons.

Accessibility: Sticky navigation with a mobile hamburger menu for small-screen access.

🔧 Installation & Setup

1. Clone the repository
   Bash

git clone (https://github.com/ABHISHEK-DHARIYAL/VitalNode.git)
cd VitalNode/backend 2. Install dependencies
Bash

npm install 3. Database Configuration
Create a MySQL database.

Run the provided SQL initialization scripts to set up the tables.

Create a .env file in the backend directory and add your credentials:

Code snippet

DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=vitalnode_db 4. Start the server
Bash

npm run dev
The application will be accessible at: http://localhost:3000
