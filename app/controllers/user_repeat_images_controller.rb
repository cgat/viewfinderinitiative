class UserRepeatImagesController < ApplicationController
  def show
    @user_repeat_image = UserRepeatImage.find(params[:id])
  end

  def new
    @user_repeat_image = current_user.user_repeat_image.build(repeat_pair_id: params[:repeat_pair_id])
  end

  def create
    @user_repeat_image = UserRepeatImage.new(params[:user_repeat_image])
    if @user_repeat_image.save
      redirect_to user_repeat_image_alignment_path(@user_repeat_image, :align)
    else
      render 'new'
    end
  end

  def update
    @user_repeat_image = UserRepeatImage.find(params[:id])
    debugger
    if @user_repeat_image.update_attributes(params[:user_repeat_image])
      redirect_to user_repeat_image_alignment_path(@user_repeat_image, :align)
    else
      render 'edit'
    end
  end

  def edit
    @user_repeat_image = UserRepeatImage.find(params[:id])
  end

end
