# frozen_string_literal: true

module Api
  module V1
    class StylistsController < ApplicationController
      before_action :set_stylist, only: %i[show update destroy]

      # GET /stylists
      def index
        if params[:uid]
          current_user = Stylist.find_by(uid: params[:uid])
          render json: current_user
        else
          @stylists = Stylist.left_outer_joins(:rank).select('stylists.*, ranks.name AS ranks_name')
          render json: @stylists
        end
      end

      # GET /stylists/1
      def show
        render json: @stylist
      end

      # POST /stylists
      def create
        @stylist = Stylist.new(stylist_params)

        if @stylist.save
          render json: @stylist, status: :created, location: api_v1_stylist_url(@stylist.id)
        else
          render json: @stylist.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /stylists/1
      def update
        if @stylist.update(stylist_params)
          render json: @stylist
        else
          render json: @stylist.errors, status: :unprocessable_entity
        end
      end

      # DELETE /stylists/1
      def destroy
        @stylist.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_stylist
        @stylist = Stylist.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def stylist_params
        params.require(:stylist).permit(:rank_id, :name, :is_male, :nickname, :hire_on,
                                        :uid, :mail, :tel)
      end
    end
  end
end
