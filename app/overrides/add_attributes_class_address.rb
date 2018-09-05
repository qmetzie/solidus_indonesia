Deface::Override.new(
  virtual_path: 'spree/admin/users/_addresses_form',
  name: 'add_attributes_class_address',
  add_to_attributes: "div.col-6",
  attributes: { class: 'js-addresses-form' }
)
