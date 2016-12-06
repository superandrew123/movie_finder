class Movie < ActiveRecord::Base

  # Class methods
  class << self
    def search(search_term)
      movies = self.search_name(search_term)
      movies.length == 0 ? self.external_search(search_term) : movies
    end

    def search_name(search_term)
      Movie.where('lower(name) like ?', '%' + search_term.downcase + '%')
    end

    def search_description(search_term)
      Movie.where('lower(description) like ?', '%' + search_term.downcase + '%')
    end

    def external_search(search_term)
      # reach out to OMDB
      search_data = OMDb.search(search_term)
    end
  end
end
