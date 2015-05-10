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

FactoryGirl.define do
  factory :articulo do
    codigo "MyString"
nombre "MyString"
referencia "MyString"
stock 1
color 1
nombre_color "MyString"
talla 1
nombre_talla "MyString"
  end

end
