class Site::SearchController < SiteController
  def questions
    # O % % é o carctere curinga do Active Record do Rails
    @questions = Question.includes(:answers)
                        .where("lower(description) LIKE ?", "%#{ params[:term].downcase }%")
                        .page(params[:page])
  end
end
