// --- Modal Management ---
function openModal() {
  const modal = document.getElementById("patientModal");
  if (modal) modal.style.display = "flex";
}

function closeModal() {
  const modal = document.getElementById("patientModal");
  if (modal) modal.style.display = "none";
}

// Close modal if user clicks outside of it
window.onclick = function (event) {
  const modal = document.getElementById("patientModal");
  if (event.target === modal) closeModal();
};

// --- Table Search Filtering ---
function filterPatients() {
  filterTable("patientSearch", "patientsTable");
}

function filterTable(inputId, tableId) {
  const input = document.getElementById(inputId);
  if (!input) return;

  const filter = input.value.toLowerCase();
  const table = document.getElementById(tableId);
  if (!table) return;

  const rows = table.getElementsByTagName("tr");
  for (let i = 1; i < rows.length; i++) {
    const text = rows[i].textContent.toLowerCase();
    rows[i].style.display = text.includes(filter) ? "" : "none";
  }
}

// --- Initialize Dashboard Chart ---
document.addEventListener("DOMContentLoaded", () => {
  console.log("Hospital Management Frontend Initialized");

  // Check if we are on the dashboard (if the chart canvas exists)
  const ctx = document.getElementById("revenueChart");
  if (ctx) {
    // We get the data from a hidden input or global variable injected by EJS
    // This assumes you have: <script>const revenueData = <%- JSON.stringify(revenueData) %>;</script> in your EJS
    if (typeof revenueData !== "undefined") {
      new Chart(ctx, {
        type: "bar",
        data: {
          labels: revenueData.map((item) => item.month),
          datasets: [
            {
              label: "Revenue ($)",
              data: revenueData.map((item) => item.total),
              backgroundColor: "#3498db",
              borderRadius: 5,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: { beginAtZero: true },
          },
        },
      });
    }
  }
});
