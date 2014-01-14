$(document).ready(function(){

	var skill_or_item;
	var intervalTime = 600000;
	var responsePending = false;
	var noResponse = true;
	var wait_timeout;


	var selected_skill = {label: 'Select Skill', id: null};
	var selected_item = {label: 'Select Item', id: null};
	var selected_aggr = {label: 'Select Style', id: null};

	// listeners that control selection button states
	$('.attack_selection').on('click', function(event){
		skill_or_item = "skill";

		$(this).addClass('on').removeClass('off');
		$('.item_selection').addClass('off').removeClass('on');
		$('.skill_dropdown .label').html(selected_skill.label);
		$('.skills_container').hide(); $('.items_container').hide();
		$('.skill_dropdown').removeClass('on');
		$('.aggression_dropdown').removeClass('disabled');
	});

	$('.item_selection').on('click', function(event){
		skill_or_item = "item";

		$(this).addClass('on').removeClass('off');
		$('.attack_selection').addClass('off').removeClass('on');
		$('.skill_dropdown .label').html(selected_item.label);
		$('.skills_container').hide(); $('.items_container').hide();
		$('.skill_dropdown').removeClass('on');
		$('.aggression_dropdown').addClass('disabled');
	});

	$('.skill_dropdown .label').on('click', function(event){
		//determines function based on which button is 'on', skill is default.
		$('.skill_dropdown').toggleClass('on');
		$('.aggression_container').hide();
		$('.aggression_dropdown').removeClass('on');

		if ($('.item_selection').hasClass('on')) {
			$('.items_container').toggle();
			$('.skills_container').hide();
		} else {
			$('.skills_container').toggle();
			$('.items_container').hide();
		}
	});

	$('.aggression_dropdown .label').on('click', function(event){
		if (skill_or_item != 'item') {
			$('.aggression_dropdown').toggleClass('on');
			$('.skills_container').hide();
			$('.items_container').hide();
			$('.skill_dropdown').removeClass('on');

			$('.aggression_container').toggle();
		} else {

			$.error_message("Attack Style only applies to skills, not items.", 'error');
		};
	});

	// updates variable value and dropdown label when option is selected
	$('.skill_options li').on('click', function(event){
		selected_skill.label = $(this).html();
		selected_skill.id = $(this).data('id');
		$('.skill_dropdown .label').html(selected_skill.label).parent().removeClass('on');;
		$('.skills_container').hide(240);

	});

	// updates variable value and dropdown label when option is selected
	$('.item_options li').on('click', function(event){
		selected_item.label = $(this).html();
		selected_item.id = $(this).data('id');
		$('.skill_dropdown .label').html(selected_item.label).parent().removeClass('on');;
		$('.items_container').hide(240);

	});

	// updates variable value and dropdown label when option is selected
	$('.aggression_options li').on('click', function(event){
		selected_aggr.label = $(this).html();
		selected_aggr.id = $(this).data('id');
		$('.aggression_dropdown .label').html(selected_aggr.label).parent().removeClass('on');;
		$('.aggression_container').hide(240);

	});


	$('.go_button').on('click', function(event){
		turn_request();
	});

	function endBattle(){
		console.log('End Battle');
	}

	function player1Update(dmg, critical, mp_consumption){

		// set defaults for missing args
		dmg = dmg || 0;
		critical = critical || false;
		mp_consumption = mp_consumption || 0;

		// show and then fade HP / MP healed above player 1
		var player1MaxHP = window.player1_max_hp;
		var player1MaxMP = window.player1_max_mp;
		var player1CurrentHP = window.player1_current_hp;
		var player1CurrentMP = window.player1_current_mp;

		var target = $('.player1_effect_container span');
		var health_bar = $('.player_1_hud .hp_bar');
		var health_indicator = $('.player_1_hud .hp_container_bar .hp_mp_stat');
		var mp_bar = $('.player_1_hud .mp_bar');
		var mp_indicator = $('.player_1_hud .mp_container_bar .hp_mp_stat');

		if ((player1CurrentHP - dmg) <= 0){
			var updated_health = 0;
			defeated = true;
		} else {
			var updated_health = player1CurrentHP - dmg;
		}


		if ((player1CurrentMP - mp_consumption) <= 0){
			var updated_mp = 0;
			defeated = true;
		} else {
			var updated_mp = player1CurrentMP - mp_consumption;
		}

		// damage done?
		if (dmg >= 1) {
			// handles critical hit class setting		
			target.removeClass('critical_hit');
			if (critical) {
				target.addClass('critical_hit');
			};
			//sets damage amount in view
			target.html(dmg);
			// show and then fade damage done above player 2
			target.animate({bottom:55, opacity: 1}, { duration: 400, easing: 'easeOutBack' });
			target.delay(400).animate({bottom:0, opacity: 0}, { duration: 600, easing: 'easeInCubic' });

			//updates player1 health & mp bars and global variables
			//hp
			var healthPercent = (updated_health*100)/player1MaxHP;
			health_bar.animate({width: healthPercent+'%'}, { duration: (dmg*100), easing: 'easeInOutCirc' })
			window.player1_current_hp = updated_health;
			health_indicator.html(updated_health);
			//mp
			var mpPercent = (updated_mp*100)/player1MaxMP;
			mp_bar.animate({width: mpPercent+'%'}, { duration: (mp_consumption*100), easing: 'easeInOutCirc' })
			window.player1_current_mp = updated_mp;
			mp_indicator.html(updated_mp);
		}

	}

	function player2Update(dmg, critical, mp_consumption){
		// set defaults for missing args
		dmg = dmg || 0;
		critical = critical || false;
		mp_consumption = mp_consumption || 0;

		var player2MaxHP = window.player2_max_hp;
		var player2MaxMP = window.player2_max_mp;
		var player2CurrentHP = window.player2_current_hp;
		var player2CurrentMP = window.player2_current_mp;

		var target = $('.player2_effect_container span');
		var health_bar = $('.player_2_hud .hp_bar');
		var health_indicator = $('.player_2_hud .hp_container_bar .hp_mp_stat');
		var mp_bar = $('.player_2_hud .mp_bar');
		var mp_indicator = $('.player_2_hud .mp_container_bar .hp_mp_stat');
		var defeated = false;
		// change to function arg to allow mp change
		var mp_consumption = 0;
		// -------------------------
		
		if ((player2CurrentHP - dmg) <= 0){
			var updated_health = 0;
			defeated = true;
		} else {
			var updated_health = player2CurrentHP - dmg;
		}

		if ((player2CurrentMP - mp_consumption) <= 0){
			var updated_mp = 0;
			defeated = true;
		} else {
			var updated_mp = player2CurrentMP - mp_consumption;
		}

		if (dmg >= 1) {
			// handles critical hit class setting		
			target.removeClass('critical_hit');
			if (critical) {
				target.addClass('critical_hit');
			};
			//sets damage amount in view
			target.html(dmg);
			// show and then fade damage done above player 2
			target.animate({bottom:55, opacity: 1}, { duration: 400, easing: 'easeOutBack' });
			target.delay(400).animate({bottom:0, opacity: 0}, { duration: 600, easing: 'easeInCubic' });
			//updates player2 health & mp bars and global variables
			//hp
			var healthPercent = (updated_health*100)/player2MaxHP;
			health_bar.animate({width: healthPercent+'%'}, { duration: (dmg*100), easing: 'easeInOutCirc' })
			window.player2_current_hp = updated_health;
			health_indicator.html(updated_health);
			//mp
			var mpPercent = (updated_mp*100)/player2MaxMP;
			mp_bar.animate({width: mpPercent+'%'}, { duration: (mp_consumption*100), easing: 'easeInOutCirc' })
			window.player2_current_mp = updated_mp;
			mp_indicator.html(updated_mp);
		}


		// calls endBattle if player is defeated
		if (defeated) {
			endBattle();
		}
	}

	function turn_request() {

		var player1MaxHP = window.player1_max_hp;
		var player1MaxMP = window.player1_max_mp;


		if (selected_item.id == null && selected_skill.id == null) {
			$.error_message("You need to select either a skill or an item to use!", 'error', 1100);
		} else {
			$.ajax({
				url: "/take_turn/",
				type: "POST",
				datatype : 'json',
				data:{
							skill_item: skill_or_item,
							skill_id: selected_skill.id,
							item_id: selected_item.id,
							style_id: selected_aggr.id,


							action: 'battle',
							controller: 'take_turn' },
				success: function(response){
						if (response.error_msg){
							$.error_message(response.error_msg, response.error_type, response.error_delay);
						} else {
							// below should be updated to accept all 3 args in future
							player2Update(response.attrs.damage, response.attrs.critical, null);
							player1Update(null, null, response.attrs.mp_consumption);
							responsePending = true;
							wait_for_response();
							console.log(response.attrs);
						}
					}	

				});
		};
	}

	// function is to be triggered after player takes turn and skill animation is complete
	// checks that a response is due and if it is it will indicate that the player is "waiting for opponent".
	// Interval will ramp up and AJAX calls will be made to check if the opponent has made a move.
	// Returnin false if not and updating view if they have.


	function wait_for_response(){
		
			console.log('ajax request function start');
			intervalTime = 4000;
			var waiting = true;
			var turn_data;

			var ajaxy = $.ajax({
				async: false,
				url: "/opponent_check/",
				type: "POST",
				datatype : 'json',
				data:{
							action: 'battle',
							controller: 'opponent_check' },
				success: function(response){
						waiting = response.waiting_for_opponent;
						turn_data = response.turn_data;
						}
				});

			if (waiting == true){
				var wait_timeout = window.setTimeout(wait_for_response, intervalTime);				

			} else {
				console.log('else');
				console.log(turn_data);
				player1Update(turn_data.damage, turn_data.critical, null);
				player2Update(null, null, turn_data.mp_comsumption);
				responsePending = false;
				window.clearTimeout(wait_timeout);
			}
	};

});






