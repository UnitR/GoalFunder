// Circle Ring
$(document).ready(function () {
    let circle = $("circle")[0];
    let radius = circle.r.baseVal.value;
    let circumference = radius * 2 * Math.PI;

    circle.style.strokeDasharray =  `${Math.round(circumference)}px ${Math.round(circumference)}px`;
    // circle.style.strokeDashoffset = `${Math.round(circumference)}`;

    function setProgress(percent) {
        const offset = circumference - percent / 100 * circumference;
        circle.style.strokeDashoffset = offset;
    }

    const input = $('input');
    setProgress(input.val());

    input.on('change', function(e) {
        if (this.value < 101 && this.value > -1) {
            setProgress(this.value);
        }
    });
});
