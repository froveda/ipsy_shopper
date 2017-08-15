# frozen_string_literal: true

module V1
  # Songs API Controller
  class SongsController < ApplicationController
    include BasicApiActions
    
    private

    def resource_params
      params.require(:song).permit(:name, :duration, :genre, :featured, :here, :description, :album_id)
    end
  
    def resource_class
      Song
    end
  end
end
