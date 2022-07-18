class UserTestAnswer < ApplicationRecord

  def self.get_user_questions_answers(user_id, test_id)
    user_answers_query = UserTestAnswer.select(:question, :answer).where(:user => user_id, :test => test_id).to_a
    
    user_questions_answers = {}

    user_answers_query.each do |query|
      user_questions_answers[query.question] = query.answer
    end

    return user_questions_answers
  end

  def self.calculate_grade(user_questions_answers)
    # weights
    questions_weights = Question.select(:id, :weight).where(:id => user_questions_answers.keys).to_a

    weights = {}
    questions_weights.each do |question|
      weights[question.id] = question.weight
    end
    
    # correct answers
    corrects = Answer.select(:id).where(:id => user_questions_answers.values, :correct => true).to_a
    
    sum_of_corrects = 0
    corrects.each do |correct|
      question_id = user_questions_answers.key(correct.id)
      sum_of_corrects += weights[question_id]
    end

    final = (sum_of_corrects / weights.values.sum.to_f) * 10
    return final
  end
end
