((function(){$("document").ready(function(){return $("#q_book").autocomplete({source:"/ajax/find_books",minLength:3,select:function(a,b){return $.ajax({type:"get",url:"/ajax/add_book",data:{book_id:""+b.item.id},dataType:"text",success:function(a){return $("#feedback").css("visibility","visible"),$("#feedback").text(a),$("#q_book").val("")}})}})})})).call(this)