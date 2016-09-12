object false
node(:count) { @wishlists.count }
node(:total_count) { @wishlists.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page] || Kaminari.config.default_per_page }
node(:pages) { @wishlists.total_pages }
child(@wishlists => :wishlists) do
  extends "spree/api/v1/wishlists/show"
end
