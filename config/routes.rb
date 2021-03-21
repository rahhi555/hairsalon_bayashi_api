Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      # 基準料金を求めるルート
      resources :prices do
        collection do
          get 'base'
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
