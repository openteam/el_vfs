class ElVfs::Connector
  VALID_COMMANDS = %w[archive duplicate edit extract mkdir mkfile open paste ping read rename resize rm tmb upload]

  DEFAULT_OPTIONS = {
    #:mime_handler => ElFinderVFS::MimeType,
    #:image_handler => ElFinderVFS::Image,
    #:original_filename_method => lambda { |file| file.name },
    :disabled_commands => [],
    #:allow_dot_files => true,
    #:upload_max_size => '50M',
    #:upload_file_mode => 0644,
    :archivers => {},
    :extractors => {},
    #:home => 'Home',
    #:default_perms => {:read => true, :write => true, :rm => true},
    #:perms => [],
    #:thumbs => false,
    #:thumbs_directory => '.thumbs',
    #:thumbs_size => 48,
    #:thumbs_at_once => 5,
  }

  attr_accessor :options, :params, :response, :current, :target, :targets, :headers

  def initialize(options={})
    @options = DEFAULT_OPTIONS.merge options
  end

  def run(params={})
    self.params = params.dup
    self.headers = {}
    self.response = {}
    response[:errorData] = {}

    if VALID_COMMANDS.include?(params[:cmd])
      self.target = ElVfs::Entry.root
      self.current = nil
      if params[:current]
        self.current = self.target = ElVfs::Entry.find_by_hash(params[:target]) || ElVfs::Entry.root
      end

      if params[:targets]
        self.targets = params[:targets].map{ | hash | ElVfs::Entry.find_by_hash hash }
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

    def from_hash(hash)
      pathname = Base64.decode64(hash.tr("_", "\n"))
    end

    def _open
      if target.is_a? ElVfs::Directory
        response[:cwd] = cwd_for(target)
        response[:cdc] = target.children.sort_by{|e| e.basename.to_s.downcase}.map{|e| cdc_for(e)}.compact

        if params[:tree]
          response[:tree] = {
            :name => options[:home],
            :hash => root.hash,
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
        :hash => target.hash,
        :mime => 'directory',
        :rel =>  target.path,
        :size => 0,
        :date => target.updated_at.to_s,
      }.merge(target.permissions)
    end

end
