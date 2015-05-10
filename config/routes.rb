Rails.application.routes.draw do
  get 'articulos/index'

  root 'articulos#index'

  get 'articulos', to: 'articulos#index'
end
