class Site::AnswerController < SiteController
  def verify
    puts ">>>>>>>>>>>>>>> #{params[:answer]}"
  end
end
