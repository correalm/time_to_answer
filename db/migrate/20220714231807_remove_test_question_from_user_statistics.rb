class RemoveTestQuestionFromUserStatistics < ActiveRecord::Migration[5.2]
  def change
    remove_reference :user_statistics, :test_question, foreign_key: true
  end
end
