$(document).ready(function(){

	var item = null;
	var isDown = false;

	var currentMousePos = { x: -1, y: -1 };
    $(document).mousemove(function(event) {
        currentMousePos.x = event.pageX;
        currentMousePos.y = event.pageY;
    });

	$('.slot .item_holder').on("mouseup", function(event){
		console.log('up');
		self = $(this);

		if (item != null) {
			self.css('background-image', 'url('+ item +')');
			console.log(self);
		}
		
	});

	$(document).on("mouseup", function(event){ 
		console.log('release');
		$('.draggable').css('background-image', 'none');
		item = null;
	});

	$(document).on("mousemove", function(event){
		if (item != null) {
			$('.draggable').offset({top: currentMousePos.y - 50, left: currentMousePos.x - 50});
		} else {
			$('.draggable').offset({top: 0, left: 0});
		}
	})

		$('.item_image_tag').on("mousedown", function(event){
			var image = this.src;
			console.log('down');
			event.preventDefault();
				$(window).mousemove(function(){
					console.log('dragging');
					item = image;
					$('.draggable').css('background-image', 'url(' + image + ')');
					$(window).unbind("mousemove");
				});
		});

		// .clone().appendTo('.draggable').offset({top: currentMousePos.y, left: currentMousePos.x});
		// .attr("src").replace







});