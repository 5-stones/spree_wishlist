module Spree
  module Api
    module V1
      class WishedProductsController < Spree::Api::BaseController

        def index
          @wished_products = Spree::WishedProduct.all
          if params[:wishlist_id]
            @wished_products = @wished_products.where(wishlist_id: params[:wishlist_id])
          end

          @wished_products = @wished_products.distinct.page(params[:page]).per(params[:per_page])

          respond_with @wished_products
        end

        def new
        end

        def create
          if(params[:wished_product][:wishlist_id])
            @wishlist = Spree::Wishlist.find_by user: current_api_user, id: params[:wished_product][:wishlist_id]
          else
            # get default wishlist
            @wishlist = current_api_user.wishlist
          end

          authorize! :update, @wishlist

          @wished_product = Spree::WishedProduct.new(wished_product_attributes)

          if @wishlist.include? params[:wished_product][:variant_id]
            @wished_product = @wishlist.wished_products.detect { |wp| wp.variant_id == params[:wished_product][:variant_id].to_i }
          else
            @wished_product.wishlist = @wishlist
            @wished_product.save
          end

          respond_with(@wished_product, status: 201, default_template: :show)
        end

        def update
          @wished_product = Spree::WishedProduct.find(params[:id])
          authorize! :update, @wished_product

          @wished_product.update_attributes(wished_product_attributes)

          respond_with(@wished_product, status: 200, default_template: :show)
        end

        def destroy
          @wished_product = Spree::WishedProduct.find(params[:id])
          authorize! :destroy, @wished_product

          @wished_product.destroy

          respond_with(@wished_product, status: 204)
        end

        private

          def wished_product_attributes
            return params.require(:wished_product).permit(:variant_id, :wishlist_id, :remark, :quantity)
          end
      end
    end
  end
end
