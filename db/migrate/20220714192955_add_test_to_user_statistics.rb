class AddTestToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_statistics, :test, foreign_key: true
  end
end
