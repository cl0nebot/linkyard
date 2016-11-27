Rails.application.routes.draw do

  get 'dashboard' => 'dashboard#index'
  get 'dashboard/sponsors' => 'dashboard#sponsors'
  get 'news' => 'news#index'

  namespace :api do
    devise_scope :user do
      post 'registrations' => 'registrations#create', :as => 'register'
      post 'sessions'      => 'sessions#create',      :as => 'login'
      delete 'sessions'    => 'sessions#destroy',     :as => 'logout'
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :links do
    collection do
      get :search
      get :digest
    end
    member do
      get :redirect
      get 'share_requests/new'
      post 'share_requests/create'
    end
  end

  resources :digests, :only => [:index, :show] do
    collection do
      get :search
      get :feed
    end
  end

  resources :messages

  get 'submit', to: "digests#submission"
  post 'submit', to: "digests#send_submission"
  get 'advertise', to: "digests#advertisement"
  post 'advertise', to: "digests#send_advertisement"
  get 'job', to: "digests#job_listing"
  post 'job', to: "digests#send_job_listing"
  get 'privacy-policy', to: "digests#privacy_policy"
  get 'spam-policy', to: "digests#spam_policy"

  resources :interactions, :only => [:index, :new, :edit, :create, :update, :destroy] do
  end

  resources :subscribers, only: [:create] do
    get :unsubscribe
    get :confirm
  end

  scope '/api' do
    resources :links, only: [:index, :show, :new, :create]
  end

  get "/linkyard", to: "home#index", as: "linkyard"
  post "/inbound_emails/mandrill", to: "inbound_emails#mandrill", as: "inbound_emails_mandrill"
  post "/inbound_emails/sendgrid", to: "inbound_emails#sendgrid", as: "inbound_emails_sendgrid"

  root :to => 'digests#home'
end
