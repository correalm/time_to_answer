class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers).order('created_at asc').page(params[:page])
  end
end
