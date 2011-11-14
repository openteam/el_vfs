module ElVfs
  class Directory < Entry

    def mime
      'directory'
    end

    def date
      I18n.l(updated_at)
    end

    def size
      0
    end

    def rel
      entry_path[1..-1]
    end

    def read
      true
    end

    def write
      true
    end

    def rm
      true
    end

    def to_json
      super(:methods => %w[mime rel date size read write rm])
    end
  end
end
