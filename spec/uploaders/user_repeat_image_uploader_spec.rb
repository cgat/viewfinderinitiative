require 'spec_helper'
require 'carrierwave/test/matchers'

describe UserRepeatImageUploader do
  include CarrierWave::Test::Matchers
  before do
    UserRepeatImageUploader.enable_processing = true
    repeat_pair = FactoryGirl.create(:repeat_pair)
    repeat_pair.reload
    @user_repeat_image = FactoryGirl.create(:user_repeat_image, repeat_pair: repeat_pair)
    @repeat_image = repeat_pair.repeat_image
    @repeat_image.points.destroy_all
    @uploader = @user_repeat_image.image
  end
  after do
    UserRepeatImageUploader.enable_processing = false
    @uploader.remove! if @uploader.present?
  end

  describe "first time upload" do

    context 'the thumb version' do
      it "should no exist" do
        @uploader.thumb.should be_blank
      end
    end

    context 'the medium version' do
      it "should not exist" do
        @uploader.medium.should be_blank
      end
    end

    context 'the large version' do
      it "should not exist" do
        @uploader.large.should be_blank
      end
    end

    context 'the aligned version' do
      it "should not exist" do
        @uploader.aligned.should be_blank
      end
    end
  end

  describe "alingement stage" do
    context "both images have the same amount of control points" do
      before do
        @user_repeat_image.points.create(label: "p1", x: 833, y: 240)
        @user_repeat_image.points.create(label: "p2", x: 404, y: 252)
        @user_repeat_image.points.create(label: "p3", x: 616, y: 279)
        @repeat_image.points.create(label: "p1", x: 1128, y: 68)
        @repeat_image.points.create(label: "p2", x: 229, y: 110)
        @repeat_image.points.create(label: "p3", x: 679, y: 161)
        @user_repeat_image.image.recreate_versions!
        @uploader = @user_repeat_image.image
      end

      context "the alinged version" do
        it "should have the exact same dimensions as the repeat image" do
          @uploader.aligned.should have_dimensions(@repeat_image.width, @repeat_image.height)
        end
      end

      context 'the thumb version' do
        it "should scale down an image to fit within #{ENV['THUMB_FIT_SIZE']} by #{ENV['THUMB_FIT_SIZE']} pixels" do
          @uploader.thumb.should be_no_larger_than(ENV['THUMB_FIT_SIZE'].to_i, ENV['THUMB_FIT_SIZE'].to_i)
        end
      end

      context 'the medium version' do
        it "should scale down an image to fit within #{ENV['MEDIUM_FIT_SIZE']} by #{ENV['MEDIUM_FIT_SIZE']} pixels" do
          @uploader.medium.should be_no_larger_than(ENV['MEDIUM_FIT_SIZE'].to_i, ENV['MEDIUM_FIT_SIZE'].to_i)
        end
      end

      context 'the large version' do
        it "should scale down an image to fit within #{ENV['LARGE_FIT_SIZE']} by #{ENV['LARGE_FIT_SIZE']} pixels" do
          @uploader.large.should be_no_larger_than(ENV['LARGE_FIT_SIZE'].to_i, ENV['LARGE_FIT_SIZE'].to_i)
        end
      end
    end

    it "user repeat image has less points than repeat image" do
      @user_repeat_image.points.create(label: "p1", x: 833, y: 240)
      @user_repeat_image.points.create(label: "p2", x: 404, y: 252)
      @repeat_image.points.create(label: "p1", x: 1128, y: 68)
      @repeat_image.points.create(label: "p2", x: 229, y: 110)
      @repeat_image.points.create(label: "p3", x: 679, y: 161)
      expect{ @user_repeat_image.image.recreate_versions! }.to raise_error(ArgumentError, 'Both sets of points must have the same number of elements')
    end

    it "user repeat image has more points than repeat image" do
      @user_repeat_image.points.create(label: "p1", x: 833, y: 240)
      @user_repeat_image.points.create(label: "p2", x: 404, y: 252)
      @user_repeat_image.points.create(label: "p3", x: 616, y: 279)
      @user_repeat_image.points.create(label: "p4", x: 500, y: 500)
      @repeat_image.points.create(label: "p1", x: 1128, y: 68)
      @repeat_image.points.create(label: "p2", x: 229, y: 110)
      @repeat_image.points.create(label: "p3", x: 679, y: 161)
      expect{ @user_repeat_image.image.recreate_versions! }.to raise_error(ArgumentError, 'Both sets of points must have the same number of elements')
    end

    it "insufficient points to calculate transform" do
      @user_repeat_image.points.create(label: "p1", x: 616, y: 279)
      @repeat_image.points.create(label: "p1", x: 1128, y: 68)
      expect{ @user_repeat_image.image.recreate_versions! }.to raise_error(ArgumentError, 'Insufficient points. You need at least 2 control points in each image to be able to perform alignment')
    end
  end

end
