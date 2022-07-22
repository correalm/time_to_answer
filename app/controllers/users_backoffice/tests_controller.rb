class UsersBackoffice::TestsController < UsersBackofficeController

  def index
    @tests = Test.all.includes(:subject).includes(:questions)
  end
end