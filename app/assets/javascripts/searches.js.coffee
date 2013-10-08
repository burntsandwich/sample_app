# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	#Handles the 'update search' button
	$('#search_edit_save').on 'click', (event) ->
		keywords_in_new = new Array();
		keywords_blacklist_new = new Array()
		keywords_bin_new = new Array()

		#Find keywords that have been dragged into the 'keywords-in' block
		$('#keywords_in').find('.keyword-available, .keyword-blacklisted, .keyword-custom').each ->
			term = $(this).text()
			keywords_in_new.push(term)
		keywords_in_to_db = JSON.stringify(keywords_in_new)

		#Find keywords that have been dragged into the 'keywords-blacklist' block
		$('#keywords_blacklist').find('.keyword-available, .keyword-in, .keyword-custom').each ->
			term = "-" + $(this).text()
			keywords_blacklist_new.push(term)
		keywords_blacklist_to_db = JSON.stringify(keywords_blacklist_new)

		#Find keywords that have been dragged into the 'keywords-bin' block
		$('#keywords_bin').children().each ->
			term = $(this).attr('id')
			keywords_bin_new.push(term)
		keywords_bin_to_db = JSON.stringify(keywords_bin_new)

		$.ajax
			url: "update_j"
			type: "PUT"
			data: {keywords_in_to_db: keywords_in_to_db, keywords_blacklist_to_db: keywords_blacklist_to_db, keywords_bin_to_db: keywords_bin_to_db}
		
		alert("Search updated")

	#Take terms entered into the custom input field and put them into keywords_available
	$('#add_term_available').on 'click', (event) ->
		newterm = $('#newterm_available').val()
		newterm_formatted = ["<li class='keyword-custom ui-state-default'>", newterm, "</li>"].join("")
		$('#keywords_in').prepend(newterm_formatted)
		$('#newterm_available').removeAttr('value')

	#Take terms entered into the custom input field and put them into keywords_blacklist
	$('#add_term_blacklist').on 'click', (event) ->
		newterm = $('#newterm_blacklist').val()
		newterm_formatted = ["<li class='keyword-custom ui-state-default'>", newterm, "</li>"].join("")
		$('#keywords_blacklist').prepend(newterm_formatted)
		$('#newterm_blacklist').removeAttr('value')
