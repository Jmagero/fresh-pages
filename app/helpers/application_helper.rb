module ApplicationHelper
    
    def show_picture(article)
      rails_blob_url(article.image) if article.image.attached?
    end
  
    def check_categories(f, article, categories, submit_text)
      if article.categories.empty?
        concat(collection_select(:category, :id, categories, :id, :name, { selected: categories.first.id }))
      else
        concat(collection_select(:category, :id, categories, :id, :name, { selected: article.categories.first.id }))
      end
      if @categories.blank?
        content_tag(:h3, 'Please add category', class: 'alert-cat')
      else
        f.submit submit_text
      end
    end

    def menu_categories
      categories = Category.categories_priority.take(4)
      content_tag :div, class: 'd-flex j-content-evenly a-items-center f-grow-1' do
        categories.collect do |category|
          concat(link_to(category.name, articles_path(category), class: 'nav-links cat-navbar chivo-regular'))
        end
      end
    end

    def show_edit_icon
      return unless @article.author.id == session[:user_id]
  
      link_to(content_tag(:i, nil, class: 'far fa-edit'), edit_article_path(@article.id),
              class: 'article-vote')
    end
  
    def show_errors(model)
      return unless model.errors.any?
  
      concat content_tag(:div,
                         content_tag(:h2,
                                     pluralize(model.errors.count, 'error') + ' not allowed to complete the operation'),
                         id: 'error_explanation', class: 'd-flex a-items-center')
  
      content_tag :ul, class: 'article-vote' do
        model.errors.full_messages.each do |message|
          concat(content_tag(:li, message))
        end
      end
    end
  
    def logged_menu
      if logged_in?
        content_tag :div, class: 'd-flex j-content-evenly a-items-center nav-right' do
          concat content_tag(:h3, link_to(session[:name].to_s, user_path(session[:user_id]), class: 'nav-links'),
                             id: 'user-name')
          concat link_to('WRITE AN ARTICLE', new_article_path, class: 'nav-links')
          concat link_to('LOG OUT',  logout_path, class: 'nav-links')
        end
      else
        content_tag :div, class: 'd-flex a-items-center j-content-end nav-right' do
          concat link_to('LOG IN | ', login_path, class: 'nav-links')
          concat link_to(' REGISTER', signup_path, class: 'nav-links')
        end
      end
    end


  def show_vote(article)
    if logged_in?
      vote_icon = content_tag(:i, nil, class: 'far fa-thumbs-up')
      art_vote = link_to(vote_icon, article_votes_path(article_id: article.id),
                         class: 'article-vote', method: :post)
    else
      art_vote = content_tag(:i, nil, class: 'far fa-thumbs-up')
    end
    art_vote
  end

  def user?
    edit_icon = content_tag(:i, nil, class: 'fas fa-user-edit')
    delete_icon = content_tag(:i, nil, class: 'fas fa-user-times')
    edit_link = link_to(edit_icon, edit_user_path(@user), class: 'article-vote',
                                                          id: 'user-edit')
    delete_link = link_to(delete_icon, user_path(@user), method: :delete, data: { confirm: 'Are you sure?' },
                                                         class: 'article-vote', id: 'user-delete')

    if session[:user_id].to_s != params[:id].to_s
      content_tag(:h3, "You're not allowed to edit this user")
    else
      edit_link + delete_link
    end
  end



  def show_edit_icon
    return unless @article.author.id == session[:user_id]

    link_to(content_tag(:i, nil, class: 'far fa-edit'), edit_article_path(@article.id),
            class: 'article-vote')
  end

  def show_errors(model)
    return unless model.errors.any?

    concat content_tag(:div,
                       content_tag(:h2,
                                   pluralize(model.errors.count, 'error') + ' not allowed to complete the operation'),
                       id: 'error_explanation', class: 'd-flex a-items-center')

    content_tag :ul, class: 'article-vote' do
      model.errors.full_messages.each do |message|
        concat(content_tag(:li, message))
      end
    end
  end


    def log_in(user)
        session[:user_id] = user.id
      end
    
      def current_user
        if session[:user_id]
          @current_user ||= User.find_by(id: session[:user_id])
        end
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
    
      def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
      end
    
      def store_location
        session[:forwarding_url] = request.original_url if request.get?
      end

    def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
        end
    end
end
