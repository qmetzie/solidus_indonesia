//= require 'spree/backend/views/city_select'

Spree.ready(function() {
  "use strict";

  _.each(document.querySelectorAll('.js-addresses-form'), function(el) {
    var stateSelect = el.querySelector('.js-state_id');
    var model = new Backbone.Model({
      state_id: stateSelect.value
    });

    stateSelect.addEventListener('change', function() {
      model.set({
        state_id: stateSelect.value
      });
    });

    new Spree.Views.CitySelect({
      el: el,
      model: model
    });
  });
});
