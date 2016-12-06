class OMDB
  class << self
    def search(search_term)
      url = 'https://www.omdbapi.com/'
      conn = Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
      response = conn.get('/',{t: search_term, r: 'json'})
      movie = self.new_movie(JSON.parse(response.body))
    end
    def new_movie(movie_data)
      Movie.create({
        name: movie_data['Title'],
        year: movie_data['Year'],
        description: movie_data['Plot'],
        image: movie_data['Poster']
      })
    end
  end
end