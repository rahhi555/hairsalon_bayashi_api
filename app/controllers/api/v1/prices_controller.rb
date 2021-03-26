module Api
  module V1
    class PricesController < ApplicationController
      before_action :set_price, only: [:show, :update, :destroy, :order_stylists]

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

      # GET /prices/base 基準金額のメニュー
      def base
        # 一番低いランクの料金が基準値なので、最低ランクのidを取得
        lowest_rank = Rank.order(name: :desc).pluck(:id).first
        # メニューのうち最低ランクの料金との組み合わせを取得
        @prices = Price
                  .joins(:menu)
                  .where('prices.rank_id' => lowest_rank)
                  .select('prices.id, menus.name, menus.time, prices.price')

        render json: @prices
      end

      # GET /prices/order_stylist 予約時のスタイリスト選択
      def order_stylists
        # application_controllerのメソッド。全スタイリストの予約済みの作業開始時間と終了時間が帰ってくる。   
        already_apo_times = get_start_finish_time
        
        # 予約希望時間をクエリパラメータで受け取る。Time.parseで変換しないと比較できないので注意
        new_apo_on = Time.parse(params[:appointmentOn])
        
        # 予約希望時間と現在の予約を比較して、対応不可能なスタイリストのidを返す(最後にcompactを入れないとnilが入ってしまう)。
        free_stylists = already_apo_times.map{|apo|
          next unless new_apo_on.between?(apo[:start_time], apo[:finish_time])
          apo[:stylist_id]
        }.compact
        # もしfree_stylistsが空配列ならば後のNOT IN で該当なしになってしまうので、空文字を代入する
        free_stylists = '' if free_stylists.empty?
        
        # メニューはprice.idを渡された時点で確定
        @menu_id = @price.menu_id

        # メニューに対する予約可能なスタイリスト名、ランク、指名料を取得
        @order_stylists =
        Rank
        .joins(:stylists, :prices)
        .where("prices.menu_id = ? AND stylists.id NOT IN (?)",@menu_id, free_stylists)
        .select('stylists.id, stylists.name AS stylist_name, ranks.name AS rank_name, prices.price AS price')
        
        render json: { 
          order_stylists: @order_stylists,
          menu_id: @menu_id
        }
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