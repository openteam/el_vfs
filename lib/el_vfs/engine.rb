require 'ancestry'
require 'default_value_for'

module ElVfs
  class Engine < Rails::Engine
    isolate_namespace ElVfs

    initializer 'el_vfs.initialize_dragonfly', :after => :set_load_path do |app|
      require_or_load("#{paths['config'].first}/dragonfly")
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

