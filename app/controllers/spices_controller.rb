class SpicesController < ApplicationController
    
    # if record is not found, respond with whatever follows the 'with:'
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all 
        render json: spices
    end

    def create
        new_spice = Spice.create(spice_params)
        render json: new_spice, status: 201 
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def find_spice
        Spice.find_by(id: params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Bird not found" }, status: :not_found
    end

end
