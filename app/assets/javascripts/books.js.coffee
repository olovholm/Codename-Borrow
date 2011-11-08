# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('document').ready ->
 $('#q_book').autocomplete({source: "/ajax/find_books", minLength: 3})
	// Sjekke om det finnes en autocomplete, og erstatte soek med legg til. 
		