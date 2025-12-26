// JavaScript code to render revenue chart on analytics page
document.addEventListener("DOMContentLoaded", () => {
  loadCharts();
});

async function loadCharts() {
  try {
    const response = await fetch("/analytics/data");
    const data = await response.json();

    if (!Array.isArray(data) || data.length === 0) {
      console.warn("No chart data received");
      return;
    }

    const canvas = document.getElementById("revenueChart");
    if (!canvas) {
      console.warn("Canvas not found");
      return;
    }

    const ctx = canvas.getContext("2d");

    new Chart(ctx, {
      type: "bar",
      data: {
        labels: data.map((row) => row.month),
        datasets: [
          {
            label: "Revenue ($)",
            data: data.map((row) => row.total_revenue),
            backgroundColor: "#2563eb",
            hoverBackgroundColor: "#1d4ed8",
            borderRadius: 8,
            borderSkipped: false,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: {
            backgroundColor: "#1e293b",
            padding: 12,
            titleFont: { size: 14 },
            bodyFont: { size: 14 },
          },
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: { color: "#e2e8f0" },
            ticks: { callback: (value) => "$" + value },
          },
          x: {
            grid: { display: false },
          },
        },
      },
    });
  } catch (error) {
    console.error("Error loading chart data:", error);
  }
}
