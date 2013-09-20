class AlignmentController < ApplicationController
  include Wicked::Wizard

  steps :align, :verify

  def show
    @user_repeat_image = UserRepeatImage.find(params[:user_repeat_image_id])
    case step
    when :align

    when :verify

    end
    render_wizard
  end

  def update
    @user_repeat_image = UserRepeatImage.find(params[:user_repeat_image_id])
    case step
    when :align
      if @user_repeat_image.update_attributes(params[:user_repeat_image])
        @user_repeat_image.image.recreate_versions!
      else
        puts"do something"
      end
    when :verify

    end
    render_wizard @user_repeat_image
  end

end
