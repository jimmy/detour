module Detour
  class Application < Sinatra::Base
    def self.public_dir
      "public"
    end

    set :static, true
    set :public, public_dir

    get '*' do
      File.read(File.join(Application.public_dir, 'index.html'))
    end
  end

  class Offline < ::Rack::Offline
    def initialize(app=nil, &block)
      root = Application.public_dir

      options = {
        :cache => true,
        :root => root
      }

      block = cache_block(Pathname.new(root)) unless block_given?

      super(options, &block)
    end

    private

      def cache_block(root)
        lambda do
          files = Dir[
            "#{root}/**/*.html",
            "#{root}/javascripts/**/*.js",
          ]

          files.each do |file|
            cache(Pathname.new(file).relative_path_from(root))
          end

          fallback(
            "/" => "/index.html"
          )
          network("*")
        end
      end
  end
end
