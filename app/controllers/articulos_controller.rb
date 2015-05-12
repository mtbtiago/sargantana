class ArticulosController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      Articulo,
      params[:filterrific],
      :select_options => {
        sorted_by: Articulo.options_for_sorted_by
      }
    ) or return 
    @articulos = @filterrific.find.page(params[:page])
    @colores = Articulo.search_query(@filterrific.search_query).map{|e| e[:nombre_color]}.uniq
    @tallas = Articulo.search_query(@filterrific.search_query).map{|e| e[:nombre_talla]}.uniq

    respond_to do |format|
      format.html
      format.js
    end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # @articulos = Articulo.where(referencia: 'CE5402').paginate(:page => params[:page], :per_page => 10).order('stock DESC')
  # @articulos = Articulo.where('referencia >= ?', 'CE5').paginate(page: params[:page]).order('referencia, talla')
end
