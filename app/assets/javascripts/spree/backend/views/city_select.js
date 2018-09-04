Spree.Views.CitySelect = Backbone.View.extend({
  initialize: function() {
    this.cities = {} // null object

    this.$city_select = this.$('.js-city_id');

    // read initial values from page
    this.model.set({
      city_id: this.$city_select.val()
    })

    this.updateCities();
    this.listenTo(this.model, 'change:state_id', this.updateCities)
    this.render();
  },

  events: {
    "change .js-city_id": "onChange",
  },

  onChange: function() {
    this.model.set({
      city_id: this.$city_select.val()
    })
  },

  updateCities: function() {
    this.stopListening(this.cities);
    var state_id = this.model.get("state_id");
    if (state_id) {
      this.cities = Spree.Views.CitySelect.cityCache(state_id);
      this.listenTo(this.cities, "sync", this.render);
    }
    this.render();
  },

  render: function() {
    this.$city_select.empty().hide().prop('disabled', true);

    if (!this.model.get('state_id') || !this.cities.fetched) {
      this.$city_select.show();
    } else if (this.cities.length) {
      var $city_select = this.$city_select;
      this.cities.each(function(city) {
        $city_select.append(
          $('<option>').prop('value', city.id).text(city.get("name"))
        );
      })
      this.$city_select.val(this.model.get("city_id"))
      this.$city_select.show().prop("disabled", false);
    }
  }
})

Spree.Views.CitySelect.cityCache = _.memoize(function(state_id) {
  var cities = new Spree.Collections.Cities([], {state_id: state_id})
  cities.fetched = false;
  cities.fetch({
    success: function() {
      cities.fetched = true;
    }
  });
  return cities;
});
