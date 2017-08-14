# frozen_string_literal: true

module V1
  # Songs API Controller
  class SongsController < V1::BaseController
    private
    
    def set_collection
      @collection = Song.all
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Song.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def resource_params
      params.require(:song).permit(:name, :duration, :genre, :featured, :here, :description, :album_id)
    end
  
    def resource_class
      Song
    end
  end
end
