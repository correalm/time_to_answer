class UsersBackoffice::TestsController < UsersBackofficeController

  def index
    @tests = Test.all.page(params[:page])
  end
end