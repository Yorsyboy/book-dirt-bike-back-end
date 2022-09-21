class Api::MotorcyclesController < ApplicationController
  def index
    @motorcycles = current_user.motorcycles.all
    render json: @motorcycles
  end

  def show
    @motorcycle = Motorcycle.find(params[:id])
    render json: @motorcycle
  end

  def new
    @user = current_user.id
    @motorcycles = @user.motorcycles
    render json: @motorcycles
  end

  def create
    @motorcycle = current_user.motorcycles.new(motorcycle_params)
    if @motorcycle.save
      render json: @motorcycle
    else
      render json: @motorcycle.errors.full_messages, status: 422
    end
  end

  def destroy
    @motorcycle = Motorcycle.find(params[:id])
    @motorcycle.destroy
    render json: @motorcycle
  end

  private

  def motorcycle_params
    params.require(:motorcycle).permit(:bike_name, :details, :image, :user_id: current_user.id)
  end
end
