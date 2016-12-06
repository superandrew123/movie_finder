class Movie < ActiveRecord::Base
  before_create :default_last_checked

  def available?
    if (Date.today - self.last_checked).to_i > 7
      self.netflix?
      self.last_checked = Date.today
      self.save
    end
  end

  def netflix?
  end

  def default_last_checked
    self.last_checked = 3.weeks.ago
  end

  # Class methods
    def self.search(search_term)
      movies = Movie.search_name(search_term)
      movies.length == 0 ? Movie.external_search(search_term) : movies
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
    end
end