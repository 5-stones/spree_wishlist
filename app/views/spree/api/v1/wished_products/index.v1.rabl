object false
node(:count) { @wished_products.count }
node(:total_count) { @wished_products.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page] || Kaminari.config.default_per_page }
node(:pages) { @wished_products.total_pages }
child(@wished_products => :wished_products) do
  extends "spree/api/v1/wished_products/show"
end
