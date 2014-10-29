class CatsController < ApplicationController
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    @cat_attrs = [:name, :color, :sex, :birth_date, :description]
    render :show
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
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  private
  def cat_params
    cat_attrs = [:name, :color, :sex, :birth_date, :description]
    params.require(:cat).permit(*cat_attrs)
  end
end
