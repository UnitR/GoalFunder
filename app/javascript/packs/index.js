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
Chart.defaults.global.defaultFontFamily = 'Arial';
Chart.defaults.global.defaultFontSize = 18;
Chart.defaults.global.defaultFontColor = '#777';

let massPopChart = new Chart(myChart, {
  type:'line', // bar, horizontalBar, pie, line, doughnut, radar, polarArea
  data:{
    fontColor: '#FFFFFF',
    labels:['2015', '2016', '2017', '2018', '2019', '2020'],
    datasets:[{
      label:'Money Saved',
      data:[
        105162,
        181045,
        153060,
        181045,
        617594,

      ],
      backgroundColor:'#bfe5ff',

      borderWidth:4,
      borderColor:'#FFFFFF',
      hoverBorderWidth:3,
      hoverBorderColor:'#000'
    }]
  },
  options:{
    scales: {
        yAxes: [{
          display: false,
            ticks: {
                display: false
            },
            gridLines: {
              display: false,
            //  color: "#FFFFFF"
            }

        }],

        xAxes: [{
          gridLines: {
            display: true,
            //color: "#FFFFF"
          },
          ticks: {
          fontColor: 'white'
            //lineheight: 1.2
        }

        }]
    },

    title:{
      display:false,
      text:'Savings',
      fontColor: '#FFFFFF',
      fontSize:60
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
    },
}
});
});
