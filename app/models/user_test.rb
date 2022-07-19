class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  has_many :test_answers
  has_many :answers, through: :test_answers

  accepts_nested_attributes_for :test_answers


  def self.calculate_avarage(user_id, test_id)
    user_test = UserTest.where(:user_id => user_id, :test_id => test_id)[0]
    test_answers = user_test.test_answers.collect(&:answer_id)

    answers = Answer.where(:id => test_answers)

    weight_of_corrects = 0
    weight_of_test = 0

    answers.each do |answer|  
      if answer.correct?
        weight_of_corrects += answer.question.weight
        weight_of_test += answer.question.weight
      else
        weight_of_test += answer.question.weight
      end
    end

    final = (weight_of_corrects / weight_of_test.to_f) * 10
  end

end
