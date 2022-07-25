require 'rails_helper'
require 'rails_helper'

subject = FactoryBot.build :subject
user = FactoryBot.build :user


Question.create([{
  description: "a", 
  weight: 10, 
  subject: subject, 
  answers_attributes: [
    {
      description: "x",
      correct: false
    },
    {
      description: "y",
      correct: true
    },
    {
      description: "z",
      correct: false
    }
  ]},
  {
    description: "b", 
    weight: 11, 
    subject: subject, 
    answers_attributes: [
      {
        description: "e",
        correct: false
      },
      {
        description: "f",
        correct: true
      },
      {
        description: "g",
        correct: false
      }
    ]
    
  },
  {
  description: "c", 
  weight: 12, 
  subject: subject, 
  answers_attributes: [
    {
      description: "1",
      correct: false
    },
    {
      description: "2",
      correct: true
    },
    {
      description: "3",
      correct: false
    }
  ]
}])

Test.create([
  { name: "Test 1", subject: subject, question_ids: [Question.all[0].id, Question.all[1].id, Question.all[2].id] },
  { name: "Test 2", subject: subject, question_ids: [Question.all[0].id, Question.all[1].id, Question.all[2].id] },
  { name: "Test 3", subject: subject, question_ids: [Question.all[0].id, Question.all[1].id, Question.all[2].id] },
  { name: "Test 4", subject: subject, question_ids: [Question.all[0].id, Question.all[1].id, Question.all[2].id] }
])

UserTest.create([{
  user: user, 
  test: Test.all[0], 
  test_answers_attributes: [
    {
      answer: Test.all[0].questions[0].answers[1]
    },
    {
      answer: Test.all[0].questions[1].answers[1]
    },
    {
      answer: Test.all[0].questions[2].answers[1]
    }
  ]
  },{
    user: user, 
    test: Test.all[1], 
    test_answers_attributes: [
      {
        answer: Test.all[1].questions[0].answers[1]
      },
      {
        answer: Test.all[1].questions[1].answers[0]
      },
      {
        answer: Test.all[1].questions[2].answers[1]
      }
    ]
  },{
    user: user, 
    test: Test.all[2], 
    test_answers_attributes: [
      {
        answer: Test.all[2].questions[0].answers[1]
      },
      {
        answer: Test.all[2].questions[1].answers[0]
      },
      {
        answer: Test.all[2].questions[2].answers[0]
      }
    ]
  },{
    user: user, 
    test: Test.all[3], 
    test_answers_attributes: [
      {
        answer: Test.all[3].questions[0].answers[0]
      },
      {
        answer: Test.all[3].questions[1].answers[0]
      },
      {
        answer: Test.all[3].questions[2].answers[0]
      }
    ]
}])

RSpec.describe UserTest, type: :model do
  
  it "the first user_test must have the answers 2, 5 and 8" do
    user_test = UserTest.first
    expect(user_test.answer_ids). to eq([2, 5, 8])
  end

  it ".calculate_avarage should return 10" do
    user_test = UserTest.first

    expect(user_test.calculate_avarage).to eq(10)
  end

  it ".calculate_avarage should return 7" do
    user_test = UserTest.all[1]

    expect(user_test.calculate_avarage).to eq(7)
  end

  it ".calculate_avarage should return 3" do
    user_test = UserTest.all[2]

    expect(user_test.calculate_avarage).to eq(3)
  end

  it ".calculate_avarage should return 0" do
    user_test = UserTest.all[3]

    expect(user_test.calculate_avarage).to eq(0)
  end

  
end
