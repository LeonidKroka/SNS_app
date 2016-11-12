module UsersHelper
  def get_avatar user
    user.images.order('id DESC').all.each {|img| return img.avatar.path if img.avatar}
    nil
  end

  def get_nine_friends user
    user.all_friends.count < 10 ? user.all_friends : user.all_friends.limit(9)
  end

  def is_friend? user
    current_user.all_friends.include?(user)
  end

  def date_format strtime
    strtime.strftime('%B %d, %H:%M:%S')
  end

  def post_comments(user, post)
    Comment.where('CAST(user_id AS text) LIKE ? AND CAST(post_id AS text) LIKE ?', user.id.to_s, post.id.to_s)
  end

  def author comment
    User.find_by(id: comment.user_id)
  end
end
