require "polymorphic_url_cache/version"

module PolymorphicUrlCache
  extend ActiveSupport::Concern
  included do
    alias_method_chain :url_for, :cache
  end

  URL_FOR_CACHE = {}

  def url_for_with_cache(options = nil)
    key = case options
    when ActiveRecord::Base
      [options.class, options.to_param]
    when Array
      return url_for_without_cache(options) if options.none? {|o| o.is_a? ActiveRecord::Base}

      options.each_with_object([]) do |o, k|
        if o.is_a? ActiveRecord::Base
          k << [options.class, options.to_param]
        else
          k << o
        end
      end
    else
      return url_for_without_cache(options)
    end

    URL_FOR_CACHE[key] || (URL_FOR_CACHE[key] = url_for_without_cache(options))
  end
end

ActionView::RoutingUrlFor.include PolymorphicUrlCache
