require 'spec_helper'
require 'carrierwave/test/matchers'

describe UserRepeatImage do

  let(:user_repeat_image) { FactoryGirl.create(:user_repeat_image) }

  it { should respond_to(:points) }
  it { should respond_to(:width) }
  it { should respond_to(:height) }
  it { should respond_to(:date) }
  it { should respond_to(:image) }
  it { should respond_to(:user_id) }
  it { should respond_to(:repeat_pair_id) }
  it { should respond_to(:aligned?)}
  it { should respond_to(:notes) }

  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:repeat_pair_id)}
  describe "validations" do
    let(:user_repeat_image) { FactoryGirl.build(:user_repeat_image) }
    it "does not accept images greater than #{ ENV['USER_IMAGE_MAX_FILE_SIZE'] } bytes" do
      user_repeat_image.image.stub(:size) { ENV['USER_IMAGE_MAX_FILE_SIZE'].to_i+1 }
      expect{ user_repeat_image.save! }.to raise_error(ActiveRecord::RecordInvalid, /file size too big/)
    end
    it "does not accept images with a long edge greater than #{ ENV['USER_IMAGE_MAX_LENGTH'] } pixels" do
      user_repeat_image.width = ENV['USER_IMAGE_MAX_LENGTH'].to_i+1
      user_repeat_image.height = ENV['USER_IMAGE_MAX_LENGTH'].to_i+1
      expect { user_repeat_image.save! }.to raise_error(ActiveRecord::RecordInvalid, /resolution too big/)
    end
    it "does not accept dates in the future" do
      user_repeat_image.date = Date.today+100
      expect { user_repeat_image.save! }.to raise_error(ActiveRecord::RecordInvalid, /The date cannot be in the future/)
    end
    describe "when points exist'" do
      before(:each) do
        user_repeat_image.stub(:status) { 'align' }
      end
      it "does not accept user repeat image when the image does not have the same amount of points as the repeat image" do
        user_repeat_image.points.build(label: "p1", x: 833, y: 240)
        user_repeat_image.points.build(label: "p2", x: 100, y: 100)
        expect { user_repeat_image.save! }.to raise_error(ActiveRecord::RecordInvalid, \
          /Insufficient points. To be able align the image properly, the image must have/)
      end
    end
  end

  describe "scopes" do
    describe "#with_user" do
      it "returns user_repeat_images that are in a specific parameterized user" do
        another_image = FactoryGirl.create(:user_repeat_image)
        UserRepeatImage.with_user(user_repeat_image.user).to_a.should =~ [user_repeat_image]
      end
    end
  end
end
