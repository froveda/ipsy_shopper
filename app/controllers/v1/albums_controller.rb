# frozen_string_literal: true

module V1
  # Album API Controller
  class AlbumsController < V1::BaseController
    private
    
    def set_collection
      @collection = Album.all
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Album.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def resource_params
      params.require(:album).permit(:name, :art, :artist_id)
    end
  
    def resource_class
      Album
    end
  end
end
