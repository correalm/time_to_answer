module UsersBackofficeHelper
  def img_url
    image = current_user.user_profile.image
    image.attached? ? image : 'img.jpg'
  end

end
