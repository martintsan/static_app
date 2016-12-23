Rails.application.routes.draw do
  %w[home help about contact].each do |page|
    get "static_pages/#{page}"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
