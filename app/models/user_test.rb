class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  has_many :test_answers
  has_many :answers, through: :test_answers

  accepts_nested_attributes_for :test_answers

  before_commit do
    self.grade = calculate_avarage
    self.save
  end

  def calculate_avarage
    correct_answers = answers.select(&:correct) 
    weight_of_corrects = correct_answers.collect(&:question).collect(&:weight).sum
    
    ((weight_of_corrects / test.calculate_weight.to_f) * 10).round()
  end

end
