$(document).ready(function(){

	var skill_or_item

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

		$.error_message("Attack Style only applies to skills, not items.");
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

function turn_request() {

	if (selected_item.id == null && selected_skill.id == null) {
		$.error_message("You need to select either a skill or an item to use!", 1100);
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
						$.error_message(response.error_msg, response.error_delay);
					} else {
						player2_hit(40);
					}
				}	

			});
	};
}


});