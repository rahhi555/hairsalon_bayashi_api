Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :prices do
        collection do
          # 基準料金算出
          get 'base'
        end
        member do
          # 予約時スタイリスト選択
          get 'order_stylists'
        end
      end
      resources :menus
      resources :stylists
      resources :ranks
      resources :appointments
      resources :customers
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
