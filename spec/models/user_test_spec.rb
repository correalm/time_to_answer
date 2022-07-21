require 'rails_helper'
require 'spec_helper'

RSpec.describe UserTest, type: :model do
  it "UserTest is valid" do
    expect(UserTest.new).to be_valid
  end
end
