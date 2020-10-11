class PicturesController < ApplicationController

  def new
    @picture = Picture.new
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.image && @picture.image.url
      render :confirm
    else
      flash.now[:empty] = '画像が添付されていません'
      render :new
    end
  end

  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
    if @picture.user_id == current_user.id
      render :edit
    else
      redirect_to new_picture_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @picture.save
        flash[:notice] = '投稿完了'
        redirect_to picture_path(@picture.id)
      else
        render :new
      end
    end
  end

  def update
    if params[:back]
      @picture = Picture.new
      render :new
    else
      @picture = Picture.find(params[:id])
      @picture.update(picture_params)
      flash[:notice] = '編集完了'
      redirect_to pictures_path
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.user_id == current_user.id
      @picture.destroy
      redirect_to pictures_path, notice: 'destroyed'
    else
      redirect_to new_picture_path
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end

end
