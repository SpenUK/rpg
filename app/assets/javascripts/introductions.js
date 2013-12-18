$(document).ready(function(){

	function hidey() {
		$("#lightbox").animate({top:-1000}, 400);
		$(".lightbox_dim").animate({opacity:0}, 400, function() {$("#lightbox").css({ display: "none" });});
	}

	$.fn.animateBG = function(x, y, speed) {
    var pos = this.css('background-position').split(' ');
    this.x = pos[0] || 0,
    this.y = pos[1] || 0;
    $.Animation( this, {
        x: x,
        y: y
      }, { 
        duration: speed
      }).progress(function(e) {
          this.css('background-position', e.tweens[0].now+'px '+e.tweens[1].now+'px');
    });
    return this;
}

	$('.splash_button').on("click", function(){   

		var scene = $('.intro_scene_panel');
    	
    	if ($(this).data("progression") == "intro") {

    		$(".intro_welcome_panel").animate({opacity:0}, 100, function() {$(".intro_welcome_panel").css({ display: "none" });});
    		$(".intro_danger_panel").show();
    		scene.animateBG(0,-400, 900).animate({opacity:1}, 900, function() {$(".intro_danger_panel").animate({opacity:1}, 200);});

    	} else if ($(this).data("progression") == "danger") {

    		$(".intro_danger_panel").animate({opacity:0}, 100, function() {$(".intro_danger_panel").css({ display: "none" });});
    		$(".intro_shop_panel").show();
    		scene.animateBG(0,-600, 900).animate({opacity:1}, 900, function() {$(".intro_shop_panel").animate({opacity:1}, 200);});

    	} else if ($(this).data("progression") == "shop") {

    		$(".intro_shop_panel").animate({opacity:0}, 100, function() {$(".intro_shop_panel").css({ display: "none" });});
    		$(".intro_home_panel").show();
    		scene.animateBG(0,-600, 900).animate({opacity:1}, 900, function() {$(".intro_home_panel").animate({opacity:1}, 200);});

    	} else if ($(this).data("progression") == "home") {

    		$(".intro_home_panel").animate({opacity:0}, 100, function() {$(".intro_home_panel").css({ display: "none" });});
    		$(".intro_done_panel").show();
    		scene.animateBG(0,-600, 900).animate({opacity:1}, 900, function() {$(".intro_done_panel").animate({opacity:1}, 200);});

    	} else if ($(this).data("progression") == "done") {

    		$(".intro_done_panel").animate({opacity:0}, 100, function() { hidey(); $('.header_wrap').animate({top:0, opacity:"show"}, 400);});

    	};  	
  });




});