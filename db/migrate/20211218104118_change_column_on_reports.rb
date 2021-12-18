# frozen_string_literal: true

class ChangeColumnOnReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :user_id, false
  end
end
