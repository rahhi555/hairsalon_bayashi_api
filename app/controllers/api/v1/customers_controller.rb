# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %i[show update destroy]

      # GET /customers
      def index
        if params[:uid]
          current_user = Customer.find_by(uid: params[:uid])
          render json: current_user, methods: [:image_url]
        else
          @customers = Customer.all
          render json: @customers, methods: [:image_url]
        end
      end

      # GET /customers/1
      def show
        render json: @customer, methods: [:image_url]
      end

      # POST /customers
      def create
        @customer = Customer.new(customer_params)

        if @customer.save
          render json: @customer,
                 methods: [:image_url],
                 status: :created,
                 location: api_v1_appointment_url(@customer.id)
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /customers/1
      def update
        if @customer.update(customer_params)
          render json: @customer, methods: [:image_url]
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /customers/1
      def destroy
        @customer.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def customer_params
        params.require(:customer).permit(:name, :tel, :mail, :uid, :image)
      end
    end
  end
end
