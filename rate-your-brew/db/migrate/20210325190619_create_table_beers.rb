class CreateTableBeers < ActiveRecord::Migration[6.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :description
      t.float :abv
      t.integer :rating
      t.references :user
    end
  end
end
