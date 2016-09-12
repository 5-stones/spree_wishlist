object false
node(:attributes) { [ :variant_id, :remark, :quantity ] }
node(:required_attributes) { required_fields_for(Spree::WishedProduct) }
