FactoryBot.define do
  factory :question do
    description { "question test" } 
    weight { 10 } 
    association :subject, factory: :subject
  end
end