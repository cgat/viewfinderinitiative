class RepeatImagesController < ApplicationController

  def show
    @repeat_image = RepeatImage.find(params[:id])
  end

  def update
    @repeat_image = RepeatImage.find(params[:id])
    if @repeat_image.update_attributes(params[:repeat_image])
      redirect_to @repeat_image
    else
      render 'edit'
    end
  end

  def edit
    @repeat_image = RepeatImage.find(params[:id])
  end
end
