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

require 'rails_helper'

RSpec.describe Articulo, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
