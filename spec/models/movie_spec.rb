# tests for Movie model
require 'rails_helper'
require 'test_factory'

describe Movie, :model do

  xdescribe 'Movie#availability' do
    it 'checks Netflix for a movie on disk only' do 
      the_thing = Movie.search('the thing')[0]
      availability = the_thing.available?
      expect(availability[:netflix]).to eq('Disk available, no streaming.')
    end
    it 'checks Netflix for a movie available for streaming' do 
      star_trek_nemesis = Movie.search('star trek: nemesis')[0]
      availability = star_trek_nemesis.available?
      expect(availability[:netflix]).to eq('Streaming available!')
    end
    it 'checks Amazon Prime for a movie available for streaming' do
      star_trek_wrath = Movie.search('Star Trek II: The Wrath of Khan')[0]
      availability = star_trek_wrath.available?
      expect(availability[:amazon]).to eq('Streaming avaialbile with Prime Membership.')
    end
    it 'checks Amazon Prime for a movie not available for streaming' do
      elf = Movie.search('Elf')[0]
      availability = elf.available?
      expect(availability[:amazon]).to eq('Free streaming not available.')
    end
  end
  describe 'Movie.search' do
    before(:all) do
      create_movies
    end

    after(:all) do
      Movie.destroy_all
    end

    it 'returns a movie' do
      the_thing_from_another_world = Movie.search('The Thing From Another World')
      expect(the_thing_from_another_world.count).to be(1)
      expect(the_thing_from_another_world[0][:year]).to be(1951)
    end
    it 'returns multiple movies' do 
      movies = Movie.search('thing')
      expect(movies.count).to be(2)
    end
    it 'searches descriptions after titles' do
      # Need to sort out the logic on when to get here
      the_thing = Movie.search_description('Kurt Russel')
      expect(the_thing.count).to be(1)
      expect(the_thing[0][:name]).to eq('The Thing')
    end
    it 'reaches to an external API if no movie is found' do
      cast_away = Movie.search('Cast Away')
      expect(cast_away[0][:name]).to eq('Cast Away')
    end
    it 'returns "No movies found" if nothing found' do 
      search_error = Movie.search('fe123ddddJibberish')
      expect(search_error[0][:name]).to eq('No movie found')
    end
  end
end