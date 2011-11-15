require 'ancestry'
require 'default_value_for'

module ElVfs
  class Engine < Rails::Engine
    isolate_namespace ElVfs

    engine_root = File.expand_path("../../../", __FILE__)

    config.autoload_paths << "#{engine_root}/lib/el_finder_api"

    initializer 'el_vfs.initialize_dragonfly', :after => :set_load_path do | _ |
      require_or_load "#{engine_root}/config/dragonfly"
    end

    config.generators do |generators|
      generators.fixture_replacement  :fabrication
      generators.test_framework       :rspec,
                                      :view_specs => false,
                                      :helper_specs => false
      generators.stylesheet_engine    :sass
      generators.helper               false
      generators.assets               false
      generators.stylesheets          false
    end
  end
end

