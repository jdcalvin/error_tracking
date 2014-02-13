# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('form').on 'click', '.remove_task', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('p').hide()
		event.preventDefault()

	$('form').on 'click', '.remove_category', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('div').hide()
		event.preventDefault()		
