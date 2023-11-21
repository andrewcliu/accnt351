Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#index'

  post 'static/file_upload' => 'static#file_upload'
  get 'static/results' => 'static#results'
end
