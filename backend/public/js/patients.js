// Open patient registration modal
function openModal() {
  const modal = document.getElementById("patientModal");
  if (modal) modal.style.display = "flex";
}

// Close modal
function closeModal() {
  const modal = document.getElementById("patientModal");
  if (modal) modal.style.display = "none";
}

// Close modal on outside click
document.addEventListener("click", (e) => {
  const modal = document.getElementById("patientModal");
  if (modal && e.target === modal) {
    closeModal();
  }
});

// Filter patients table
function filterPatients() {
  const search = document.getElementById("patientSearch").value.toLowerCase();
  const rows = document.querySelectorAll("#patientsTable tbody tr");

  rows.forEach((row) => {
    const text = row.innerText.toLowerCase();
    row.style.display = text.includes(search) ? "" : "none";
  });
}

// View patient history
function viewHistory(patientId) {
  window.location.href = `/patients/${patientId}/history`;
}
