/*
Template Name: Color Admin - Responsive Admin Dashboard Template build with Twitter Bootstrap 5
Version: 5.1.4
Author: Sean Ngu
Website: http://www.seantheme.com/color-admin/
*/

var getMonthName = function(number) {
	var month = [];
	month[0] = "JAN";
	month[1] = "FEB";
	month[2] = "MAR";
	month[3] = "APR";
	month[4] = "MAY";
	month[5] = "JUN";
	month[6] = "JUL";
	month[7] = "AUG";
	month[8] = "SEP";
	month[9] = "OCT";
	month[10] = "NOV";
	month[11] = "DEC";

	return month[number];
};

var getDate = function(date) {
	var currentDate = new Date(date);
	var dd = currentDate.getDate();
	var mm = currentDate.getMonth() + 1;
	var yyyy = currentDate.getFullYear();

	if (dd < 10) {
		dd = '0' + dd;
	}
	if (mm < 10) {
		mm = '0' + mm;
	}
	currentDate = yyyy+'-'+mm+'-'+dd;

	return currentDate;
};

var handleVisitorsAreaChart = function() {
	var handleGetDate = function(minusDate) {
		var d = new Date();
		    d = d.setDate(d.getDate() - minusDate);
		return d;
	};

	var color1 = ($('#visitors-line-chart').attr('data-color') == 'black') ? app.color.black : app.color.cyan;
	var color2 = ($('#visitors-line-chart').attr('data-color') == 'black') ? 'rgba('+ app.color.blackRgb + ', .5)' : app.color.blue;

	var visitorAreaChartData = [{
		'key' : 'Line Process',
		'color' : color1,
		'values' : [
		]
	}, {
		'key' : 'Page Views',
		'color' : color2,
		'values' : [
		]
	}];

	nv.addGraph(function() {
		var stackedAreaChart = nv.models.stackedAreaChart()
			.useInteractiveGuideline(true)
			.x(function(d) { return d[0] })
			.y(function(d) { return d[1] })
			.pointSize(0.5)
			.margin({'left':35,'right': 25,'top': 20,'bottom':20})
			.controlLabels({stacked: 'Stacked'})
			.showControls(false)
			.duration(300);

		stackedAreaChart.xAxis.tickFormat(function(d) {
			var monthsName = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			d = new Date(d);
			d = monthsName[d.getMonth()] + ' ' + d.getDate();
			return d ;
		});
		stackedAreaChart.yAxis.tickFormat(d3.format(',.0f'));

		d3.select('#visitors-line-chart')
			.append('svg')
			.datum(visitorAreaChartData)
			.transition().duration(1000)
			.call(stackedAreaChart)
			.each('start', function() {
				setTimeout(function() {
					d3.selectAll('#visitors-line-chart *').each(function() {
						if(this.__transition__)
							this.__transition__.duration = 1;
					})
				}, 0)
			});

		nv.utils.windowResize(stackedAreaChart.update);
		return stackedAreaChart;
	});
};

var handleVisitorsDonutChart = function() {
	var color1 = ($('#visitors-donut-chart').attr('data-color') == 'black') ? app.color.black : app.color.blue;
	var color2 = ($('#visitors-donut-chart').attr('data-color') == 'black') ? 'rgba('+ app.color.blackRgb + ', .5)' : app.color.teal;

	var visitorDonutChartData = [
		{ 'label': 'Return Visitors', 'value' : 784466, 'color': color1 },
		{ 'label': 'New Visitors', 'value' : 416747, 'color': color2 }
	];
	var arcRadius = [
		{ inner: 0.65, outer: 0.93 },
		{ inner: 0.6, outer: 1 }
	];

	nv.addGraph(function() {
	  var donutChart = nv.models.pieChart()
		  .x(function(d) { return d.label })
		  .y(function(d) { return d.value })
		  .margin({'left': 10,'right':  10,'top': 10,'bottom': 10})
		  .showLegend(false)
		  .donut(true)
		  .growOnHover(false)
		  .arcsRadius(arcRadius)
		  .donutRatio(0.5);

		donutChart.labelFormat(d3.format(',.0f'));

		d3.select('#visitors-donut-chart').append('svg')
			.datum(visitorDonutChartData)
			.transition().duration(3000)
			.call(donutChart);

		return donutChart;
	});
};

