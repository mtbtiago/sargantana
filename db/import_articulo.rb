# rails g model Articulo codigo:string:index nombre:string:index referencia:string:index stock:integer color:integer nombre_color:string:index talla:integer nombre_talla:string:index

# with help from http://www.yamllint.com/

# Articulo.select(:nombre_talla).distinct

def load_from_yaml_file(model)
  model_name = model.name.downcase

  ActiveRecord::Base.connection.execute("TRUNCATE #{model_name}s RESTART IDENTITY")

  yml = YAML.load_file("db/#{model_name}.yml")
  ActiveRecord::Base.transaction do
    yml[model_name]['records'].each do |rec|
      rec_hash = Hash[yml[model_name]['columns'].zip(rec)]
      color_talla = rec_hash['nombre'].match(/.+?'(.*?)-(.*?)'/)
      rec_hash['nombre_color'] = color_talla[1]
      rec_hash['nombre_talla'] = color_talla[2]
      model.create(rec_hash)
    end
  end
end
