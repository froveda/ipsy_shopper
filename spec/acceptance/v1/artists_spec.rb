# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Artists' do
  include_context :json_headers
  
  get 'v1/artists' do
    let(:song)      { create(:song) }
    let(:album)     { song.album }
    let(:artist)    { album.artist }

    example 'Listing artists', document: :v1 do
      explanation 'Retrieve all of the artists'

      artist_serialized = JSON.parse(ArtistSerializer.new(artist).to_json)
      
      do_request

      response = JSON.parse(response_body)
      expect(response['artists']).to include(artist_serialized)
      expect(status).to eq(200)
    end
  end
  
  get 'v1/artists/:id' do
    let(:artist)  { create(:artist) }
    let(:id)      { artist.id }

    example 'Retrieve an artist', document: :v1 do
      explanation 'Retrieve an artist'
      artist_serialized = JSON.parse(ArtistSerializer.new(artist).to_json)

      do_request

      response = JSON.parse(response_body)
      expect(response).to eq(artist_serialized)
      expect(status).to eq(200)
    end
  end

  post 'v1/artists' do
    with_options scope: :artist, required: true do
      parameter :name, 'Artist name'
    end

    with_options scope: :artist do
      parameter :bio, 'Artist biography'
    end
    
    let(:artist_params) do
      {
        name: 'Artist 1',
        bio: 'Artist Biography'
      }
    end

    let(:raw_post) { artist_params.to_json }

    example 'Creating an artist', document: :v1 do
      explanation 'Creates an artist'

      do_request

      artist = Artist.last
      expect(artist.name).to eq('Artist 1')
      expect(artist.bio).to eq('Artist Biography')
    end
  end

  put 'v1/artists/:id' do
    with_options scope: :artist, required: true do
      parameter :name, 'Artist name'
    end
  
    with_options scope: :artist do
      parameter :bio, 'Artist biography'
    end
    
    let(:artist)          { create(:artist) }
    let(:id)              { artist.id.to_s }
    let(:artist_params) do
      {
        name: 'Artist 1',
        bio: 'Artist Biography'
      }
    end

    let(:raw_post) { artist_params.to_json }

    example 'Updating an artist', document: :v1 do
      explanation 'Updates an artist with ID <strong>:id</strong>.'

      do_request

      artist = Artist.find(id)
      expect(artist.name).to eq('Artist 1')
      expect(artist.bio).to eq('Artist Biography')
      expect(status).to eq(200)
    end
  end

  delete 'v1/artists/:id' do
    let(:artist) { create(:artist) }
    let(:id)     { artist.id.to_s }

    example 'Deleting an artist', document: :v1 do
      explanation 'Deletes an artist'

      do_request

      expect(Artist.count).to eq(0)
      expect(status).to eq(204)
    end
  end
end
