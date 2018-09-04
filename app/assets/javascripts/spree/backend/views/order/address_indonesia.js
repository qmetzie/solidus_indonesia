Spree.Views.Order.AddressIndonesia = Backbone.View.extend({
  initialize: function(options) {
    // read initial values from page
    this.onChange();

    this.render();
    this.listenTo(this.model, "change", this.render);

    this.citySelect =
      new Spree.Views.CitySelect({
        model: this.model,
        el: this.$el
      });
  },

  events: {
    "change": "onChange",
  },

  onChange: function() {
    this.model.set(this.getValues());
  },

  eachField: function(callback){
    var view = this;
    var fields = ["firstname", "lastname", "company", "address1", "address2",
      "zipcode", "phone", "country_id"];
    _.each(fields, function(field) {
      var el = view.$('[name$="[' + field + ']"]');
      if (el.length) callback(field, el);
    });
  },

  getValues: function() {
    var attributes = {};
    this.eachField(function(name, el) {
      attributes[name] = el.val();
    });
    return attributes;
  },

  render: function() {
    var model = this.model;
    this.eachField(function(name, el) {
      el.val(model.get(name))
    })
  }
});
