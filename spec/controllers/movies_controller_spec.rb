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
  it '#search returns JSON object' do
    response = get('search', q: 'the thing')
    movie_data = JSON.parse(response.body)
    availability_data = get('availability', q: movie_data[0]['id'])
    availability_json = JSON.parse(availability_data.body)
    expect(availability_json['netflix']).to eq('Disk available, no streaming.')
  end
  it '#expand_search returns JSON objects' do
    response = get('expand_search', q: 'the thing')
    movie_data = JSON.parse(response.body)
    expect(movie_data.length).to eq(5)
  end
end
