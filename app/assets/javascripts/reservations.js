var reservation;

jQuery(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  return reservation.setupForm();
});

reservation = {
  setupForm: function() {
    return $('#new_reservation').submit(function() {
      //If no radio box (i.e. no stored Stripe User) OR use_card_1 box is checked, then disable Submit button and use JS to process
      if ($("#use_card_1").length === 0 || $("#use_card_1").is(":checked")){
        $('input[type=submit]').attr('disabled', true);
        if ($('#card_number').length) {
          reservation.processCard();
          return false;
        } else {
          $('input[type=submit]').attr('disabled', true);
          return true;
        }
      } else {
        $('input[type=submit]').attr('disabled', true);
        return true;
      }
    });
  },
  processCard: function() {
    var card;
    card = {
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val()
    };
    return Stripe.createToken(card, reservation.handleStripeResponse);
  },
  handleStripeResponse: function(status, response) {
    if (status === 200) {
      $('#reservation_stripe_card_token').val(response.id);
      return $('#new_reservation')[0].submit();
    } else {
      $('#stripe_error').text(response.error.message);
      return $('input[type=submit]').attr('disabled', false);
    }
  }
};


//Check first radio box
$(document).ready(function() {

    $('input:radio:first').attr('checked', true);

});
