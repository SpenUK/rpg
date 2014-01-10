$(document).ready(function(){

    $(".close").on("click", function(){
      var target = $(this).parent();
      target.hide();
        return false;
    });

    function show_flash(){
    	$('.alert').show();
    }

  jQuery.error_message = function error_message(message, read_delay){
		read_delay = read_delay || 800;
    var shade = $('.alert_container');
    var messageDiv = $('.alert_body');
    $(messageDiv).html(message);

    shade.show();
    shade.filter(':not(:animated)').animate({opacity:1}, 400);
    messageDiv.filter(':not(:animated)').animate({top:100}, 600, 'easeOutBack', function(){
      messageDiv.delay(read_delay).animate({top:180}, 400, 'easeOutBack');
        shade.delay(read_delay).animate({opacity:0}, 300, function(){
          shade.hide();
          messageDiv.css('top', 320);
        });
    });
	};

});