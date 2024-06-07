class QueryCacheMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    ActiveRecord::Base.connection.enable_query_cache!
    @app.call(env)
  ensure
    ActiveRecord::Base.connection.clear_query_cache
    ActiveRecord::Base.connection.disable_query_cache!
  end
end

begin
  module Octopus
    class Railtie < Rails::Railtie
      rake_tasks do
        Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |ext| load ext }
      end
      initializer 'octopus.query_cache_middleware' do |app|
        app.config.middleware.use QueryCacheMiddleware
      end
    end
  end
rescue LoadError
  # nop
end
