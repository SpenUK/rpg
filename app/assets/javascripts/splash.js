$(document).ready(function(){

	function hidey() {
		$("#lightbox").animate({top:-1000}, 400);
		$(".lightbox_dim").animate({opacity:0}, 400, function() {$("#lightbox").css({ display: "none" });});
	}

	function showey() {
		$("#lightbox").css({ display: "block" });
		$("#lightbox").animate({top:0}, 600);
		$(".lightbox_dim").animate({opacity:0.8}, 600);
	}

	$("#lightbox").css({ top: -1000 });

	if ($('#lightbox').data('content') == "world") {

		$('.header_wrap').animate({top:-100}, 800);

		showey();

	 $('.lightbox_dim').on("click", function(){   
    	hidey();
    	$('.header_wrap').animate({top:0, opacity:"show"}, 400);
  	});
	
	};
	
});