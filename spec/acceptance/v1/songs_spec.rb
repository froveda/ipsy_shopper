# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Songs' do
  include_context :json_headers
  
  get 'v1/songs' do
    let(:unfeatured_song)   { create(:song) }
    let(:featured_song)     { create(:featured_song) }

    example 'Listing songs', document: :v1 do
      explanation 'Retrieve all of the songs'

      unfeatured_song_serialized = JSON.parse(SongSerializer.new(unfeatured_song).to_json)
      featured_song_serialized = JSON.parse(SongSerializer.new(featured_song).to_json)
      
      do_request

      response = JSON.parse(response_body)
      expect(response['songs']).to include(unfeatured_song_serialized)
      expect(response['songs']).to include(featured_song_serialized)
      expect(status).to eq(200)
    end
  end
  
  get 'v1/songs/:id' do
    let(:unfeatured_song) { create(:song) }
    let(:featured_song) { create(:song) }
    
    example 'Retrieve an unfeatured song', document: :v1 do
      explanation 'Retrieve an unfeatured song'
      unfeatured_song_serialized = JSON.parse(SongSerializer.new(unfeatured_song).to_json)
      
      do_request(id: unfeatured_song.id)
      
      response = JSON.parse(response_body)
      expect(response).to eq(unfeatured_song_serialized)
      expect(status).to eq(200)
    end

    example 'Retrieve a featured song', document: :v1 do
      explanation 'Retrieve a featured song'
      featured_song_serialized = JSON.parse(SongSerializer.new(featured_song).to_json)

      do_request(id: featured_song.id)
      
      response = JSON.parse(response_body)
      expect(response).to eq(featured_song_serialized)
      expect(status).to eq(200)
    end
  end

  post 'v1/songs' do
    with_options scope: :song, required: true do
      parameter :name, 'Song name'
      parameter :duration, 'Duration of the song in seconds'
      parameter :genre, 'Genre of the song'
      parameter :album_id, 'Album which the song belongs to'
    end
  
    with_options scope: :song do
      parameter :featured, 'Song featured (true) or not featured (false). Default value is false'
      parameter :here, 'Image of a featured song'
      parameter :description, 'Description of a featured song'
    end

    let(:album)         { create(:album) }
    let(:song_params)   {
                          {
                            name: 'Song 1',
                            duration: 500,
                            genre: 'Rock',
                            featured:  false,
                            album_id: album.id.to_s
                          }
                        }

    let(:raw_post) { song_params.to_json }
  
    example 'Creating a song', document: :v1 do
      explanation 'Creates a son'
      
      do_request
      
      song = Song.last
      expect(song.name).to eq('Song 1')
      expect(song.duration).to eq(500)
      expect(song.genre).to eq('Rock')
      expect(song.featured).to eq(false)
      expect(song.album).to eq(album)
      expect(status).to eq(201)
    end
  end

  put 'v1/songs/:id' do
    with_options scope: :song, required: true do
      parameter :name, 'Song name'
      parameter :duration, 'Duration of the song in seconds'
      parameter :genre, 'Genre of the song'
      parameter :album_id, 'Album which the song belongs to'
    end
  
    with_options scope: :song do
      parameter :featured, 'Song featured (true) or not featured (false). Default value is false'
      parameter :here, 'Image of a featured song'
      parameter :description, 'Description of a featured song'
    end
  
    let(:album)         { create(:album) }
    let(:song)          { create(:song) }
    let(:id)            { song.id.to_s }
    let(:song_params)   {
                          {
                            name: 'Song 20',
                            duration: 30,
                            genre: 'Pop',
                            featured:  false,
                            album_id: album.id.to_s
                          }
                        }
  
    let(:raw_post) { song_params.to_json }
  
    example 'Updating a song', document: :v1 do
      explanation 'Updates a song with ID <strong>:id</strong>.'
      
      do_request
      
      song = Song.find(id)
      expect(song.id).to eq(song.id)
      expect(song.name).to eq('Song 20')
      expect(song.duration).to eq(30)
      expect(song.genre).to eq('Pop')
      expect(song.featured).to eq(false)
      expect(song.album).to eq(album)
      
      expect(status).to eq(200)
    end
  end
  
  delete 'v1/songs/:id' do
    let(:song)  { create(:song) }
    let(:id)    { song.id.to_s }

    example 'Deleting a song', document: :v1 do
      explanation 'Deletes a song'
      
      do_request
      
      expect(Song.count).to eq(0)
      expect(status).to eq(204)
    end
  end
end
