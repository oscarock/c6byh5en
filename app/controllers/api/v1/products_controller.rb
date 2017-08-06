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
        # @product = Product.new
      end

      def create
         product = Product.new(product_params)
        if product.save
            render json: {
              status: 201,
              product: product
            }.to_json
        else
          render json: {
            status: 422,
            errors: product.errors
          }.to_json
        end
      end

      def edit
        @product = Product.find(params[:id])
      end

      def update
        @product = Product.update(params[:id], product_params)
      end

      private
        def product_params
          params.require(:product).permit(:name, :price)
        end
    end
  end
end
