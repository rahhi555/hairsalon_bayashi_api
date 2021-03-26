# frozen_string_literal: true

module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: %i[show update destroy]

      # GET /appointments
      def index
        appointments =
          Appointment
          .joins(:stylist)
          .select('appointments.id,appointments.remark,stylists.name AS stylist_name')
          .order(:id)

        already_apo_times = get_start_finish_time
        
        @union_appointments = []
        
        appointments.each do |apo|
          tmp = already_apo_times.find_all {|apo_time| apo_time[:id] == apo[:id] }
          new_apo = { appointment: apo, start_end_time: tmp }
          @union_appointments.push(new_apo)
        end
        
        render json: { union_appointments: @union_appointments }
      end

      # GET /appointments/1
      def show
        render json: @appointment
      end

      # POST /appointments
      def create
        @appointment = Appointment.new(appointment_params)
        menu = Menu.find_by!(menu_id_params)

        @appointment.menus << menu
        if @appointment.save!
          render json: @appointment, status: :created, location: api_v1_appointment_url(@appointment.id)
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /appointments/1
      def update
        if @appointment.update(appointment_params)
          render json: @appointment
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /appointments/1
      def destroy
        @appointment.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:customer_id, :stylist_id, :appointment_on, :remark)
      end

      # createで新規追加する際、リレーション先のmenuも追加するためのparams
      def menu_id_params
        params.require(:menu_id).permit(:id)
      end
    end
  end
end
