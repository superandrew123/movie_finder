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
          name: 'No movie found',
          year: 0,
          description: 'Sorry, friend. Try searching for another spelling.',
          image: 'error_poster.jpg'
        })
    else 
      movie = self.new_movie(body)
    end
  end
  def self.new_movie(movie_data)
    Movie.create({
      name: movie_data['Title'],
      year: movie_data['Year'],
      description: movie_data['Plot'],
      image: movie_data['Poster']
    })
  end
end