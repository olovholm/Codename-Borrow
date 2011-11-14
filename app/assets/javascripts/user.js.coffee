# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('document').ready ->
	$('#user_birthdate').datepicker({changeMonth: true, changeYear: true, maxDate: '-10y', yearRange: '-100y:maxDate'});
	### Test of username and whether it is unique follows ###
	$("#user_username").blur ->
		value = $("#user_username").val() 
		if value.length > 6
			$.ajax {
				type : 'get',
				url : '/ajax/username_exists',
				data : { username : value},
				dataType : 'text',
				success: (data) ->
					if data is "false"
						$("#user_username").removeClass("form_error").addClass("form_success")
					else
						$("#user_username").removeClass("form_success").addClass("form_error")
				} 
		else
			$("#user_username").removeClass("form_success").addClass("form_error")
		### Test of passwords and whether they are long enough and similar ###
	$("#user_password").blur -> 
		if $(this).val().length > 6
			$(this).removeClass("form_error").addClass("form_success")
		else
			$(this).removeClass("form_success").addClass("form_error")

	$("#user_password_confirmation").blur -> 
		if $(this).val().length > 6 and $(this).val() == $("#user_password").val()
			$(this).removeClass("form_error").addClass("form_success")
		else
			$(this).removeClass("form_success").addClass("form_error")


			
			
	