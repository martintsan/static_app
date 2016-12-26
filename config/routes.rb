Rails.application.routes.draw do
  %w[help about contact].each do |page|
    get "/#{page}", to: "static_pages##{page}"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
