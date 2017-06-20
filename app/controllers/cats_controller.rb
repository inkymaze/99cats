class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = selected_cat
    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
        redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = selected_cat
    render :edit
  end

  def update

    @cat = selected_cat

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private
  def selected_cat
    Cat.find_by(id: params[:id])
  end

  def cat_params
    params.require(:cat).permit(:birth_date, :name, :sex, :description, :color)
  end
end
