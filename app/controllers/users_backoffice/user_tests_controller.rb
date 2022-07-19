class UsersBackoffice::UserTestsController < UsersBackofficeController

  def index
  end

  def new
    @test = Test.find(params[:test_id])
    @user_test = current_user.user_tests.new
    @user_test.test_answers.build
  end

  def create
    @user_test = current_user.user_tests.new(params_test)
    if  @user_test.save!
      @user_test.grade = UserTest.calculate_avarage(current_user.id, params[:test_id])
      @user_test.save
      redirect_to users_backoffice_tests_path, notice: "Mostrar a nota agora"
    else
      render :new
    end
  end

  def show
    

  end

  def params_test
    params.permit(:test_id, answer_ids: [])
  end

end
