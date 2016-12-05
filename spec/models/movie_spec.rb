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
  describe 'Movie class methods' do
    it 'Movie.search returns a movie' do
      the_thing_from_another_world = Movie.search('The Thing From Another World')
      expect(the_thing_from_another_world.length).to be(1)
      expect(the_thing_from_another_world[0].year).to be(1951)
    end
    it 'Movie.search returns multiple movies' do 
      movies = Movie.search('thing')
      expect(movies.length).to be(2)
    end
    it 'Movie.search searches descriptions after titles' do
      the_thing = Movie.search('Kurt Russel')
      expect(the_thing.length).to be(1)
      expect(the_thing[0].name).to eq('The Thing')
    end
  end
end