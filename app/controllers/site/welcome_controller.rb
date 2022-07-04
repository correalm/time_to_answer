class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers).order('id asc').page(params[:page])
  end
end
