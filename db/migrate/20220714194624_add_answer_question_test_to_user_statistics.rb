class AddAnswerQuestionTestToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_statistics, :answer, foreign_key: true
  end
end
