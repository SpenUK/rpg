$(document).ready(function(){

	function showMore(target) {
		$(target).toggle(200);
	}

	function hideHeader() {

	}

	function showHeader() {
		
	}

	function showStatsInHeader(){


		var linky = self.attr('href');
		$.ajax({
			url: linky, 
			type: "GET",
			datatype : 'text json',
			async: false,
			success: function(response){
				response_html = response;
			}

		});



	}
    
		$('.header_icon').on("click", function(){
   
      var targetData = $(this).data('expansion');

      if (targetData == "user") {

      	var target = $('.user_admin_header');
      	target.toggle(200);
      	$('.user_fix').toggle(200);
      	$('.messages_fix').hide(200);
      	$('.messages_header').hide(200);
      	$('.header_icon').css('opacity', 0.6);

      	return false;
      } else if (targetData == "messages") {
      	var target = $('.messages_header');
      	target.toggle(200);
      	$('.messages_fix').toggle(200);
      	$('.user_fix').hide(200);
      	$('.user_admin_header').hide(200);
      	$('.header_icon').css('opacity', 0.6);

      	return false;
      };

      // if ($(this).css('opacity') == 0.8) {
      // 		$(this).css('opacity', 1);
      // } else {
      // 		$(this).css('opacity', 0.6);
      // };

        
    });  

		$('.message_summary').on("click", function(){
			
		var target = $(this).parent().children('.message_body');
		var targetImg = $(this).children('.arrow');

		targetImg.toggle();

			showMore(target);
			return false;

		}
		);

		$('.filter_sent').on("click", function(){
			$('.messages_panel').children('.received').hide();
			$('.messages_panel').children('.sent').show();
			return false;
		});

		$('.filter_received').on("click", function(){
			$('.messages_panel').children('.sent').hide();
			$('.messages_panel').children('.received').show();
			return false;
		});

		$('.filter_battles').on("click", function(){
			$('.messages_panel').children('.private').hide();
			$('.messages_panel').children('.battle_req').show();
			return false;
		});

		$('.filter_private').on("click", function(){
			$('.messages_panel').children('.battle_req').hide();
			$('.messages_panel').children('.private').show();
			return false;
		});





});