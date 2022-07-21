class UsersBackoffice::TestsController < UsersBackofficeController

  def index
    console
    @tests = Test.all.includes(:subject).includes(:questions)
    @user_tests = current_user.user_tests
  end

  def show
    @test = Test.find(params[:id])
    @user_test = UserTest.find(params[:id])
    @user_test_answers = UserTest._search_answers_(current_user, params[:id])
  end
end