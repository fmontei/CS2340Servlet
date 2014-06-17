function turnOnVisibility(ids) {
    var element;
    for (var i = 0; i < ids.length; i++) {
        element = document.getElementById(ids[i]);
        element.style.display = 'block';
    };
}
function turnOffVisibility(ids) {
    var element;
    for (var i = 0; i < ids.length; i++) {
        element = document.getElementById(ids[i]);
        element.style.display = 'none';
    };
}