# frozen_string_literal: true

class ChangeColumnOnComments2 < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :user_id, false
  end
end
