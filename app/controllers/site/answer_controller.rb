class Site::AnswerController < SiteController
  def verify
    @answer = Answer.find(params[:answer_id])
  end
end
