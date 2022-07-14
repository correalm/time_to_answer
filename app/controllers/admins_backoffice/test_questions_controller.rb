class AdminsBackoffice::TestQuestionsController < AdminsBackofficeController
  # before_action :set_questions, only: [:index]

  def index
    @questions = Question.where(subject_id: params[:id]).all
    console
    @test = Test.find(params[:test])
  end

  private
  def params_test
    params.require(:test).permit(:subject_id, :id)
  end
  def set_questions 
    # @questions = Question._search_teste(params[:id])
  end

end
