# frozen_string_literal: true

module Api
  module V1
    class MenusController < ApplicationController
      before_action :set_menu, only: %i[show update destroy]

      # GET /menus
      def index
        @menus = Menu.all
        
        render json: @menus
      end
      
      # GET /menus/base 基準金額のメニュー
      def base
        # 一番低いランクの料金が基準値なので、最低ランクのidを取得
        lowest_rank = Rank.order(name: :desc).pluck(:id).first
        # メニューのうち最低ランクの料金との組み合わせを取得
        @menus = Menu.joins(:prices).where('prices.rank_id' => lowest_rank).select('menus.*, prices.price')

        render json: @menus
      end

      # GET /menus/1
      def show
        render json: @menu
      end

      # POST /menus
      def create
        @menu = Menu.new(menu_params)
        # ランクに紐付いたすべての中間テーブルを作成するために全id取得
        rank_ids = Rank.ids
        # priceを全ランク分作成する
        price_builds = rank_ids.map{ |rank_id| @menu.prices.build(rank_id: rank_id) }

        if @menu.save
          render json: @menu, status: :created, location: api_v1_menu_url(@menu.id)
        else
          render json: @menu.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /menus/1
      def update
        if @menu.update(menu_params)
          render json: @menu
        else
          render json: @menu.errors, status: :unprocessable_entity
        end
      end

      # DELETE /menus/1
      def destroy
        @menu.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_menu
        @menu = Menu.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def menu_params
        params.require(:menu).permit(:name, :code, :time)
      end
    end
  end
end
