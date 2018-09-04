Deface::Override.new(
  virtual_path: 'spree/address/_form',
  name: 'remove_country_field_address',
  remove: "div.field:contains('country_id')"
)
