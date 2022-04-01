Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  resources :tags
  resource :labelleds,  except: [ :update]
  resources :labelleds,  only: [:edit, :update] #se crea un bug al renderizar el form para actualizar el labelled(asingnacion de etiqueta y tarea) solicita labelleds_path y no labelled_path, :S
end
