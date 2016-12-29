module ApplicationHelper

  def full_title(page)
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page
      page + ' | ' + base_title
    else
      page
    end
  end

  def is_logged_in?
    !session[:user_id].nil?
  end
end
