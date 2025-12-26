// for rendering revenue chart
// assumes revenueData is a global variable passed from the server

document.addEventListener("DOMContentLoaded", () => {
  if (!revenueData || revenueData.length === 0) {
    console.warn("No revenue data available");
    return;
  }

  const ctx = document.getElementById("revenueChart");
  if (!ctx) return;

  new Chart(ctx, {
    type: "line",
    data: {
      labels: revenueData.map((r) => r.month),
      datasets: [
        {
          label: "Revenue",
          data: revenueData.map((r) => r.total),
          borderColor: "#2563eb",
          backgroundColor: "rgba(37, 99, 235, 0.15)",
          tension: 0.4,
          fill: true,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
      },
      scales: {
        y: {
          ticks: {
            callback: (value) => `₹${value}`,
          },
        },
      },
    },
  });
});
