class Question < ApplicationRecord
  searchkick

  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers

  # ao realizar o cadastro, questões devem aceitar atributos aninhados do model answer
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  # Callback (após criar uma questão, calcule a estatística)
  after_create :set_statistic
  
  # kaminari
  paginates_per 5

  # O scope deve ser criado quando preciso fazer querys no meu DB
  scope :_search, -> (params){
    includes(:answers, :subject).where("lower(description) LIKE ?", "%#{ params[:term].downcase }%").page(params[:page])
  }

  scope :_search_subject_, -> (page, subject_id){
    includes(:answers, :subject).where(subject_id: subject_id).page(page)
  }

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end

end
