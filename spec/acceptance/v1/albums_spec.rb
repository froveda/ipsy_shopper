# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Albums' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  
  get 'v1/albums' do
    before do
      song = create(:song)
      @album = song.album
    end

    example 'Listing albums', document: :v1 do
      explanation 'Retrieve all of the albums'

      album_serialized = JSON.parse(AlbumSerializer.new(@album).to_json)
      
      do_request

      response = JSON.parse(response_body)
      expect(response['albums']).to include(album_serialized)
      expect(status).to eq(200)
    end
  end
  
  get 'v1/albums/:id' do
    let(:song)    { create(:song) }
    let(:album)   { song.album }
    let(:id)      { album.id }

    example 'Retrieving an album', document: :v1 do
      explanation 'Retrieves an album'
      album_serialized = JSON.parse(AlbumSerializer.new(album).to_json)

      do_request

      response = JSON.parse(response_body)
      expect(response).to eq(album_serialized)
      expect(status).to eq(200)
    end
  end

  post 'v1/albums' do
    with_options scope: :album, required: true do
      parameter :name, 'Album name'
      parameter :art, 'Album art'
      parameter :artist_id, 'Artist ID'
    end
    
    let(:artist)  { create(:artist) }
    
    let(:name)        { 'Album 1' }
    let(:art)         { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'sample.jpg')) }
    let(:artist_id)   { artist.id }

    example 'Creating an album', document: :v1 do
      explanation 'Creates an album'

      do_request

      album = Album.last
      expect(album.name).to eq('Album 1')
      expect(album.art.url).not_to  match(/\/uploads\/album\/art\/[a-z0-1]+\/sample\.jpg/)
      expect(album.artist).to eq(artist)
    end
  end

  put 'v1/albums/:id' do
    with_options scope: :album, required: true do
      parameter :name, 'Album name'
      parameter :art, 'Album art'
      parameter :artist_id, 'Artist ID'
    end

    let(:album)       { create(:album) }
    let(:artist)      { create(:artist) }

    let(:id)          { album.id.to_s }
    let(:name)        { 'Album 1' }
    let(:art)         { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'sample.jpg')) }
    let(:artist_id)   { artist.id }
    
    example 'Updating an album', document: :v1 do
      explanation 'Updates an album with ID <strong>:id</sttong>.'

      do_request

      album = Album.find(id)
      expect(album.name).to eq('Album 1')
      expect(album.art.url).not_to  match(/\/uploads\/album\/art\/[a-z0-1]+\/sample\.jpg/)
      expect(album.artist).to eq(artist)
    end
  end
  
  delete 'v1/albums/:id' do
    let(:album) { create(:album) }
    let(:id)     { album.id.to_s }

    example 'Deleting an album', document: :v1 do
      explanation 'Deletes an album'

      do_request

      expect(Album.count).to eq(0)
      expect(status).to eq(204)
    end
  end
end
