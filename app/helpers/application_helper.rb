module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
    <input
      name="authenticity_token"
      value="#{form_authenticity_token}"
      type="hidden">
    HTML
  end
  
  def like_button(post)
    if current_user.has_liked?(post)
      @like = current_user.likes.find_by_post_id(post.id)
      (button_to "Unlike", { :controller => :likes, :action => 'destroy', :id => @like.id }, method: 'delete' )
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
