require 'spec_helper'

feature "Station Pages" do
  let(:station) { FactoryGirl.create(:station) }
  context "as a site guest" do
    it "shows station details" do
      visit station_path(station.id)
      expect(page).to have_text(station.name)
      expect(page).to have_text(station.description)
      expect(page).to have_css("img[src='#{station.repeat_pair.repeat_image.image.medium.url}']")
      expect(page).to have_css("img[src='#{station.repeat_pair.historic_image.image.medium.url}']")
    end

  end
  context "when a user is signed in" do
    let(:user) { FactoryGirl.create(:user) }
    context "has a repeat uploaded and aligned" do
      let(:user_repeat_image) { FactoryGirl.create(:user_repeat_image, :with_points, user: user, repeat_pair: station.repeat_pair) }
      it "shows user uploaded image" do
        user_repeat_image.reload.image.recreate_versions!
        login_as_user(user)
        visit station_path(station)
        expect(page).to have_text("Your Repeat")
        expect(page).to have_css("img[src='#{user_repeat_image.image.medium.url}']")
        expect(page).to have_text(user_repeat_image.date.strftime('%B %d, %Y'))
      end
      it "show user uploaded images when there is more than one" do
        user_repeat_image.reload.image.recreate_versions!
        another_image = FactoryGirl.create(:user_repeat_image, :with_points, user: user, repeat_pair: station.repeat_pair)
        another_image.reload.image.recreate_versions!
        another_image_different_station = FactoryGirl.create(:user_repeat_image, :with_points, user: user)
        another_image_different_station.reload.image.recreate_versions!
        login_as_user(user)
        visit station_path(station)
        expect(page).to have_text("Your Repeats")
        expect(page).to have_css("img[src='#{user_repeat_image.image.medium.url}']")
        expect(page).to have_css("img[src='#{another_image.image.medium.url}']")
        expect(page).to have_no_css("img[src='#{another_image_different_station.image.medium.url}']")
      end
    end
  end

  describe "edit page" do

  end

  describe "new page" do

  end

  describe "index page" do

  end

end
