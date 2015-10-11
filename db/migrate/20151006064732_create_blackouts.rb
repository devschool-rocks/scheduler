class CreateBlackouts < ActiveRecord::Migration
  def change
    create_table :blackouts do |t|
      t.references :instructor, index: true, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
