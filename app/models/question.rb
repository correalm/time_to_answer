class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  # ao realizar o cadastro, questões devem aceitar atributos aninhados do model answer
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # kaminari
  paginates_per 5

  # O scope deve ser criado quando preciso fazer querys no meu DB
  scope :search, -> (params){
    includes(:answers).where("lower(description) LIKE ?", "%#{ params[:term].downcase }%").page(params[:page])
  }

end
