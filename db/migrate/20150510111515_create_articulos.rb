class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :codigo
      t.string :nombre
      t.string :referencia
      t.integer :stock
      t.integer :color
      t.string :nombre_color
      t.integer :talla
      t.string :nombre_talla

      t.timestamps null: false
    end
    add_index :articulos, :codigo
    add_index :articulos, :nombre
    add_index :articulos, :referencia
    add_index :articulos, :nombre_color
    add_index :articulos, :nombre_talla
  end
end
