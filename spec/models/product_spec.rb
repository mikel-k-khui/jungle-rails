require 'rails_helper'
require 'spec_helper'

RSpec.describe Product, :type => :model do
  describe 'Validation' do

    @catalog = Category.new(name: "Cars")

    it "successufl setup" do
      subject {
        described_class.new(name: "Subaru Crosstrek", price: "30000.05",
                          quantity: 5, category: @catalog,
                          description: "Lorem ipsum",
                          created_at: DateTime.now, updated_at: DateTime.now)
      }

      expect(subject).to be_a_new(Product)
    end

    it "valid name is presence" do
      subject{
          described_class.new(name: nil, price: "30000.05",
                            quantity: 5, category: @catalog,
                            description: "Lorem ipsum",
                            created_at: DateTime.now, updated_at: DateTime.now)}
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end

    it "valid price is presence" do
      subject{
        described_class.new(name: "Subaru Crosstrek", price: nil,
                          quantity: 5, category: @catalog,
                          description: "Lorem ipsum",
                          created_at: DateTime.now, updated_at: DateTime.now)}
      subject.valid?
      subject.errors[:price].should include("can't be blank")
    end

    it "valid quantity is presence" do
      subject{
        described_class.new(name: "Subaru Crosstrek", price: "30000.05",
                          quantity: nil, category: @catalog,
                          description: "Lorem ipsum",
                          created_at: DateTime.now, updated_at: DateTime.now)}
      subject.valid?
      expect(subject.errors[:quantity]).to include("can't be blank")
    end

    it "valid category is presence" do
      @product = Product.new(name: "Subaru Crosstrek", price: "30000.05",
                          quantity: 5, category: nil,
                          description: "Lorem ipsum",
                          created_at: DateTime.now, updated_at: DateTime.now)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to include("can't be blank")
    end


  end
end
