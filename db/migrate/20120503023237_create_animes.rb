class CreateAnimes < ActiveRecord::Migration
  def change
    create_table :animes do |t|
      t.string :name
      t.text :description
      t.boolean :approved, default: false
      t.integer :rating
      t.string :tags

      t.timestamps
    end
      add_index :animes, :name
      add_index :animes, :tags
  end
end
