$(document).ready(function(){

	var selected_skill = {label: 'Select Skill', id: null};
	var selected_item = {label: 'Select Item', id: null};
	var selected_aggr = {label: 'Select Style', id: null};

// listeners that control selection button states
$('.attack_selection').on('click', function(event){
	$(this).addClass('on').removeClass('off');
	$('.item_selection').addClass('off').removeClass('on');
	$('.skill_dropdown .label').html(selected_skill.label);
	$('.skills_container').hide(); $('.items_container').hide();
	$('.skill_dropdown').removeClass('on');
});

$('.item_selection').on('click', function(event){
	$(this).addClass('on').removeClass('off');
	$('.attack_selection').addClass('off').removeClass('on');
	$('.skill_dropdown .label').html(selected_item.label);
	$('.skills_container').hide(); $('.items_container').hide();
	$('.skill_dropdown').removeClass('on');
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
	$('.aggression_dropdown').toggleClass('on');
	$('.skills_container').hide();
	$('.items_container').hide();
	$('.skill_dropdown').removeClass('on');

	$('.aggression_container').toggle();
});

// updates variable value and dropdown label when option is selected
$('.skill_options li').on('click', function(event){
	selected_skill.label = $(this).html();
	selected_skill.id = $(this).data('id');
	$('.skill_dropdown .label').html(selected_skill.label);

});

// updates variable value and dropdown label when option is selected
$('.item_options li').on('click', function(event){
	selected_item.label = $(this).html();
	selected_item.id = $(this).data('id');
	$('.skill_dropdown .label').html(selected_item.label);

});

// updates variable value and dropdown label when option is selected
$('.aggression_options li').on('click', function(event){
	selected_aggr.label = $(this).html();
	selected_aggr.id = $(this).data('id');
	$('.aggression_dropdown .label').html(selected_aggr.label);

});


$('.go_button').on('click', function(event){
	console.log(selected_skill);
});

function turn_request() {
		$.ajax({
			url: "/items/equip/"+ id, 
			type: "POST",
			datatype : 'json',
			data:{
						target_slot: type,
						target_slot_id: slot,
						inventory_item: id,
						action: 'equip',
						controller: 'items' },
			success: function(response){

				}	

			});
	}



});