$(document).ready(function(){

	// scope variables ready for assignment through event listeners
	var item = null;
	var item_id = null;
	var type = null;
	var parent_card = null;
	var target_holder = null;
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
		item = null;
		$(window).unbind("mousemove");
	});

	// Keeps the 'draggable' div inline with the cursor(centered)
	$(document).on("mousemove", function(event){
		if (item != null) {
			$('.draggable').offset({top: currentMousePos.y - 50, left: currentMousePos.x - 50});
		} else {
			$('.draggable').offset({top: 0, left: 0});
		}
	})

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
	//----------------------------------------------
	//--------- Draggable equip div ----------------



});