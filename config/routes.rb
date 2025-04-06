Rails.application.routes.draw do
  devise_for :users

  root "events#index"

  resources :users, only: [ :show ]
  resources :events
  resources :event_attendances, only: [ :create ]

  delete "events/:event_id/unattend", to: "event_attendances#destroy", as: :unattend_event
end
