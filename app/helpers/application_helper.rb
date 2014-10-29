module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
    <input
      name="authenticity_token"
      value="#{form_authenticity_token}"
      type="hidden">
    HTML
  end
  
  def post_byline(post)
    html = "<p class='username-header'><a href='#{user_url(post.user)}' class='username-link'>#{post.user.username}</a>"
    if post.reblog
      user = post.previous_user
      html += " from <a href='#{user_url(user)}' class='username-link'>#{ user.username }</a>"
    end
    html += "</p>"
    return html.html_safe
  end
    
  def reblog_button(post)
    (button_to "Reblog", post_reblog_url(post))
  end
  
  def like_button(post)
    if current_user.has_liked?(post)
      @like = current_user.likes.find_by_post_id(post.id)
      (button_to "Unlike", { :controller => :likes, :action => 'destroy', :id => @like.id }, {method: 'delete', class: 'unlike'} )
    else
      (button_to "Like", { :controller => :likes, :action => 'create', :post_id => post.id })
    end
  end
  
  def follow_button(user)
    if current_user.is_following?(user)
    	button_to "Unfollow", {:controller => :follows, :action => 'destroy', :id => @user.id}, method: 'delete'
    elsif (user != current_user)
    	button_to "Follow", user_follows_url(user)
    end
  end
  
end
