object @wishlist
cache [I18n.locale, root_object]

attributes :id, :name, :access_hash, :is_private, :is_default, :created_at, :updated_at

child :wished_products => :wished_products do
  extends "spree/api/v1/wished_products/show"
end
