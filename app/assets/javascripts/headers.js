$(document).ready(function(){

    $(".header_test").on("click", function(){
   
      var target = $(this).data('expansion');

      if (target = "user") {

      	console.log('true match');
      	$('.user_admin_header').toggle();

      };

      
        return false;
    });  

});