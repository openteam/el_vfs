module ElVfs
  Engine.routes.draw do
    match '/api/el_finder' => 'el_finder#run'
    resources :entries
  end
end
