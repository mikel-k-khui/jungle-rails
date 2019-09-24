require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  # SETUP
  before :each do
    @user = User.create(first_name: "Doctor Stephen", last_name: "Strange",
                        email: "ME@STRANGE.COM", 
                        password: "testing",
                        password_confirmation: "testing",
                        created_at: DateTime.now, updated_at: DateTime.now)
  end

  scenario "Successful login" do
    visit root_path
    expect(@user).to be_valid

    expect(page).to have_content('Come into the Jungle')

    click_link 'Come into the Jungle'


    # VERIFY
    expect(page).to have_content 'Sign up by filling teh below information'

    within(page.first('.jumbotron')) do
      # DEBUG
      puts current_url
      save_screenshot

      expect(page).to have_content 'Are you back for another Jungle adventure?'
      expect(page).to have_content 'Login below'
      within('form') do
        fill_in 'email', with: 'ME@STRANGE.COM'
        fill_in 'password', with: 'testing'
      end
      click_button 'Submit'
    end

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content 'This way to leave the Jungle,'
    expect(page).to have_content 'cart has (0) products'
    expect(page)as_no_text 'Admin'
  end
end
