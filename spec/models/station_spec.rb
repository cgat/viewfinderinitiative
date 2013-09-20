require 'spec_helper'

describe Station do
  let(:station) { FactoryGirl.create(:station) }
  describe "#historic_image" do
    context "has a historic_image" do
      it "returns the historic_image" do
        expect(station.historic_image).to be_present
      end
    end
    context "does not have a historic_image" do
      it "returns nil" do
        station.historic_image.destroy
        expect(station.reload.historic_image).to be nil
      end
    end
  end

  describe "#repeat_image" do
    context "has a repeat_image" do
      it "returns the repeat_image" do
        expect(station.repeat_image).to be_present
      end
    end
    context "does not have repeat_image" do
      it "returns nil" do
        station.repeat_image.destroy
        expect(station.reload.repeat_image).to be nil
      end
    end
  end

end
