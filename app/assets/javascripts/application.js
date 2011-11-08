// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .

/*
	Methods for the program
*/

function login() {
	var dataString = 'username' + username + '&password' + password;
	$.ajax({
		type: "POST", 
		url: "/user/login",
		data: dataString,
		success: function() {
			$("login_form").append("<p>This did work</p>");
		}	
	});
	return false;
}


/*
	Initializing methods
*/

$('document').ready(function() {
	/*
		Start-up methods
	*/
	$('#login_form').hide();
	$('#login_link').html("<a href='#' id='login_link'> Logg inn!</a>");
	
	/*
		Triggered methods
	*/
	
	$('#login_link').click(function(){
		$('#login_form').toggle("fast");
	});
	
	$('.success, .error, .notice').click(function(){
		$(this).fadeOut('slow');
	});
	
	$('#user_postcode').focusout(function(){
		var code = $(this).val();
		if(code.length == 4){
		var request = $.ajax({
		  url: "postplace_ajax/"+code,
		  data: code,
		  type: "GET",
		  dataType: "text", 
		  success: function(data) {
			$('#user_postplace').val(data);
			$("#user_postplace").attr("disabled", "disabled");
			
		}
		});
		
		}//End on 4 digits postcode condition
		
	
		
		
	});
	
	$('#login_link').submit(login);
});


