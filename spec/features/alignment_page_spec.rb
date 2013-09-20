require 'spec_helper'

feature "Alignment Page" do

  before(:each) do
    @repeat_pair = FactoryGirl.create(:repeat_pair)
    @user_repeat_image = FactoryGirl.create(:user_repeat_image, repeat_pair: @repeat_pair)
  end
  describe "when user is signed in" do
    before(:each) do
      login_as_user(@user_repeat_image.user)
      visit user_repeat_image_alignment_path(@user_repeat_image.id, :align)
    end
    scenario "the alignment page is loaded" do
      expect(page).to have_selector('h1', text: "Image Alignment")
      expect(page).to have_css("input[value='Align']")
    end
    scenario "the alignment page is submitted" do
      click_button "Align"
      expect(page).to have_selector("h1", text: "Verify Alignment")
    end
    scenario "the 'Edit Upload' button is clicked" do
      click_link "Edit Upload"
      expect(page).to have_selector("h1", text: "Edit Repeat Image")
    end
  end
end


