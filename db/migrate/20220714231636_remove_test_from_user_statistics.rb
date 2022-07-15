class RemoveTestFromUserStatistics < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_statistics, :test, :integer
  end
end
