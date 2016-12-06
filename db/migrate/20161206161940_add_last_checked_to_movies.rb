class AddLastCheckedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :last_checked, :date, default: Date.new(0)
  end
end
