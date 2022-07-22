require 'rails_helper'

subject = Subject.create({
  description: "test"
})

user = User.create({
  email: "test@test.com",
  password: 123456,
  password_confirmation: 123456
})

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
    test = Test.first

    grade = UserTest.calculate_avarage(user.id, test.id)
    expect(grade).to eq(10)
  end

  it ".calculate_avarage should return 7" do
    test = Test.all[1]

    grade = UserTest.calculate_avarage(user.id, test.id)
    expect(grade).to eq(7)
  end

  it ".calculate_avarage should return 3" do
    test = Test.all[2]

    grade = UserTest.calculate_avarage(user.id, test.id)
    expect(grade).to eq(3)
  end

  it ".calculate_avarage should return 0" do
    test = Test.all[3]

    grade = UserTest.calculate_avarage(user.id, test.id)
    expect(grade).to eq(0)
  end
end
