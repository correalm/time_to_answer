class AddTestQuestionToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_statistics, :test_question, foreign_key: true
  end
end
