require 'rails_helper'

RSpec.feature "Navigate to Product Details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Go to Product Details" do
    # ACT
    visit product_path(@category.products.second)

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
  end
end
