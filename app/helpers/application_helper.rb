module ApplicationHelper
  include SessionsHelper

  def show_picture(article)
    rails_blob_url(article.image) if article.image.attached?
  end

  def check_categories(form, article, categories, submit_text)
    if article.categories.empty?
      concat(collection_select(:category, :id, categories, :id, :name, { selected: categories.first.id }))
    else
      concat(collection_select(:category, :id, categories, :id, :name, { selected: article.categories.first.id }))
    end
    if @categories.blank?
      content_tag(:h3, 'Please add category', class: 'alert-cat')
    else
      form.submit submit_text
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

  def logged_in_user?
    return unless logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
