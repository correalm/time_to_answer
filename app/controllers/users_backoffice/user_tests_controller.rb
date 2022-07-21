class UsersBackoffice::UserTestsController < UsersBackofficeController

  def new
    if current_user.test_ids.include?(params[:test_id].to_i)
      redirect_to users_backoffice_test_path(params[:test_id]), notice: "Prova já realizada"
    end
    @test = Test.find(params[:test_id])
    @user_test = UserTest.new
    @user_test.test_answers.build
  end

  def create
    @user_test = current_user.user_tests.new(params_test)
    if  @user_test.save!
      @user_test.grade = UserTest.calculate_avarage(current_user.id, params[:test_id])
      @user_test.save
      redirect_to users_backoffice_test_path(id: @user_test.test_id), notice: "Prova realizada com sucesso"
    else
      render :new
    end
  end

  def params_test
    params.require(:user_test).permit(:test_id, test_answers_attributes: [:answer_id])
  end

end
