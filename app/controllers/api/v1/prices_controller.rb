module Api
  module V1
    class PricesController < ApplicationController
      before_action :set_price, only: [:show, :update, :destroy]

      # GET /prices
      def index
        # メニュー、料金及びランクの一覧表を取得する
        sql = <<-"EOS"
                SELECT
                  menus.id AS menu_id,
                  menus.name AS menu_name,
                  ranks.id AS rank_id,
                  ranks.name AS rank_name,
                  prices.id AS price_id,
                  prices.price AS price
                FROM
                  menus
                LEFT JOIN prices ON menus.id = prices.menu_id
                LEFT JOIN ranks ON ranks.id = prices.rank_id
                ORDER BY menu_name, rank_name
              EOS
        @prices = ActiveRecord::Base.connection.select_all(sql)

        render json: @prices
      end

      # GET /prices/1
      def show
        render json: @price
      end

      # POST /prices
      def create
        @price = Price.new(price_params)

        if @price.save
          render json: @price, status: :created, location: api_v1_price_url(@price.id)
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /prices/1
      def update
        if @price.update(price_params)
          render json: @price
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      # DELETE /prices/1
      def destroy
        @price.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_price
          @price = Price.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def price_params
          params.require(:price).permit(:rank_id, :menu_id, :price)
        end
    end
  end
end