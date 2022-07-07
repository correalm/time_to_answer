namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Config the development enviroment"
  task setup: :environment do
    if Rails.env.development?
      %x(rails db:drop db:create db:migrate)
      %x(rails dev:add_default_admin)
      %x(rails dev:add_more_admins)
      %x(rails dev:add_default_user)
      %x(rails dev:add_subjects)
      %x(rails dev:add_questions)
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

  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_params(subject)
        answers_array = params[:question][:answers_attributes]

        rand(2..5).times do |j|
          answers_array.push(
            {
              description: "#{Faker::Lorem.sentence}#",
              correct: false
            }
          )
        end

        index = rand(answers_array.size)
        
        answers_array[index] = {
          description: "#{Faker::Lorem.sentence}#",
          correct: true
        }
        
        Question.create!(params[:question])
      end
    end
  end

  desc "Adiciona respostas no Redis"
  task add_answers_to_redis: :environment do
    Answer.find_each do |ans|
      Rails.cache.write(ans.id, "#{ans.question_id}@@#{ans.correct}")
    end
  end

  
  private

  def create_params(subject = Subject.all.sample)
    { question: {
        description: "#{Faker::Lorem.paragraph}#{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: [] 
      }
    }
  end

end