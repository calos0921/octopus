module Octopus
  module Persistence
    def update_attribute(...)
      run_on_shard { super(...) }
    end

    # For Rails 6.1+, update_attributes has been removed, so we alias it to update
    if defined?(ActiveRecord) && ActiveRecord::VERSION::MAJOR >= 6 && ActiveRecord::VERSION::MINOR >= 1
      def update_attributes(...)
        run_on_shard { update(...) }
      end

      def update_attributes!(...)
        run_on_shard { update!(...) }
      end
    else
      def update_attributes(...)
        run_on_shard { super(...) }
      end

      def update_attributes!(...)
        run_on_shard { super(...) }
      end
    end

    def update(...)
      run_on_shard { super(...) }
    end

    def update!(...)
      run_on_shard { super(...) }
    end

    def reload(...)
      run_on_shard { super(...) }
    end

    def delete
      run_on_shard { super }
    end

    def destroy
      run_on_shard { super }
    end

    def touch(...)
      run_on_shard { super(...) }
    end

    def update_column(...)
      run_on_shard { super(...) }
    end

    def increment!(...)
      run_on_shard { super(...) }
    end

    def decrement!(...)
      run_on_shard { super(...) }
    end
  end
end

ActiveRecord::Base.send(:include, Octopus::Persistence)
