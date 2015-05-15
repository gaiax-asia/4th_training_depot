require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a name" do
    expect(Category.new(name: nil)).to_not be_valid
  end
  
  it "is unique" do
    Category.create!(name: 'Fiction')
    expect(Category.new(name: 'Fiction')).to_not be_valid
  end
end