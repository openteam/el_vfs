class Vfs::Connector
  VALID_COMMANDS = %w[archive duplicate edit extract mkdir mkfile open paste ping read rename resize rm tmb upload]

  attr_accessor :options, :params, :response, :current, :target, :targets, :headers

  def initialize(options={})
    @options = options
  end

  def run(params={})
    self.params = params.dup
    self.headers = {}
    self.response = {}
    response[:errorData] = {}

    if VALID_COMMANDS.include?(params[:cmd])

      self.current = params[:current] ? from_hash(params[:current]) : nil
      self.target = Vfs::Entry.find_by_name(from_hash(params[:target])) || Vfs::Entry.root
      if params[:targets]
        self.targets = params[:targets].map{|t| from_hash(t)}
      end

      send("_#{params[:cmd]}")
    else
      invalid_request
    end

    response.delete(:errorData) if response[:errorData].empty?
  end

  def root
    '/'
  end

  private
    def invalid_request
      response[:error] = "Invalid command '#{params[:cmd]}'"
    end

    def to_hash(pathname)
      Base64.encode64(pathname.path.to_s).chomp.tr("\n", "_")
    end


    def from_hash(hash)
      pathname = Base64.decode64(hash.tr("_", "\n"))
    end

    def _open
      if target.is_a? Vfs::Folder
        response[:cwd] = cwd_for(target)
        response[:cdc] = target.children.sort_by{|e| e.basename.to_s.downcase}.map{|e| cdc_for(e)}.compact

        if params[:tree]
          response[:tree] = {
            :name => options[:home],
            :hash => to_hash(root),
            :dirs => tree_for(root),
          }.merge(perms_for(root))
        end

        if params[:init]
          response[:disabled] = options[:disabled_commands]
          response[:params] = {
            :dotFiles => options[:allow_dot_files],
            :uplMaxSize => options[:upload_max_size],
            :archives => options[:archivers].keys,
            :extract => options[:extractors].keys,
            :url => options[:url]
          }
        end

      else
        response[:error] = "Directory does not exist"
        _open(root)
      end

    end

    def cwd_for(target)
      {
        :name => target.name,
        :hash => to_hash(target.name),
        :mime => 'directory',
        :rel => pathname.is_root? ? @options[:home] : (@options[:home] + '/' + pathname.path.to_s),
        :size => 0,
        :date => pathname.mtime.to_s,
      }.merge(perms_for(pathname))
    end

end
