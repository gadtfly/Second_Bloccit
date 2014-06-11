class FavoriteMailer < ActionMailer::Base
  default from: "arquitectolizcano@gmail.com"

  def new_comment(user, post, comment)
    @user, @post, @comment = user, post, comment  #instead of one on each line

    headers["Message-ID"] = "<comments/#{@comment.id}@secondbloccit.example>"
    headers["In-Reply_To"] = "<post/#{@post.id}@secondbloccit>"
    headers["References"] = "<post/#{@post.id}@secondbloccit>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end