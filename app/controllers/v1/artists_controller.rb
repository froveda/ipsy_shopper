# frozen_string_literal: true

module V1
  # Artist API Controller
  class ArtistsController < V1::BaseController
    private
    
    def set_collection
      @collection = Artist.all
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Artist.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def resource_params
      params.require(:artist).permit(:name, :bio)
    end
  
    def resource_class
      Artist
    end
  end
end
