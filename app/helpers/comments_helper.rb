# frozen_string_literal: true

module CommentsHelper
  def name_or_email(comment)
    comment.user.name.presence || comment.user.email
  end
end
