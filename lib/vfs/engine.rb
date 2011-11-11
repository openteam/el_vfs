module ActionDispatch::Routing
  class Mapper
    def engine_routing
      resources :entries
    end
  end
end

module Vfs
  class Engine < Rails::Engine
    isolate_namespace Vfs
    config.generators do |generators|
      generators.fixture_replacement  :fabrication
      generators.test_framework       :rspec,
                                      :view_specs => false,
                                      :helper_specs => false #, routing_specs => false
      generators.stylesheet_engine    :sass
      generators.helper               false
      generators.assets               false
      generators.stylesheets          false
    end
  end
end
