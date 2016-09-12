module Spree
  module Api
    module V1
      class WishlistsController < Spree::Api::BaseController
        helper 'spree/products'

        before_action :find_wishlist, only: [:destroy, :show, :update, :edit]

        def new
        end

        def index
          @wishlists = current_api_user.wishlists.ransack(params[:q]).result.page(params[:page]).per(params[:per_page])
          respond_with(@wishlist)
        end

        def edit
          respond_with(@wishlist)
        end

        def update
          @wishlist.update_attributes wishlist_attributes
          respond_with(@wishlist, status: 200, default_template: :show)
        end

        def show
          respond_with(@wishlist)
        end

        def default
          @wishlist = current_api_user.wishlist
          respond_with(@wishlist, status: 200, default_template: :show)
        end

        def create
          @wishlist = Spree::Wishlist.new wishlist_attributes
          @wishlist.user = current_api_user
          @wishlist.save
          respond_with(@wishlist, status: 201, default_template: :show)
        end

        def destroy
          @wishlist.destroy
          respond_with(@wishlist) do |format|
            format.html { redirect_to account_path }
          end
        end

        private

        def wishlist_attributes
          params.require(:wishlist).permit(:name, :is_default, :is_private)
        end

        # Isolate this method so it can be overwritten
        def find_wishlist
          @wishlist = Spree::Wishlist.find_by_access_hash!(params[:id])
        end

      end
    end
  end
end
