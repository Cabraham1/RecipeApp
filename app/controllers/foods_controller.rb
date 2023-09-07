class FoodsController < ApplicationController
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params.merge(user_id: current_user.id))
    if @food.save
      flash[:notice] = 'Food created successfully!'
      redirect_to foods_path
    else
      flash[:alert] = 'Food creation faild!'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = 'Food deleted successfully!'
      redirect_to request.referrer
    else
      flash[:alert] = 'Food deletion faild!'
      render :index
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
