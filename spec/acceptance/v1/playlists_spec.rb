# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

resource 'Playlists' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  
  get 'v1/playlists' do
   let(:song_a)      { create(:song, name: 'Song A') }
   let(:song_b)      { create(:song, name: 'Song B') }
   let(:playlist)    { create(:playlist, songs: [song_a, song_b]) }

    example 'Listing playlists', document: :v1 do
      explanation 'Retrieve all of the playlists'

      playlist_serialized = JSON.parse(PlaylistSerializer.new(playlist).to_json)
      
      do_request

      response = JSON.parse(response_body)
      expect(response['playlists']).to include(playlist_serialized)
      expect(status).to eq(200)
    end
  end
  
  get 'v1/playlists/:id' do
    let(:song_a)      { create(:song, name: 'Song A') }
    let(:song_b)      { create(:song, name: 'Song B') }
    let(:playlist)    { create(:playlist, songs: [song_a, song_b]) }
    let(:id)          { playlist.id }

    example 'Retrieving a playlist', document: :v1 do
      explanation 'Retrieves a playlist'
      playlist_serialized = JSON.parse(PlaylistSerializer.new(playlist).to_json)

      do_request

      response = JSON.parse(response_body)
      expect(response).to eq(playlist_serialized)
      expect(status).to eq(200)
    end
  end

  post 'v1/playlists' do
    with_options scope: :playlist, required: true do
      parameter :name, 'Playlist name'
    end

    with_options scope: :playlist do
      parameter :song_ids, 'Array of song IDs'
    end
    
    let(:song_a)      { create(:song, name: 'Song A') }
    let(:song_b)      { create(:song, name: 'Song B') }
    
    let(:playlist_params) do
      {
        name: 'Playlist 1' ,
        song_ids: [ song_a.id.to_s, song_b.id.to_s ]
      }
    end

    let(:raw_post) { playlist_params.to_json }
    
    example 'Creating a playlist', document: :v1 do
      explanation 'Creates a playlist'

      do_request

      playlist = Playlist.last
      expect(playlist.name).to eq('Playlist 1')
      expect(playlist.songs).to  eq([ song_a, song_b ])
    end
  end

  put 'v1/playlists/:id' do
    with_options scope: :playlist, required: true do
      parameter :name, 'Playlist name'
    end
  
    with_options scope: :playlist do
      parameter :song_ids, 'Array of song IDs'
    end

    let(:song_a)      { create(:song, name: 'Song A') }
    let(:song_b)      { create(:song, name: 'Song B') }
    let(:playlist)    { create(:playlist) }
    let(:id)          { playlist.id.to_s }

    let(:playlist_params) do
      {
        name: 'Playlist 1' ,
        song_ids: [ song_a.id.to_s, song_b.id.to_s ]
      }
    end

    let(:raw_post) { playlist_params.to_json }
    
    example 'Updating a playlist', document: :v1 do
      explanation 'Updates a playlist with ID <strong>:id</sttong>.'

      do_request

      playlist = Playlist.find(id)
      expect(playlist.name).to eq('Playlist 1')
      expect(playlist.songs).to  eq([ song_a, song_b ])
    end
  end

  put 'v1/playlists/:id/add_songs' do
    with_options scope: :playlist do
      parameter :song_ids, 'Array of song IDs'
    end
  
    let(:song_a)      { create(:song, name: 'Song A') }
    let(:song_b)      { create(:song, name: 'Song B') }
    let(:song_c)      { create(:song, name: 'Song C') }
    
    let(:playlist)      { create(:playlist, songs: [song_a]) }
    let(:id)   { playlist.id.to_s }
  
    let(:playlist_params) do
      {
        song_ids: [ song_b.id.to_s, song_c.id.to_s ]
      }
    end
  
    let(:raw_post) { playlist_params.to_json }
  
    example 'Adding songs', document: :v1 do
      explanation 'Adds songs to a playlist with ID <strong>:id</sttong>.'
    
      do_request
    
      playlist = Playlist.find(id)
      expect(playlist.songs).to  eq([ song_a, song_b, song_c ])
    end
  end

  delete 'v1/playlists/:id' do
    let(:playlist) { create(:playlist) }
    let(:id)     { playlist.id.to_s }

    example 'Deleting a playlist', document: :v1 do
      explanation 'Deletes a playlist'

      do_request

      expect(Playlist.count).to eq(0)
      expect(status).to eq(204)
    end
  end
end
