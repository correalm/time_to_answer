class CreateUserTestAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_test_answers do |t|
      t.integer :user
      t.integer :test
      t.integer :question
      t.integer :answer

      t.timestamps
    end
  end
end
