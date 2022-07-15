class AddNumberToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_column :user_statistics, :test, :integer
  end
end
