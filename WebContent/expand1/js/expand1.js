function colexpand(colId) {
	//$('.panel_ed-heading').click(function () {
	
	//getting the next element
	$content = $('#content_ed_' + colId);
	//open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
	$content.slideToggle(500, function () {
		//console.debug($content.is(":visible") ? "expand" : "collapse");
	});
}
	//});
/*	$(".panel-heading_ed").click(function () {

    $header = $(this);    
    //getting the next element
    $content = $header.next();
    //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
    $content.slideToggle(500, function () {
        //execute this after slideToggle is done
        //change text of header based on visibility of content div
        /*$header.text(function () {
            //change text based on condition
            return $content.is(":visible") ? "Collapse" : "Expand";
        });*/
  //  });

//	});
//});
function subcolexpand(colId,subcol){
	$content = $('#subcontent_ed_'+colId+"_"+subcol);
	$content.slideToggle(500, function () {
	});
}
$(function() {
	$(".panel-heading_ed").click(function () {
	    $header = $(this);    
	    //getting the next element
	    $content = $header.next();
	    //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
	    $content.slideToggle(500, function () {
	        //execute this after slideToggle is done
	        //change text of header based on visibility of content div
	        /*$header.text(function () {
	            //change text based on condition
	            return $content.is(":visible") ? "Collapse" : "Expand";
	        });*/
	    });
	});
});