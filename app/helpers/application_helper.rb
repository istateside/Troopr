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
    html = "<p class='blogname-header'><a href='#{blog_url(post.blog)}' class='blogname-link'>#{post.blog.blogname}</a>"
    if post.reblog
      blog = post.previous_blog
      html += " from <a href='#{blog_url(blog)}' class='blogname-link'>#{ blog.blogname }</a>"
    end
    html += "</p>"
    return html.html_safe
  end

  def render_note(note)
    case note.notable_type
    when 'Like'
       "<a href='#{blog_url(note.notable.blog)}'>#{note.notable.blog.blogname}</a> liked this.".html_safe
    when 'Reblog'
      <<-HTML.html_safe
      <a href='#{blog_url(note.notable.reblogger)}'>#{h(note.notable.reblogger.blogname)}</a>
     reblogged this from
     <a href='#{blog_url(note.notable.previous_blog)}'>#{note.notable.previous_blog.blogname}</a>
      HTML
    when 'Post'
      "<a href='#{blog_url(note.notable.blog)}'>#{note.notable.blog.blogname}</a> posted this.".html_safe
    end
  end

  def reblog_button(post)
    (link_to image_tag('spritesheet.png'),
      {
        controller: :posts,
        action: 'reblog',
        post_id: post.id
      },
      {
        method: :post
      }
    )
  end

  def like_button(post)
    if current_blog.has_liked?(post)
      @like = current_blog.likes.find_by_post_id(post.id)
      (link_to image_tag('spritesheet.png'),
        {
          controller: :likes,
          action: 'destroy',
          id: @like.id
        },
        {
          method: :delete
        }
      )
    else
      (link_to image_tag('spritesheet.png'),
        {
          controller: :likes,
          action: 'create',
          post_id: post.id
        },
        {
          method: :post
        }
      )
    end
  end

  def delete_button(post)
     if current_user.blogs.include?(post.blog)
       (link_to "×",
       {
         :controller => :posts,
         :action => 'destroy',
         :id => post.id
       },
       {
         method: :delete,
         class: "post-delete"
        }
      )
    end
  end

  def follow_button(blog)
    if current_blog.is_following?(blog)
    	button_to "Unfollow", {:controller => :follows, :action => 'destroy', :id => blog.id}, { method: 'delete', class: "follow-button"}
    elsif (blog != current_blog)
    	button_to "Follow", blog_follows_url(blog), { class: "follow-button" }
    end
  end

end
