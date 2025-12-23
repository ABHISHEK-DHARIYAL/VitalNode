// Global Configuration
const API_URL = window.location.origin;

// Global Alert System
function showAlert(message, type = "success") {
  alert(`${type.toUpperCase()}: ${message}`);
}
