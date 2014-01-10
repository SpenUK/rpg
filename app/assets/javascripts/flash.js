$(document).ready(function(){

    $(".close").on("click", function(){
      var target = $(this).parent();
      target.hide();
        return false;
    });

    function show_flash(){
    	$('.alert').show();
    }


});