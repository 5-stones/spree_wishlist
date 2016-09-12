object false
node(:attributes) { [ :name, :is_private ] }
node(:required_attributes) { required_fields_for(Spree::Wishlist) }
