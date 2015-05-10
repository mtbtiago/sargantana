class ArticulosController < ApplicationController
  def index
    @articulos = Articulo.where(referencia: 'CE5402').paginate(:page => params[:page], :per_page => 10).order('stock DESC')
  end
end
