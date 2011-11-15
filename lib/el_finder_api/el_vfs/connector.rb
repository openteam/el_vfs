class ElVfs::Connector

  def self.commands
    @commands ||= {}.with_indifferent_access
  end

  def command_for(params)
    params = params.dup
    command_class_for(params.delete(:cmd)).new(params)
  end

  private
    def command_class_for(command_name)
      self.class.commands[command_name] || self.class.commands[:unknown]
    end
end

Dir[File.expand_path( '../command/*', __FILE__ )].each do | command | require_or_load command end
