# frozen_string_literal: true

module V1
  # Artist API Controller
  class ArtistsController < ApplicationController
    include BasicApiActions
    
    private
    
    def resource_params
      params.require(:artist).permit(:name, :bio)
    end
  
    def resource_class
      Artist
    end
  end
end
