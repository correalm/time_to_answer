class CreateTestAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :test_answers, id: false do |t|
      t.references :user_test, foreign_key: true
      t.references :answer, foreign_key: true

    end
  end
end
