class Api::ChurchesController < ApplicationController
before_action :set_church, only: [:show, :update, :destroy]

skip_before_action :doorkeeper_authorize!, only: :index
  # GET /churches
  def index
    @churches = Church.all

    render json: @churches
  end

  # GET /churches/1
  def show
    render json: @church
  end

  # POST /churches
  def create
    @church = Church.new(church_params)

    if @church.save
      render json: @church, status: :created, location: @church
    else
      render json: @church.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /churches/1
  def update
    if @church.update(church_params)
      render json: @church
    else
      render json: @church.errors, status: :unprocessable_entity
    end
  end

  # DELETE /churches/1
  def destroy
    @church.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def church_params
      #params.fetch(:church, {})
      params.require(:church).permit(:name, :address, :phone, :email, :photo, :priest)
    end
end
