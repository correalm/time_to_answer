class UsersBackoffice::TestsController < UsersBackofficeController
  before_action :set_test, only: [:make]
  before_action :set_statistic, only: [:make, :verify, :results] 

  def index
    console
    @tests = Test.all.includes(:subject).includes(:questions)
    @user_tests = UserTest.Question.where(user_id: current_user.id).all
  end

  def make
    @questions = @test.questions.to_a
  end

  def verify
    teste = params[:form_questions]
    teste.each do |question_id , answer_id|
      user_test = UserTest.new
      user_test.user_id = current_user.id
      user_test.question = question_id
      user_test.answer_id =  answer_id[0]
      user_test.test_id = params[:id]
      user_test.save!
    end

    redirect_to users_backoffice_tests_path
  end

  def results
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def params_test
    params.require(:form_questions).permit!
  end

  def set_statistic
  end

  
end
