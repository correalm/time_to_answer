class RemoveAnswerFromUserStatistics < ActiveRecord::Migration[5.2]
  def change
    remove_reference :user_statistics, :answer, foreign_key: true
  end
end
