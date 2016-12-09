class MoviesController < ApplicationController
  def search
    # Return the movies based on a search term
    search_term = search_params
    @movies = Movie.search(search_term)
    render json: @movies
  end

  def availability
    # Return availability
  end
  private
    def search_params
      params.require(:q)
    end
end
