// js/footer-date.js

// Format date as "14 September 2025"
const options = { day: '2-digit', month: 'long', year: 'numeric' };
const today = new Date().toLocaleDateString('en-GB', options);

// Insert into footer if element exists
const footerDate = document.getElementById("deploy-date");
if (footerDate) {
  footerDate.textContent = today;
}