var handleVisitorsVectorMap = function() {
	if ($('#visitors-map').length !== 0) {
		var color1 = ($('#visitors-map').attr('data-color') == 'black') ? app.color.black : app.color.blue;
		var color2 = ($('#visitors-map').attr('data-color') == 'black') ? 'rgba('+ app.color.blackRgb + ', .5)' : app.color.teal;
		var scaleColor = ($('#visitors-map').attr('data-color')) ? ['rgba('+ app.color.blackRgb + ', .5)', 'rgba('+ app.color.blackRgb + ', .75)'] : [app.color.gray600, app.color.dark];
		var fillColor = ($('#visitors-map').attr('data-color') == 'black') ? 'rgba('+ app.color.blackRgb + ', .25)' : app.color.gray600;
				fillColor = ($('#visitors-map').attr('data-color') == 'white') ? 'rgba('+ app.color.whiteRgb + ', .25)' : fillColor;
		$('#visitors-map').vectorMap({
			map: 'world_mill',
			scaleColors: scaleColor,
			container: $('#visitors-map'),
			normalizeFunction: 'linear',
			hoverOpacity: 0.5,
			hoverColor: false,
			zoomOnScroll: false,
			markerStyle: {
				initial: {
					fill: app.color.dark,
					stroke: 'transparent',
					r: 3
				}
			},
			regions: [{
				attribute: 'fill'
			}],
			regionStyle: {
				initial: {
					fill: fillColor,
					"fill-opacity": 1,
					stroke: 'none',
					"stroke-width": 0.4,
					"stroke-opacity": 1
				},
				hover: {
					"fill-opacity": 0.8
				},
				selected: {
					fill: 'yellow'
				}
			},
			series: {
				regions: [{
					values: {
						IN: color1,
						US: color2,
						MN: app.color.dark
					}
				}]
			},
			focusOn: {
				x: 0.5,
				y: 0.5,
				scale: 1
			},
			backgroundColor: 'transparent'
		});
	}
};

var handleScheduleCalendar = function() {
	$("#schedule-calendar").simpleCalendar({
		fixedStartDay: false,
		disableEmptyDetails: true,
		events: [{
			startDate: new Date(new Date().setHours(new Date().getHours() + 24)).toDateString(),
			endDate: new Date(new Date().setHours(new Date().getHours() + 25)).toISOString(),
			summary: 'Visit of the Eiffel Tower'
		}, {
			startDate: new Date(new Date().setHours(new Date().getHours() - new Date().getHours() - 12, 0)).toISOString(),
			endDate: new Date(new Date().setHours(new Date().getHours() - new Date().getHours() - 11)).getTime(),
			summary: 'Restaurant'
		}, {
			startDate: new Date(new Date().setHours(new Date().getHours() - 48)).toISOString(),
			endDate: new Date(new Date().setHours(new Date().getHours() - 24)).getTime(),
			summary: 'Visit of the Louvre'
		}]
	});
};

var handleDashboardGritterNotification = function() {
	setTimeout(function() {
		$.gritter.add({
			title: 'Welcome back, Admin!',
			text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempus lacus ut lectus rutrum placerat.',
			image: '../assets/img/user/user-12.jpg',
			sticky: true,
			time: '',
			class_name: 'my-sticky-class'
		});
	}, 1000);
};

var DashboardV2 = function () {
	"use strict";
	return {
		//main function
		init: function () {
			handleVisitorsAreaChart();
			handleVisitorsDonutChart();
			handleVisitorsVectorMap();
			handleScheduleCalendar();
			handleDashboardGritterNotification();
		}
	};
}();

$(document).ready(function() {
	DashboardV2.init();
});
