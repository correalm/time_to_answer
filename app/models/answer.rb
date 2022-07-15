class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_tests
  has_many :tests, through: :test_questions
end
