require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "Add a product and increase cart item by 1" do
  visit root_path
  expect(page).to have_content 'My cart (0)'

  within(page.first('.button_to')) do
    expect(page).to have_button('Add')
    # DEBUG
    save_screenshot

    click_on('Add')
  end
  
  # DEBUG
  save_screenshot

  # VERIFY
  expect(page).to have_content 'My cart (1)'

  end
end
