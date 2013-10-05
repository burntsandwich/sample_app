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
		keywords_in_new = new Array();
		keywords_blacklist_new = new Array()

		#Find keywords that have been dragged into the 'keywords-in' block
		$('#keywords_in').find('.keyword-available, .keyword-blacklisted').each ->
			term = $(this).text()
			keywords_in_new.push(term)
		keywords_in_to_db = JSON.stringify(keywords_in_new)

		#Find keywords that have been dragged into the 'keywords-blacklist' block
		$('#keywords_blacklist').find('.keyword-available, .keyword-in').each ->
			term = "-" + $(this).text()
			keywords_blacklist_new.push(term)
		keywords_blacklist_to_db = JSON.stringify(keywords_blacklist_new)

		#Find keywords that have been dragged into the 'keywords-available' block
		$('#keywords_available').find('.keyword-in, .keyword-blacklisted').each ->
			#Need to fetch IDs and delete from model

		$.ajax
			url: "update_j"
			type: "PUT"
			data: {keywords_in_to_db: keywords_in_to_db, keywords_blacklist_to_db: keywords_blacklist_to_db}
		
		alert(keywords_in_to_db)
