module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def logged_menu
    if logged_in?
      content_tag :div, class: 'd-flex j-content-evenly a-items-center nav-right' do
        concat content_tag(:h3, link_to(session[:name].to_s, user_path(session[:user_id]), class: 'nav-links'),
                           id: 'user-name')
        concat link_to('WRITE AN ARTICLE', new_article_path, class: 'nav-links')
        concat link_to('LOG OUT', logout_path, class: 'nav-links')
      end
    else
      content_tag :div, class: 'd-flex a-items-center j-content-end nav-right' do
        concat link_to('LOG IN | ', login_path, class: 'nav-links')
        concat link_to(' REGISTER', signup_path, class: 'nav-links')
      end
    end
  end
end
