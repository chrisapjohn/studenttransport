//Display Submit button only when at least one ticket selected
$(document).ready(function() {

    var $submit = $("#bookTrips").hide(),
        $cbs = $("#trip_ids_").click(function() {
            $submit.toggle( $cbs.is(":checked") );
        });

});
