//Get Month and Year
$(document).ready(function () {
  var month = new Array();
  month[0] = "January"; month[1] = "February";  month[2] = "March"; month[3] = "April"; month[4] = "May"; month[5] = "June";
  month[6] = "July"; month[7] = "August"; month[8] = "September"; month[9] = "October"; month[10] = "November"; month[11] = "December";

    var d = new Date();
    newdate = month[d.getMonth()] + "\xa0" + d.getFullYear() + "";

  document.getElementById("date").innerHTML = newdate;
});







// Circle Ring
$(document).ready(function () {
    let circle = $("circle")[0];
    let radius = circle.r.baseVal.value;
    let circumference = radius * 2 * Math.PI;

    circle.style.strokeDasharray =  `${Math.round(circumference)}px ${Math.round(circumference)}px`;
     circle.style.strokeDashoffset = `${Math.round(circumference)}`;

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


//Chart
$(document).ready(function(){
let myChart = document.getElementById('myChart').getContext('2d');

// Global Options
Chart.defaults.global.defaultFontFamily = 'Lato';
Chart.defaults.global.defaultFontSize = 18;
Chart.defaults.global.defaultFontColor = '#777';

let massPopChart = new Chart(myChart, {
  type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
  data:{
    labels:['2015', '2016', '2017', '2018', '2019', '2020'],
    datasets:[{
      label:'Population',
      data:[
        617594,
        181045,
        153060,
        106519,
        105162,
        95072
      ],
      //backgroundColor:'green',
      backgroundColor:[
        'rgba(255, 99, 132, 0.6)',
        'rgba(54, 162, 235, 0.6)',
        'rgba(255, 206, 86, 0.6)',
        'rgba(75, 192, 192, 0.6)',
        'rgba(153, 102, 255, 0.6)',
        'rgba(255, 159, 64, 0.6)',
        'rgba(255, 99, 132, 0.6)'
      ],
      borderWidth:4,
      borderColor:'#FFFFFF',
      hoverBorderWidth:3,
      hoverBorderColor:'#000'
    }]
  },
  options:{
    title:{
      display:true,
      text:'Savings',
      fontColor: '#FFFFFF',
      fontSize:40
    },
    legend:{
      display:false,
      position:'left',
      labels:{
        fontColor:'#000'
      }
    },
    layout:{
      padding:{
        left:0,
        right:0,
        bottom:0,
        top:0
      }
    },
    tooltips:{
      enabled:true
    }
  }
});
});
