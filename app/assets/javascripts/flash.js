$(document).ready(function(){

    $(".close").on("click", function(){
      var target = $(this).parent();
      target.hide();
        return false;
    });

    function show_flash(){
    	$('.alert').show();
    }

  jQuery.error_message = function error_message(message, type, read_delay){
		read_delay = read_delay || 800;
    type = type || 'error';
    var shade = $('.alert_container');
    var body = $('.alert_body');
    $(body).attr('class', 'alert_body');
    $(body).addClass(type);
    $(body).html(message);

    shade.show();
    shade.filter(':not(:animated)').animate({opacity:1}, 400);
    body.filter(':not(:animated)').animate({top:100}, 600, 'easeOutBack', function(){
      body.delay(read_delay).animate({top:180}, 400, 'easeOutBack');
        shade.delay(read_delay).animate({opacity:0}, 300, function(){
          shade.hide();
          body.css('top', 320);
        });
    });
	};

});