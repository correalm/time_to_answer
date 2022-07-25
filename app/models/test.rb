class Test < ApplicationRecord
  belongs_to :subject
  has_many :test_questions
  has_many :questions, through: :test_questions
  has_many :user_tests
  has_many :users, through: :user_tests

  paginates_per 5

  def calculate_weight
    questions.collect(&:weight).sum
  end
end
