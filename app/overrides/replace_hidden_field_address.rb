Deface::Override.new(
  virtual_path: 'spree/address/_form_hidden',
  name: 'replace_hidden_field_address1',
  replace: "erb[loud]:contains('form.hidden_field :city')"
  text: %q[form.hidden_field :city_id]
)

Deface::Override.new(
  virtual_path: 'spree/address/_form_hidden',
  name: 'replace_hidden_field_address2',
  insert_after: "erb[loud]:contains('form.hidden_field :state_name')"
  text: %q[form.hidden_field :city_name]
)
