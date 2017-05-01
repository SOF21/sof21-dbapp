Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :menu
      resources :pages do
        get 'find(/:category)(/:page)', action: 'find', on: :collection
      end
      resources :orchestra do
        get 'all_signups', action: 'all_signups', on: :member
        collection do
          get 'item_summary', action: 'item_summary'
          get 'extra_performances', action: 'extra_performances'
          get 'anniversary', action: 'anniversary'
          get 'allergies', action: 'allergies'
        end
      end
      resources :orchestra_signup do
        get 'verify', action: 'verify_code', on: :collection
      end
      resources :article
      resources :users
      resources :cortege
      resources :case_cortege
      resources :payments
      resources :shopping_product
      resources :user_groups do
        post 'modify_membership', action: 'modify_membership', on: :member
      end

      resources :funkis
      resources :funkis_shift do
        get 'export_applications', on: :collection
      end
      resources :funkis_application
      resources :cortege_membership do
        get 'cortege/:id', action: 'show_cortege_members', on: :collection
        get 'case_cortege/:id', action: 'show_case_cortege_members', on: :collection
      end
      resources :order
      resources :order_item do
        get 'all_items', action: 'all_items', on: :collection
      end

      scope '/cart' do
        get '/', to: 'shopping_cart#show'
        delete '/', to: 'shopping_cart#clear'
        put '/item', to: 'shopping_cart#add_item'
        delete '/item/:id', to: 'shopping_cart#delete_item'
      end

      scope '/store' do
        post '/charge', to: 'payment#charge'
      end

      get 'user', to: 'users#show'
    end
  end

  # Let’s encrypt
  get '/.well-known/acme-challenge/:id' => 'lets_encrypt#challenge', as: :letsencrypt_challenge

end
