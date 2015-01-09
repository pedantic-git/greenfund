$(document).ready(function () {
  $.getJSON("funding.json", function(data) {
    var data_arr = [];
    for (var name in data) {
      data_arr.push([name, data[name]]);
    }
    data_arr.sort(function (a, b) { return a[1] - b[1] });
    var rawData = [];
    var ticks   = [];
    $.each(data_arr, function (idx, val) {
      rawData.push([val[1], idx]);
      ticks.push([idx, val[0]]);
    });
    var dataSet = [{data: rawData, color: "#008800"}];
    var options = {
      series: {
	bars: {
	  show: true
	}
      },
      bars: {
	align: "center",
	barWidth: 0.5,
	horizontal: true
      },
      yaxis: {
	ticks: ticks
      },
      grid: {
	hoverable: true
      }
    };
    $.plot($('#chart'), dataSet, options);
  });
});
