class CatsController < ApplicationController
  before_action :check_owner, only: [:update, :edit] 
  
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
    @user_id = current_user.id
    
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
  
  def check_owner
    @cat = Cat.find(params[:id])
    unless @cat.user_id == current_user.id
      flash[:errors] = [] if @cat.errors.empty?
      flash[:errors] << "User does not own cat"
    else
      #redirect_to cats_url
    end
  end
  
  def cat_params
    cat_attrs = [:name, :color, :sex, :birth_date, :description]
    params.require(:cat).permit(*cat_attrs)
  end
end
