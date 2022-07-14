class UsersBackoffice::TestsController < UsersBackofficeController
  before_action :set_test, only: [:make] 

  def index
    @tests = Test.all.includes(:subject).includes(:questions)
  end

  def make
    @questions = @test.questions.to_a
  end

  def verify
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def params_test
    params.require(:test).permit(:subject_id, :id)
  end

  
end
