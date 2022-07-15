class RemoveTestIdFromUserStatistics < ActiveRecord::Migration[5.2]
  def change
    remove_reference :user_statistics, :test, foreign_key: true
  end
end
