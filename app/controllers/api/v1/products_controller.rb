module Api
  module V1
    class ProductsController < ApplicationController
      def index
        @products = Product.all
        # respond_to :json
        # respond_to :html, :json
        respond_to do |format|
          format.html
          format.json { render json: @products }
        end
      end

      def new
        @product = Product.new
      end

      def create
        product = Product.new(product_params)
        if product.save
         json_response(product, :created)
        else
          @error = {error: product.errors.full_messages}
          json_response(@errors, 422)
        end
      end

      def edit
        @product = Product.find(params[:id])
      end

      def update
        # product = Product.update(params[:id], product_params)
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: {
            status: 200
          }
        else
          render json: {
            status: 422,
            errors: product.errors
          }
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.destroy
        render json: {
          status: 204
        }
      end

      private
        def product_params
          params.require(:product).permit(:name, :price)
        end
    end
  end
end
