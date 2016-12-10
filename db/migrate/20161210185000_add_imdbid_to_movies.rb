class AddImdbidToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_id, :string, default: '0'
  end
end
