require 'rails_helper'

describe "TMDB api" do 
  it "returns a single object data set for a specific title" do
    search_results = TMDB.search('star trek nemesis')
    expect(search_results.length).to eq(1)
    expect(search_results[0].title).to eq('Star Trek: Nemesis')
  end
  it 'creates a new Movie and stores the TMDB id' do
    count = Movie.count
    TMDB.search('harry potter')
    count2 = Movie.count
    expect(count2).to be > count
  end
end