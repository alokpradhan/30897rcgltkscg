class VegetablesController < ApplicationController

  def index
    @vegetables = Vegetable.all  #needs to refer to the model
  end

  def show
    @vegetable = Vegetable.find(params[:id])
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(whitelisted_vegetable_params)
    if @vegetable.save
      flash[:success] = "That sounds like a tasty vegetable!"
      redirect_to article_path(@vegetable) 	#need to add path
    else
    	render :new					#needs to render new if save fails
    end
  end

  def edit
    @vegetable = Vegetable.find(params[:id])   #find by unique id
  end

  def update
    @vegetable = Vegetable.find(params[:id])	#find by unique id
    if @vegetable.update(whitelisted_vegetable_params) 	#need to pass the params to update
      flash[:success] = "A new twist on an old favorite!"
      redirect_to article_path(@vegetable)
    else
      flash.now[:error] = "Something is rotten here..."  #need to flash on rendered page i.e. before redirect
      render :edit
    end
  end

  def destroy			#rails refers to delete as destroy
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.destroy
    	flash[:success] = "That veggie is trashed."
    	redirect_to article_path(@vegetable) #need article path
    else
    	flash.now[:error] = "Not deleted!"  #consider an else in case not destroyed
    	render :edit
    end
  end

  private

  def whitelisted_vegetable_params
    params.require(:vegetable).permit(:name, :color, :rating, :latin_name) #need to get values from params sent
  end

end
