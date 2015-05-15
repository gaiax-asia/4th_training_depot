require 'rails_helper'

RSpec.describe Order, type: :model do
  it "has a name" do
    expect(Order.new(name: nil, email: 'example@example.com', address:'example', pay_type: 'Check')).to_not be_valid
  end
  
  it "has an email" do
    expect(Order.new(name: 'Example', email: nil, address:'example', pay_type: 'Check')).to_not be_valid
  end
  
  it "has an address" do
    expect(Order.new(name: 'Example', email: 'example@example.com', address: nil, pay_type: 'Check')).to_not be_valid
  end
  
  it "has a valid paytype" do
    expect(Order.new(name: 'Example', email: 'example@example.com', address: 'example', pay_type: 'IOU')).to_not be_valid
  end
end