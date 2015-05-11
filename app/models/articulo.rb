# == Schema Information
#
# Table name: articulos
#
#  id           :integer          not null, primary key
#  codigo       :string
#  nombre       :string
#  referencia   :string
#  stock        :integer
#  color        :integer
#  nombre_color :string
#  talla        :integer
#  nombre_talla :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Articulo < ActiveRecord::Base
  self.per_page = 10 # will_paginate

  filterrific(
    default_filter_params: { sorted_by: 'referencia_talla_asc' },
    available_filters: [
      :sorted_by,
      :with_nombre_color,
      :with_nombre_talla,
      :search_query
    ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # prepend '%' and append '%', remove duplicate '%'s
    terms = terms.map { |e|
      '%'+(e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(articulos.referencia) LIKE ?",
          "LOWER(articulos.nombre) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^codigo_/
      order("articulos.codigo #{ direction }")
    when /^referencia_talla_/
      order("articulos.referencia #{ direction }, articulos.talla #{ direction}")
    when /^nombre_/
      order("articulos.nombre #{ direction }")
    when /^stock_/
      order("articulos.stock #{ direction }")
    when /^nombre_color_/
      order("articulos.nombre_color #{ direction }")
    when /^nombre_talla_/
      order("articulos.nombre_talla #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_nombre_color, lambda { |nombre_colors|
    where(:nombre_color => [*nombre_colors])
  }

  scope :with_nombre_talla, lambda { |nombre_tallas|
    where(:nombre_talla => [*nombre_tallas])
  }

  def self.options_for_sorted_by
    [
      ['Referencia', 'referencia_talla_asc'],
      ['Código', 'codigo_asc'],
      ['Nombre', 'nombre_asc'],
      ['Stock de menos a más', 'stock_asc'],
      ['Stock de más a menos', 'stock_desc'],
      ['Talla', 'nombre_talla_asc'],
      ['Color', 'nombre_color_asc']
    ]
  end

end
