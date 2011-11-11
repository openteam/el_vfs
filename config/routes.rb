Vfs::Engine.routes.draw do
  resources :files

  resources :folders

  resources :entries
end
