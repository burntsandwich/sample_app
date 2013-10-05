# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	$('#search_edit_save').on 'click', (event) ->
		keywords_in = new Array();
		$('#keywords_in').children().each ->
			term = $(this).text()
			keywords_in.push(term)
		keywords_in_to_db = JSON.stringify(keywords_in)
		$.ajax
			url: "update_j"
			type: "PUT"
			data: {keywords_in_to_db: keywords_in_to_db}
		alert(keywords_in_to_db)
