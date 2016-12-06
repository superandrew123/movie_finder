class AddDefaultNetflixAvailabilityToMovies < ActiveRecord::Migration
  def change
    change_column :movies, :netflix_availability, :string, default: '0'
  end
end
