class OMDB
  def self.search(search_term)
    url = 'https://www.omdbapi.com/'
    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get('/',{t: search_term, r: 'json'})
    body = JSON.parse(response.body)

    if body['Response'] == 'False'
      movie = Movie.new({
          title: 'No movie found',
          year: '',
          description: 'Sorry, friend. Try searching for another spelling.',
          image: 'http://localhost:3000/no_results.jpg'
        })
    else 
      movie = self.new_movie(body)
    end
    [movie]
  end

  def self.new_movie(movie_data)
    movie = Movie.find_by(imdb_id: movie_data['imdbID'])
    if movie == nil
      movie = Movie.create({
        title: movie_data['Title'],
        year: movie_data['Year'],
        description: movie_data['Plot'],
        image: movie_data['Poster'],
        imdb_id: movie_data['imdbID']
      })
    end
    movie
  end
end