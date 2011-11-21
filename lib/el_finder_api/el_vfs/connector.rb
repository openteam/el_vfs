class ElVfs::Connector

  def self.commands
    @commands ||= {}.with_indifferent_access
  end

  def command_for(params)
    params = params.dup
    command_name = params.delete(:cmd)
    params.delete(:format)
    params.delete(:controller)
    params.delete(:action)
    command_class_for(command_name).new(params)
  end

  def execute(params)
    command = command_for(params)
    command.run
    to_el_hash command.result || command.error
  end

  private
    def to_el_hash(object)
      if object.respond_to?(:el_hash)
        object = object.el_hash.tap do | hash |
          hash.each do | key, value |
            hash[key] = to_el_hash(value)
          end
        end
      elsif object.is_a? Array
        object.map{|o| to_el_hash(o)}
      end
      object
    end

    def command_class_for(command_name)
      self.class.commands[command_name] || self.class.commands[:unknown]
    end
end

Dir[File.expand_path( '../command/*', __FILE__ )].each do | command | require_or_load command end
