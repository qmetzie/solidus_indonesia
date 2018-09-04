Deface::Override.new(
  virtual_path: 'spree/admin/shared/_address',
  name: 'replace_address_admin',
  replace: "[data-hook='address']",
  text: %q[
    <%="#{address.firstname} #{address.lastname} "%><%= address.company unless address.company.blank? %><br />
    <%="#{address.phone}" %><%= address.alternative_phone unless address.alternative_phone.blank? %><br />
    <%= address.address1 %><br />
    <% if address.address2.present? %><%= "#{address.address2}" %><br /><% end %>
    <%= "#{address.city_text}, #{address.state_text}, #{address.zipcode}" %><br />
    <%= "#{address.country.name}" %>
  ]
)
