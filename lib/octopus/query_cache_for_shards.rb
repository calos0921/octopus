# query cache methods are moved to ConnectionPool for Rails >= 5.0
module Octopus
  module ConnectionPool
    module QueryCacheForShards
      %i(enable_query_cache! disable_query_cache!).each do |method|
        define_method(method) do
          if Octopus.enabled? && (
            (shards = ActiveRecord::Base.connection.shards)['master'] == self ||
            (defined?(PhusionPassenger) && self.db_config.name == 'primary')
          )
            shards.each do |shard_name, v|
              if shard_name == 'master'
                super()
              else
                v.public_send(method)
              end
            end
          else
            super()
          end
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::ConnectionPool.send(:prepend, Octopus::ConnectionPool::QueryCacheForShards)
