class Movie < ActiveRecord::Base
  before_create :default_last_checked

  def available?
    if (Date.today - self.last_checked).to_i > 7
      # netflix? will check for and set the netflix_availability
      self.netflix_availability = self.netflix?
      self.amazon_availability = self.amazon?
      self.last_checked = Date.today
      self.save
    end
    {
      netflix: self.netflix_availability,
      amazon: self.amazon_availability
    }
  end

  def netflix?
    Netflix.availability(self.name)
  end
  def amazon?
    Amazon.availability(self.name, self.year)
  end

  def default_last_checked
    self.last_checked = 3.weeks.ago
  end

  # Class methods
  def self.search(search_term)
    movies = Movie.search_name(search_term)
    if movies.count == 0
      movies = Movie.external_search(search_term)
    end

    movies.collect do |movie|
      {
        name: movie.name,
        year: movie.year,
        description: movie.description,
        image: movie.image
      }
    end
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