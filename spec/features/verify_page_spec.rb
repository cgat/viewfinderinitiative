require 'spec_helper'

feature "Verify Page" do

  before(:each) do
    @repeat_pair = FactoryGirl.create(:repeat_pair)
    @user_repeat_image = FactoryGirl.create(:user_repeat_image, repeat_pair: @repeat_pair)
  end
  describe "when user is signed in" do
    before(:each) do
      login_as_user(@user_repeat_image.user)
      visit user_repeat_image_alignment_path(@user_repeat_image.id, :verify)
    end
    scenario "the verify page is loaded" do
      expect(page).to have_selector('h1', text: "Verify Alignment")
      expect(page).to have_selector('a', text: "Done")
      expect(page).to have_css('a', text: "Readjust & Try Again")
    end
    scenario "the done button is clicked" do
      click_link "Done"
      expect(page).to have_selector("h1", text: @repeat_pair.station.name)
    end
    scenario "the 'Readjust & Try Again' button is clicked" do
      click_link "Readjust & Try Again"
      expect(page).to have_selector("h1", text: "Image Alignment")
    end
  end
end


