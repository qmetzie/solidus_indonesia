Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_address_form_admin1',
  remove: "[data-hook='address_fields']>div:contains('country_id')"
)

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_address_form_admin2',
  remove: "[data-hook='address_fields']>div:contains('city')"
)

# Remove this for ordering sake (Zipcode should be bottom)
Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_address_form_admin3',
  remove: "[data-hook='address_fields']>div:contains('zipcode')"
)

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_hidden_field_address4',
  insert_before: "erb[loud]:contains('f.label :state_id, Spree::State.model_name.human')",
  text: %q[<%= f.hidden_field :country_id %>]
)

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_hidden_field_address5',
  insert_after: "[data-hook='address_fields']>div:contains('state_id')",
  text: %q[
    <div class="field <%= "#{type}-row" %>">
      <%= f.label :city_id, Spree::City.model_name.human %>
      <span id="<%= s_or_b %>city">
        <%= f.hidden_field :city_id, value: nil %>
        <%= f.collection_select :city_id, f.object.state ? f.object.state.cities.sort : [], :id, :name, { include_blank: true }, { class: 'custom-select fullwidth js-city_id' } %>
      </span>
    </div>
  ]
)

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address_form',
  name: 'replace_hidden_field_address6',
  insert_before: "[data-hook='address_fields']>div:contains('phone')",
  text: %q[
    <div class="field <%= "#{type}-row" %>">
      <%= f.label :zipcode %>
      <%= f.text_field :zipcode, class: 'fullwidth' %>
    </div>
  ]
)
