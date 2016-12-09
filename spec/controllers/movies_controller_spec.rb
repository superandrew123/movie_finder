require 'rails_helper'
require 'test_factory'

describe MoviesController, type: :controller do
  before(:all) do
    create_movies
  end

  after(:all) do
    Movie.destroy_all
  end

  it '#search returns JSON objects' do
    response = get('search', q: 'the thing')
    movie_data = JSON.parse(response.body)
    expect(movie_data.length).to eq(2)
  end
end
