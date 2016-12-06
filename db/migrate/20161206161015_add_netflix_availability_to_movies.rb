class AddNetflixAvailabilityToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :netflix_availability, :string
  end
end
