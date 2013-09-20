require 'spec_helper'

feature "User Repeat Upload Pages" do

  before(:each) do
    @repeat_pair = FactoryGirl.create(:repeat_pair)
  end
  describe "when user is signed in" do
    before(:each) do
      login_as_user
      visit new_repeat_pair_user_repeat_image_path(@repeat_pair.id)
    end
    scenario "the upload image, dates, and notes page is loaded" do
      expect(page).to have_selector('h1', text: "Upload Repeat Image")
    end
    context "valid input" do
      before(:each) do
        attach_file "Image", Rails.root.join("spec","photos","test_user_repeat_image.jpg")
        d = Date.today
        select d.year.to_s, from: "user_repeat_image_date_1i"
        select d.strftime('%B'), from: "user_repeat_image_date_2i"
        select d.day.to_s, from: "user_repeat_image_date_3i"
      end
      scenario "a valid image is selected for uploading, a date is given, but with no notes" do
        click_button "Upload"
        expect(page).to have_selector("h1", text: "Image Alignment")
      end
      scenario "a valid image is selected for uploading, a date is given, and notes are filled in" do
        fill_in "Notes From Your Trip", with: "We had an excellent time. Lots of fun"
        click_button "Upload"
        expect(page).to have_selector("h1", text: "Image Alignment")
      end
    end
    context "invalid input" do
        describe "on image" do
          before(:each) do
            d = Date.today
            select d.year.to_s, from: "user_repeat_image_date_1i"
            select d.strftime('%B'), from: "user_repeat_image_date_2i"
            select d.day.to_s, from: "user_repeat_image_date_3i"
          end
          scenario "image has a file size that is too big" do
            attach_file "Image", Rails.root.join("spec","photos", "too_large_image.jpg")
            click_button "Upload"
            expect(page).to have_selector("h1", text: "Upload Repeat Image")
            expect(page).to have_text("Invalid Fields")
          end
          scenario "image resolution is too large" do
            attach_file "Image", Rails.root.join("spec","photos", "too_long_image.jpg")
            click_button "Upload"
            expect(page).to have_selector("h1", text: "Upload Repeat Image")
            expect(page).to have_text("Invalid Fields")
          end
        end
        describe "on date" do
          before(:each) { attach_file "Image", Rails.root.join("spec","photos","test_user_repeat_image.jpg") }
          scenario "date is in the future" do
            d = Date.today+100
            select d.year.to_s, from: "user_repeat_image_date_1i"
            select d.strftime('%B'), from: "user_repeat_image_date_2i"
            select d.day.to_s, from: "user_repeat_image_date_3i"
            click_button "Upload"
            expect(page).to have_selector("h1", text: "Upload Repeat Image")
            expect(page).to have_text('Invalid Fields')
          end
        end
      end
  end
end


