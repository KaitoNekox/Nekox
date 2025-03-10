// Form Validation System in JavaScript
function validateForm() {
    const form = document.getElementById('registrationForm');
    const email = form.email.value;
    const password = form.password.value;
    const phone = form.phone.value;

    // Regular expressions for validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/; // At least 8 characters, one letter, and one number
    const phoneRegex = /^\d{10}$/; // 10-digit phone number

    // Validate email
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address.');
        return false;
    }

    // Validate password
    if (!passwordRegex.test(password)) {
        alert('Password must be at least 8 characters long, including one letter and one number.');
        return false;
    }

    // Validate phone number
    if (!phoneRegex.test(phone)) {
        alert('Please enter a valid 10-digit phone number.');
        return false;
    }

    // If everything is correct
    alert('Form submitted successfully!');
    return true;
}

// Attach the validation function to the form
document.getElementById('registrationForm').addEventListener('submit', function (event) {
    if (!validateForm()) {
        event.preventDefault(); // Prevent form submission if there are errors
    }
});
