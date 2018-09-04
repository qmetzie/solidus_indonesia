Spree.routes.cities_search = Spree.pathFor('api/cities')

Spree.Collections.Cities = Backbone.Collection.extend({
  initialize: function (models, options) {
    this.state_id = options.state_id
  },

  url: function () {
    return Spree.routes.cities_search + "?state_id=" + this.state_id
  },

  parse: function(resp, options) {
    return resp.cities;
  }
})
