namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Config the development enviroment"
  task setup: :environment do
    if Rails.env.development?
      %x(rails db:drop db:create db:migrate)
      %x(rails dev:add_default_admin)
      %x(rails dev:add_more_admins)
      %x(rails dev:add_default_user)
    else
      puts "Need development enviroment"
    end
  end

  desc "Adiciona o administrador padrão"
    task add_default_admin: :environment do
      Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end

    desc "Adiciona o administrador extra"
    task add_more_admins: :environment do
      10.times do |i|
        Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
        )
      end
    end

  desc "Adiciona o usuário padrão"
    task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
end