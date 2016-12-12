class TMDB
  @@key = Rails.application.secrets.tmdb_key

  def self.search(search_term)
    url = 'https://api.themoviedb.org/'
    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get('3/search/movie',{
        api_key: @@key,
        language: 'en-US',
        query: search_term,
        page: 1,
        include_adult: false
      })
    if response.status == 429
      # API over used, 40 requests per 10 seconds
      sleep 10
      return TMDB.search(search_term)
    end
    data = JSON.parse(response.body)['results']
    if data.length == 0
      return [Movie.new({
          title: 'No movies found',
          year: '',
          description: 'Sorry, friend. Try searching for another spelling.',
          image: 'http://localhost:3000/no_results.jpg'
        })]
    end
    movies_raw = TMDB.parse_response(data)
    movies = TMDB.create_movies(movies_raw)
  end

  private
    def self.parse_response(data)
      clean_data = data.collect do |movie|
        begin
          release_date = Date::strptime(movie['release_date'], "%Y-%m-%d")
        rescue
          next
        end
        {
          title: movie['title'],
          year: release_date.year,
          description: movie['overview'],
          image: movie['backdrop_path'],
          tmdb_id: movie['id'],
          release_date: release_date,
          popularity: movie['popularity']
        }
      end
      sorted_data = clean_data
        .select {|movie| !!movie}
        .sort_by {|movie| -movie[:popularity]}
        .first(5)
    end

    def self.create_movies(movies)
      movies.collect do |movie_temp|
        movie = Movie.find_by(tmdb_id: movie_temp[:tmdb_id])
        if movie == nil
          movie = Movie.create(
              title: movie_temp[:title],
              description: movie_temp[:description],
              year: movie_temp[:year],
              release_date: movie_temp[:release_date],
              image: movie_temp[:image],
              tmdb_id: movie_temp[:tmdb_id]
            )
        end
        movie
      end
    end
end