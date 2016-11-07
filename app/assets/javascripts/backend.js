// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-datepicker.min
//= require angular.min
//= require angularscript/backend_angular
//= require bootstrap-select.min


$('#datepicker').datepicker({
	
    todayHighlight: true,
    language: 'en',
    pick12HourFormat: true,
    endDate: '0d',
    format: 'dd/mm/yyyy',
    autoclose: true,
   
});

$(document).ready(function() {
	$(".print_pdf").click(function(event) {
		window.print();
	});

    $('.chevron').click(function(i, e) {
        // $(this).click(function(event) {
            $(this).find('span').toggleClass("glyphicon-chevron-down");
            $(this).find('span').toggleClass("glyphicon-chevron-up");
        // });
    });
});

// $( "#datepicker" ).datepicker({
	
// 	inline: true,
// 	dateFormat: 'dd/mm/yy',
// 	monthNames: [ "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" ],
// 	monthNamesShort: [ "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic" ],
// 	changeYear: true,
// 	changeMonth: true,
// 	minDate: '0d',
// 	yearRange: "+0:+20"
// });



