Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    post '/free_atlanta_move/home_form_submission'
  end
end
