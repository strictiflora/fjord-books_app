# frozen_string_literal: true

module CommentsHelper
  def name_or_email(comment)
    comment.user.name.blank? ? comment.user.email : comment.user.name
  end
end
