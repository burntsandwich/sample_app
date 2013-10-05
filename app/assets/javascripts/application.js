// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-migrate-min
//= require bootstrap
//= require jquery_ujs
//= require jquery.ui.all
//= require_tree .

$(document).ready(function() {
	$('div.nav li').on('click', function() {
		$(this).addClass('active');
		});
	});

$(document).ready(function() {
	$('#date').datepicker();
})

  $(function() {
	$( "#keywords p" ).draggable();
	$( "#droppable" ).droppable({
		activeClass: "ui-state-default",
		hoverClass: "ui-state-hover",
		drop: function( event, ui ) {
			$( this ).find( ".placeholder" ).remove();
			$( "<li></li>" ).text( ui.draggable.text())
				.addClass("keyword-selected")
				.appendTo( this );
			$(ui.draggable).remove();
		}
	});
});

$(function() {
	$( "#keywords_in, #keywords_available, #keywords_blacklist, #keywords_bin" ).sortable({
		connectWith: ".connectedSortable"
	}).disableSelection();
});