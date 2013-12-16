$(document).ready(function(){


		$('.header_icon').on("click", function(){
   
      var targetData = $(this).data('expansion');

      if (targetData == "user") {
      	console.log("user");
      	var target = $('.user_admin_header');
      	target.toggle(200);
      	$('.messages_fix').toggle(200);
      } else if (targetData == "messages") {
      	console.log("messages");
      	var target = $('.messages_header');
      	target.toggle(200);
      	$('.user_fix').toggle(200);

      };

      var fix_height = $('.main_header').height() + target.height();


      



      if ($(this).css('opacity') == '1') {
      		$(this).css('opacity', 0.6);
      } else {
      		$(this).css('opacity', 1);
      };

      console.log(fix_height);
        return false;
    });  

});