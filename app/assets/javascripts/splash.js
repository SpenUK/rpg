$(document).ready(function(){

	function hidey(speed) {

		speed = typeof speed !== 'undefined' ? speed : 400;

		$("#lightbox").animate({top:-1000}, speed);
		$(".lightbox_dim").animate({opacity:0}, speed, function() {$("#lightbox").css({ display: "none" });});
	}

	function showey(speed) {

		speed = typeof speed !== 'undefined' ? speed : 600;

		$("#lightbox").css({ display: "block" });
		$("#lightbox").animate({top:0}, speed);
		$(".lightbox_dim").animate({opacity:0.9}, speed);
	}

	$("#lightbox").css({ top: -1000 });

	if ($('#lightbox').data('content') == "world") {

		$('.header_wrap').animate({top:-100}, 800);

		showey();
	
	};

	$('.lightbox_dim').on("click", function(){   
    	hidey();
    	$('.header_wrap').animate({top:0, opacity:"show"}, 400);
  	});
	

	$('.item_image').on("click", function(event){   

		var self = $(this);
		var linky = self.attr('href');

		
		$.ajax({
			url: linky, 
			type: "GET",
			datatype : 'js',
			async: false,
			success: function(response){
				response_html = response;
			}

		});

		console.log(response_html)

		$('.item_splash_panel').html(response_html);

    	showey(200);

    	event.preventDefault();
  	});

});












