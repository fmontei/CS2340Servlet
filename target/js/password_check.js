function checkPass(pass1, pass2, message)
{
    var goodColor = "#66cc66";
    var badColor = "#ff6666";
    if (pass1.value == pass2.value) {
        pass2.style.backgroundColor = goodColor;
        message.style.color = goodColor;
        message.innerHTML = "Passwords Match!";
    } else {
        pass2.style.backgroundColor = badColor;
        message.style.color = badColor;
        message.innerHTML = "Passwords Do Not Match!";
    }
}
function hidePasswordError() {
    document.getElementById('confirmMessage').innerHTML = "";
}
function showPasswordError() {
    checkPass(document.getElementById('oldPassword'),
        document.getElementById('confirmOldPassword'),
        document.getElementById('confirmMessage'));
}