module ApplicationHelper

  def full_title(page)
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page
      page + ' | ' + base_title
    else
      page
    end
  end
end
