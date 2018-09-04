# Remove for ordering sake (State should be top first)
Deface::Override.new(
  virtual_path: 'spree/address/_form',
  name: 'replace_city_field_address',
  remove: "div.field:contains('city')"
)

Deface::Override.new(
  virtual_path: 'spree/address/_form',
  name: 'remove_country_field_address2',
  insert_after: "div.field:contains('state_id')",
  text: %q[
  <div class="field field-required" id=<%="#{address_id}city" %>>
    <%= form.label :city, t('spree.city') %>

    <span class="js-address-fields" style="display: none;">
      <%=
        form.collection_select(
          :city_id, address.state ? address.state.cities.sort : [], :id, :name,
          {include_blank: true},
          {
            class: 'required',
            autocomplete: address_type + ' address-level1',
          })
        %>
      </span>
  </div>
  ]
)
