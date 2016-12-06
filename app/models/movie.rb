class Movie < ActiveRecord::Base
  def self.search(search_term)
    movies = self.search_name(search_term)
    if movies.length == 0
      movies = self.search_description(search_term)
    end
    movies.length == 0 ? self.external_search(search_term) : movies
  end

  def self.search_name(search_term)
    Movie.where('lower(name) like ?', '%' + search_term.downcase + '%')
  end

  def self.search_description(search_term)
    Movie.where('lower(description) like ?', '%' + search_term.downcase + '%')
  end

  def self.external_search(search_term)
    # reach out to OMDB
    search_data = OMDB.search(search_term)
    binding.pry
  end
end
