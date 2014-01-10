$(document).ready(function(){

	// scope variables ready for assignment through event listeners
	var dragEquipped = false;
	var ignoreDragEquipped = false;
	var equippedPos = $('.equipped_panel').offset();
	var y_offset, x_offset, item, item_id, type, parent_card, target_holder;
	// var id_regex = /(\s)*(id.*?)(?=\s)/g; 
	var id_regex = /(\b)id[1-9]+/g;

	// track mouse positions
	var currentMousePos = { x: -1, y: -1 };
    $(document).mousemove(function(event) {
        currentMousePos.x = event.pageX;
        currentMousePos.y = event.pageY;
    });

  // listener for equipment slots, checking if item variable is set before updating slot
	$('.slot .item_holder').on("mouseup", function(event){
		var self = $(this);
		var target_holder = this;
		var match = self.data('type') == type;
		var previous = ('.id'+ item_id);

		if (item != null){
			// Soft, browser side validation for item type match up.
			if (match) {
				//modifies slot_id if consumable. e.g. 'consumable' becomes 'consumable2' if dropping on second slot
				if (type == 'consumable'){
					var slot_id = self.data('id');
				} else {
					var slot_id = null
				}

				// finds and replaces slot contents if item is placed on top of another
				$(previous).css('background-image', self.css('background-image'));
				$(previous).attr('class', self.attr('class'));
				
				self.css('background-image', 'url('+ item.src +')');
				target_holder.className = target_holder.className.replace(id_regex, '') + " id"+ $(item).data('id');				
				equip_request(slot_id);
				$(parent_card).addClass('equipped');

			} else {
				// subtle visual hint that item is not complatable
				self.css('background-color', 'rgba(210,100,100,0.5)');
				self.animate({backgroundColor: 'rgba(255,255,255,0)'}, 'slow')
			}
		}
	});

	// document wide mouse-up listener to clean slate the 'draggable' effects
	$(document).on("mouseup", function(event){ 
		$('.draggable').css('background-image', 'none');
		$('.draggable').hide();
		item = null;
		dragEquipped = false;
		ignoreDragEquipped = false;
		$('body').removeClass('no_select');
		$(window).unbind("mousemove");
	});

	// Keeps the 'draggable' div inline with the cursor(centered) aswell as moving equipped div if it is being dragged
	$(document).on("mousemove", function(event){
		if (dragEquipped == true){
			$('.equipped_panel').offset({top: currentMousePos.y - y_offset, left: currentMousePos.x - x_offset});
			// no_select class disables highlighting whilst drag is process
			$('body').addClass('no_select');
		}

		if (item != null) {
			// no_select class disables highlighting whilst drag is process
			$('.draggable').offset({top: currentMousePos.y - 50, left: currentMousePos.x - 50});
			$('body').addClass('no_select');
		} else {
			$('.draggable').offset({top: 0, left: 0});
		}
	})

	// start dragging of equipped panel relative to cursor 
	$('.equipped_panel').on("mousedown", 1, function(event){
		if (event.which == 1) {
			if (ignoreDragEquipped == false){
				$(window).mousemove(function(){
					dragEquipped = true;
					y_offset = (currentMousePos.y - $('.equipped_panel').offset().top);
					x_offset = (currentMousePos.x - $('.equipped_panel').offset().left);
				});
			}
		}
	});

	// blocks the drag of the equipped panel if body is dragged allowing drag to start only if border/header is clicked
	$('.equipped_items_container').on("mousedown", 1, function(event){
		if (event.which == 1) {
			ignoreDragEquipped = true;
		}
	});

	// set image on click, start drag effect on mouse move
	$('.item_image_tag').on("mousedown", 1, function(event){
		var image = this;
		event.preventDefault();
		if (event.which == 1) {
			$(window).mousemove(function(){
				item = image;
				item_id = $(image).data('id');
				parent_card = $(image).closest('.item_card');
				type = $(item).data('type');
				$('.draggable').css('background-image', 'url(' + image.src + ')');
				$('.draggable').show();
				$(window).unbind("mousemove");
			});
		}
	});

	// AJAX to start server side validation and update process
	function equip_request(slot) {
			var id = $(item).data('id');
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