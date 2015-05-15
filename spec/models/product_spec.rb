require 'rails_helper'

RSpec.describe Product, type: :model do
  
  it "has non-empty attributes" do
    expect(Product.new).to_not be_valid
  end
  
  it "has positive price" do
    product = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg", category_id: 1)
    product.price = -1
    expect(product).to_not be_valid
    
    product.price = 0
    expect(product).to_not be_valid
    
    product.price = 1
    expect(product).to be_valid
  end
  
  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", price: 1, category_id: 1, image_url: image_url)
  end
  
  it "has valid image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |i|
      expect(new_product(i)).to be_valid
    end
    
    bad.each do |i|
      expect(new_product(i)).to_not be_valid
    end
  end
  
  it "has a unique title" do
    product1 = Product.create!(title: "My Book Title", description: "yyy", image_url: "zzz.jpg", category_id: 1, price: 1)
    product2 = Product.new(title: "My Book Title", description: "yyy", image_url: "zzz.jpg", category_id: 1, price: 1)
    
    expect(product2).to_not be_valid
  end
end