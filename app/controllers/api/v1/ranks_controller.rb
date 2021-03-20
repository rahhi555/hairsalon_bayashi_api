# frozen_string_literal: true

module Api
  module V1
    class RanksController < ApplicationController
      before_action :set_rank, only: %i[show update destroy]

      # GET /ranks
      def index
        @ranks = Rank.all

        render json: @ranks
      end

      # GET /ranks/1
      def show
        render json: @rank
      end

      # POST /ranks
      def create
        @rank = Rank.new(rank_params)
        # メニューに紐付いたすべての中間テーブルを作成するために全id取得
        menu_ids = Menu.ids
        #　pricesを全メニュー分作成する
        price_builds = menu_ids.map{ |menu_id| @rank.prices.build(menu_id: menu_id) }

        if @rank.save
          render json: @rank, status: :created, location: api_v1_rank_url(@rank.id)
        else
          render json: @rank.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /ranks/1
      def update
        if @rank.update(rank_params)
          render json: @rank
        else
          render json: @rank.errors, status: :unprocessable_entity
        end
      end

      # DELETE /ranks/1
      def destroy
        @rank.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_rank
        @rank = Rank.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def rank_params
        params.require(:rank).permit(:name)
      end
    end
  end
end
