class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  has_many :test_answers
  has_many :answers, through: :test_answers

  accepts_nested_attributes_for :test_answers

  def self.calculate_avarage(user_id, test_id)
    user_test = UserTest.where(:user_id => user_id, :test_id => test_id).first
    
    weight_of_test = Test.calculate_weight(test_id)
    
    correct_answers = user_test.answers.select { |answer| answer.correct? } 
    weight_of_corrects = correct_answers.collect(&:question).collect(&:weight).sum
    
    ((weight_of_corrects / weight_of_test.to_f) * 10).round()
  end

end
