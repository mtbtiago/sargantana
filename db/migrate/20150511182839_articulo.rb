class Articulo < ActiveRecord::Migration
  def change
    add_index(:articulos, :stock, name: 'idx_stock_asc', order: {stock: :asc})
    add_index(:articulos, :stock, name: 'idx_stock_desc', order: {stock: :desc})
  end
end
