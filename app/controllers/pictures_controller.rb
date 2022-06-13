class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  before_action :ensure_user, only: %i[ edit update destroy ]

  def index
    @pictures = Picture.all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @picture.save
          format.html { redirect_to picture_url(@picture), notice: "新規投稿しました！" }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "投稿を編集しました！" }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "投稿を削除しました！" }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user
    redirect_to pictures_path unless @picture.user == current_user
  end

  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache, :user_id)
  end
end
