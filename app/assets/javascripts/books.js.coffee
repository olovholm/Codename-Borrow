# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$('document').ready ->
	$('#q_book').autocomplete {source: "/ajax/find_books", minLength: 3, select: (event,ui) -> 
			 $.ajax({
				type : 'get',
				url : '/ajax/add_book',
				data : { book_id : "#{ui.item.id}" },
				dataType : 'text',
				success: (data) ->
					$('#feedback').css("visibility","visible")
					$('#feedback').text(data)
					$('#q_book').val('')
			}
		 }
		}
		



	
	
	###
	
		
			$('[id="search_form"] input[type="submit"]').val("Legg til")
			$('form[id="search_form"]').get(0).setAttribute('action', 'add')
			
			if $('#q_book').change and $('#q_book').val() == " "
					$('[id="search_form"] input[type="submit"]').val("Søk")
					$('form[id="search_form"]').get(0).setAttribute('action', 'search')
					
					
	###
		