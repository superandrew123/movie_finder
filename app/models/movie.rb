class Movie < ActiveRecord::Base
  def self.search(search_term)
    movies = self.search_name(search_term)
    if movies.length == 0
      movies = self.search_description(search_term)
    end
    movies.length == 0 ? 'No results found' : movies
  end

  def self.search_name(search_term)
    Movie.where('lower(name) like ?', '%' + search_term.downcase + '%')
  end

  def self.search_description(search_term)
    Movie.where('lower(description) like ?', '%' + search_term.downcase + '%')
  end
end
