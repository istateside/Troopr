module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
    <input
      name="authenticity_token"
      value="#{form_authenticity_token}"
      type="hidden">
    HTML
  end
  
  def follow_button(user)
    if current_user.is_following?(user)
    	button_to "Unfollow", {:controller => :follows, :action => 'destroy', :id => @user.id}, :method => :delete
    elsif (user != current_user)
    	button_to "Follow", user_follows_url(user)
    end
  end
  
end
