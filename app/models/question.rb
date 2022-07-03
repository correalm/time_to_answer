class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers
  # ao realizar o cadastro, questões devem aceitar atributos aninhados do model answer
  accepts_nested_attributes_for :answers
end
