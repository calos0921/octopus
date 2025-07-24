module Octopus
  module Persistence
    def update_attribute(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    # For Rails 6.1+, update_attributes has been removed, so we alias it to update
    if defined?(ActiveRecord) && ActiveRecord::VERSION::MAJOR >= 6 && ActiveRecord::VERSION::MINOR >= 1
      def update_attributes(*args, **kwargs)
        run_on_shard { update(*args, **kwargs) }
      end

      def update_attributes!(*args, **kwargs)
        run_on_shard { update!(*args, **kwargs) }
      end
    else
      def update_attributes(*args, **kwargs)
        run_on_shard { super(*args, **kwargs) }
      end

      def update_attributes!(*args, **kwargs)
        run_on_shard { super(*args, **kwargs) }
      end
    end

    def update(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update!(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def reload(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def delete
      run_on_shard { super }
    end

    def destroy
      run_on_shard { super }
    end

    def touch(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update_column(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def increment!(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def decrement!(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end
  end
end

ActiveRecord::Base.send(:include, Octopus::Persistence)
