class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  # ao realizar o cadastro, questões devem aceitar atributos aninhados do model answer
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
