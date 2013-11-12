//Enable Submit button only when at least one ticket selected
$(document).ready(function() {

    var $submit = $("#bookTrips").attr("disabled", "disabled");

    $(":checkbox").change(function() {

    	if($(":checkbox:checked").length) {
    		$submit.removeAttr("disabled");
    	} else {
    		$submit.attr("disabled", "disabled");
    	};

    });

});
