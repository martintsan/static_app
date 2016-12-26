Rails.application.routes.draw do
  root 'static_pages#home'
  %w(help about contact).each do |page|
    get "/#{page}", to: "static_pages##{page}"
  end
  get '/signup', to: 'users#new'
end
