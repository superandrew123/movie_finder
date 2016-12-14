class MoviesController < ApplicationController
  
  def search
    # Return the movies based on a search term
    search_term = search_params
    movies = Movie.search(search_term, true)
    render json: movies
  end

  def expand_search
    movies = Movie.hash_data(TMDB.search(search_params))
    render json: movies
  end

  def availability
    # Return availability
    movie = Movie.find_by(id: availability_params)
    if movie
      availability = movie.available?
      render json: availability
    else
      render json: {
        error: 'Please try again.'
      }
    end
  end

  private
    def search_params
      params.require(:q)
    end
    def availability_params
      params.require(:q)
    end
end
