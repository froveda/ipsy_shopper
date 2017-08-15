# frozen_string_literal: true

module V1
  # Album API Controller
  class AlbumsController < ApplicationController
    include BasicApiActions
    
    private
    
    def resource_params
      params.require(:album).permit(:name, :art, :artist_id)
    end
  
    def resource_class
      Album
    end
  end
end
