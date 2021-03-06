RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should check if product is valid' do    
      @category = Category.new(name: "newCategory")    
      @product = Product.new(name: "My product", price_cents: 500, quantity: 3, :category => @category)    
      expect(@product.errors).not_to include("can't be blank")    
    end  
    
    it 'should check name presence' do    
      @category = Category.new(name: "newCategory")    
      @product = Product.new(price_cents: 1000, quantity: 10, :category => @category)    
      @product.valid? expect(@product.errors[:name]).to include("can't be blank")    
    end

    it 'should check price presence' do    
      @category = Category.new(name: "newCategory")    
      @product = Product.new(price_cents: 1000, quantity: 10, :category => @category)    
      @product.valid? expect(@product.errors[:price]).to include("can't be blank")    
    end

    it 'should check quantity presence' do    
      @category = Category.new(name: "newCategory")    
      @product = Product.new(price_cents: 1000, quantity: 10, :category => @category)    
      @product.valid? expect(@product.errors[:quatntity]).to include("can't be blank")    
    end

    it 'should check category presence' do    
      @category = Category.new(name: "newCategory")    
      @product = Product.new(price_cents: 1000, quantity: 10, :category => @category)    
      @product.valid? expect(@product.errors[:categroy]).to include("can't be blank")    
    end
  end
end