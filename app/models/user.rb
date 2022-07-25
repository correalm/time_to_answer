class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  # possui apenas um perfil  
  has_one :user_profile
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :answers, through: :user_tests

  
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank
  
  # Callback
  after_create :set_statistic
  # validations
  validates :first_name, presence: true, length: { minimum: 3 }, on: :update, unless: :reset_password_token_present?

  # virtual attribute
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def find_user_test(test)
    user_tests.where(test_id: test.id).first
  end

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
  end

  def reset_password_token_present?
    !!$global_params[:user][:reset_password_token]
  end
end
