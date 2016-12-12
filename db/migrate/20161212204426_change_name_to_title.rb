class ChangeNameToTitle < ActiveRecord::Migration
  def change
    rename_column :movies, :name, :title
    add_column :movies, :tmdb_id, :string
  end
end
