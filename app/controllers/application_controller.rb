class ApplicationController < ActionController::API
  # 既存の予約とダブらないようにスタイリストと埋まっている時間の組み合わせを取得するメソッド
  def get_start_finish_time
    reserveds = Appointment.joins(:menus).select('appointments.id, appointments.stylist_id, appointments.appointment_on, menus.time').order(:id)

    # 予約日時から作業終了までの時間を算出
    reserveds.map{|reserved|
      start_time = reserved.appointment_on
      # menus.timeで帰ってくる時間がUTCだったので、日本時間にコンバートする
      menu_time = reserved.time.in_time_zone('Tokyo')
      menu_time_hour = menu_time.hour
      menu_time_minutes = menu_time.min
      # 予約時間から所要時間分進めることで、終わりの時間を取得
      finish_time = start_time.advance(hours: menu_time_hour, minutes: menu_time_minutes)
      # スタイリストid及び作業開始時刻と終了時間をd返す
      { id: reserved.id, stylist_id: reserved.stylist_id, start_time: start_time, finish_time: finish_time }
    }
  end
end
