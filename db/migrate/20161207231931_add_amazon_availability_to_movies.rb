class AddAmazonAvailabilityToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :amazon_availability, :string, default: '0'
  end
end
