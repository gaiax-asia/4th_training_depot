require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a unique name" do
    User.create!(name: 'test', email: 'test@test.com', password: 'secret')
    expect(User.new(name: 'tEst', email: 'another_test@test.com', password: 'secret2')).to_not be_valid
  end
  
  it "requires a password" do
    expect(User.new(name: 'Test', email: 'test@nopassword.com', password: nil)).to_not be_valid
  end
  
  it "requires a valid email" do
    expect(User.new(name: 'Test', email: 'invalid email', password: 'secret')).to_not be_valid
  end
end
