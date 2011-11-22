
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

  def el_hash
    methods.select{|m| method(m).owner == self.class}.inject({}){|h,m| h[m] = to_el_hash(send(m)); h}
  end

  def to_el_hash(object)
    if object.respond_to?(:el_hash)
      object = object.el_hash.tap do | hash |
        hash.each do | key, value |
        hash[key] = to_el_hash(value)
        end
      end
    elsif object.is_a? Array
      object.map!{|o| to_el_hash(o)}
    end
    object
  end
end
