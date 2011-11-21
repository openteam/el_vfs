
class ElVfs::Model
  include ActiveModel::Validations

  class_attribute :options

  def initialize(params={})
    self.attributes = params
  end

  def attributes=(params)
    params.each do |attribute, value|
      send("#{attribute}=", value) if respond_to?("#{attribute}=") && value.present?
    end
  end

  def self.options(*args)
    self.options = args.map(&:to_s)
    attr_accessor *args
  end

end
