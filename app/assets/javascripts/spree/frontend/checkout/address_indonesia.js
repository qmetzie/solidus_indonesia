Spree.routes.cities_search = Spree.pathFor('api/cities')

Spree.ready(function($) {
  if ($("#checkout_form_address").is("*")) {

    var getStateId = function(region) {
      return $("#" + region + "state select").val();
    };

    var citiesByState = {};

    var updateCity = function(region) {
      var stateId = getStateId(region);
      if (stateId) {
        if (citiesByState[stateId] == null) {
          $.get(
            Spree.routes.cities_search,
            {
              state_id: stateId
            },
            function(data) {
              citiesByState[stateId] = {
                cities: data.cities
              };
              fillCities(region);
            }
          );
        } else {
          fillCities(region);
        }
      }
    };

    var fillCities = function(region) {
      var stateId = getStateId(region);
      var data = citiesByState[stateId];
      if (data == null) {
        return;
      }
      var cities = data.cities;
      var cityPara = $("#" + region + "city");
      var citySelect = cityPara.find("select");
      var cityInput = cityPara.find("input");
      if (cities.length > 0) {
        var selected = parseInt(citySelect.val());
        citySelect.html("");
        var citiesWithBlank = [
          {
            name: "",
            id: ""
          }
        ].concat(cities);
        $.each(citiesWithBlank, function(idx, city) {
          var opt;
          opt = $(document.createElement("option"))
            .attr("value", city.id)
            .html(city.name);
          if (selected === city.id) {
            opt.prop("selected", true);
          }
          citySelect.append(opt);
        });
        citySelect.prop("disabled", false).show();
        cityInput.hide().prop("disabled", true);
        cityPara.show();
        citySelect.addClass("required");
        cityPara.addClass("field-required");
      } else {
        citySelect.hide().prop("disabled", true);
        cityInput.show();
        cityPara.addClass("field-required");
        cityInput.addClass("required");
        cityPara.toggle(true);
        cityInput.prop("disabled", false);
        citySelect.removeClass("required");
      }
    };

    $("#bstate select").change(function() {
      updateCity("b");
    });

    $("#sstate select").change(function() {
      updateCity("s");
    });

    updateCity("b");

    var order_use_billing = $("input#order_use_billing");

    var update_shipping_form_state_city = function(order_use_billing) {
      if (!order_use_billing.is(":checked")) {
        updateCity("b");
      }
    };

    update_shipping_form_state_city(order_use_billing);
  }
});
