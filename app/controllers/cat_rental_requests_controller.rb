class CatRentalRequestsController < ApplicationController
  
  def index
    @cat_requests = CatRentalRequest.where("cat_id = ?", params[:cat_id])
                      .order(:start_date)
    @cat = Cat.find(params[:cat_id])
    render :index
  end
  
  
  def create
    @cat_request = CatRentalRequest.new(cat_request_params)
    
    if @cat_request.save
      redirect_to cat_cat_rental_requests_url(@cat_request.cat_id)
    else
      flash.now[:errors] = @cat_request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end
  
  def new
    @cat_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end
  
  
  private
  def cat_request_params
    params.require(:cat_request).permit(:cat_id, :start_date, :end_date)
  end
end
