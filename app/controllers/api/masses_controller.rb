require 'date'
class Api::MassesController < ApplicationController
before_action :set_mass, only: [:show, :update, :destroy]

skip_before_action :doorkeeper_authorize!, only: [:index, :getMassesByDate]
  # GET /masses
  def index
    @masses = Mass.all
    
    render json: @masses

  end

  def getMassesByDate
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]

    @dayOfWeek = (Date.new(@year.to_i, @month.to_i , @day.to_i).wday + 1)

    @massesList = []
    (1..17).each do |n|
      @masses = Mass.where("schedule LIKE ?", "%#{@dayOfWeek}_#{(n+6)}%")
      
      
      @churches = []
      if (@masses.present?)
         @masses.each do |r|
           @churches.push({"church_name" => r.church.name})
         end
      end

      @massesList.push({"day" => @dayOfWeek, "hour" => (n+6), "masses": @churches})
    end
        
    render json: @massesList

  end 

  # GET /masses/1
  def show
    render json: mass
  end

  # POST /masses
  def create
    #delete the current values
    Mass.where(:church_id => mass_params[:church_id]).destroy_all


    mass = Mass.new(mass_params)
    if mass.save
      render json: mass, status: :created, location: mass
    else
      render json: mass.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /masses/1
  def update
    if mass.update(mass_params)
      render json: mass
    else
      render json: mass.errors, status: :unprocessable_entity
    end
  end

  # DELETE /masses/1
  def destroy
    mass.destroy
  end

  def getMassesByChurch
    @church = Church.find(params[:church_id])
    @masses = Mass.where(:church_id => params[:church_id])
    
    render json: {:church_name => @church.name, :masses => @masses} 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mass
      mass = Mass.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mass_params
      #params.fetch(:Mass, {})
      params.require(:Mass).permit(:day, :schedule, :priest, :church_id)
    end
end
