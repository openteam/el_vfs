module ElVfs
  Engine.routes.draw do
    match '/api/elfinder' => 'el_finder#run'
    resources :entries
  end
end
