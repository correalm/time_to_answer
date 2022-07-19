class UsersBackoffice::TestsController < UsersBackofficeController
  # before_action :set_user, only: [:index ,:make, :show]
  # before_action :set_test, only: [:make, :result, :show]
  # before_action :get_grades_and_dates, only: [:index, :show]
  # before_action :get_user_questions_answers, only: [:show, :result]

  def index
    console
    @tests = Test.all.includes(:subject).includes(:questions)
  end

  # def make
  #   @user_test = UserTest.new

  #   if @user.test_ids.include?(@test.id)
  #   redirect_to users_backoffice_tests_path, notice: "Você já fez essa prova!"
  #   end
  # end

  # def register
  #   test = params[:form_questions]
  #   test.each do |question_id , answer_id|
  #     user_test = UserTestAnswer.new
  #     user_test.user = current_user.id
  #     user_test.question = question_id
  #     user_test.answer =  answer_id[0]
  #     user_test.test = params[:id]
  #     user_test.save!
  #   end

  #   redirect_to "/users_backoffice/tests/#{params[:id]}/result"
  # end

  # def result
  #   @grade = UserTestAnswer.calculate_grade(@user_questions_answers)
  #   UserTest.set_test(current_user.id, @test.id, @grade)
  # end

  def show
    @test = Test.find(params[:id])
    user_test = current_user.tests.select { |test| test.id == @test.id }[0]
    test_answers = user_test.user_tests.where(user_id:1)[0].answers
    @user_test_answers = test_answers.collect(&:id)

    # TODO: método do tipo -> UserTest.answers(user, test)
  end

  # private

  # def set_test
  #   @test = Test.find(params[:id])
  # end

  # def params_test
  #   params.require(:form_questions).permit!
  # end

  # def get_user_questions_answers
  #   @user_questions_answers = UserTestAnswer.get_user_questions_answers(current_user.id, params[:id])    
  # end

  # def set_user
  #   @user = User.find(current_user.id)
  # end

  # def get_grades_and_dates
  #   @grades = UserTest.get_grades(current_user.id)
  #   @dates = UserTest.get_dates(current_user.id)
  # end

  
end