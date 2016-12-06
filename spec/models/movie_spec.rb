# tests for Movie model
require 'rails_helper'
require 'test_factory'

describe Movie, :model do
  before(:all) do
    create_movies
  end
  after(:all) do
    Movie.destroy_all
  end
  describe 'Movie.search' do
    it 'returns a movie' do
      the_thing_from_another_world = Movie.search('The Thing From Another World')
      expect(the_thing_from_another_world.length).to be(1)
      expect(the_thing_from_another_world[0].year).to be(1951)
    end
    it 'returns multiple movies' do 
      movies = Movie.search('thing')
      expect(movies.length).to be(2)
    end
    it 'searches descriptions after titles' do
      the_thing = Movie.search('Kurt Russel')
      expect(the_thing.length).to be(1)
      expect(the_thing[0].name).to eq('The Thing')
    end
    it 'reaches to an external API if no movie is found' do
      cast_away = Movie.search('Cast Away')
      expect(cast_away.name).to eq('Cast Away')
    end
    it 'returns "No movies found" if nothing found' do 
      search_error = Movie.search('fe123ddddJibberish')
      expect(search_error.name).to eq('No movie found')
    end
  end
end