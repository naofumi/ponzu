# Deprecated. Use kamishibai_will_pagination_helper.rb instead
module WillPaginate
  module ViewHelpers
    class KSLinkRenderer < LinkRenderer
      protected

      def default_url_params
        {}
      end

      def url(page)
        @base_url_params ||= begin
          url_params = merge_get_params(default_url_params)
          merge_optional_params(url_params)
        end

        url_params = @base_url_params.dup
        add_current_page_param(url_params, page)

        @template.url_for(url_params)
      end

      def merge_get_params(url_params)
        if @template.respond_to? :request and @template.request and @template.request.get?
          symbolized_update(url_params, @template.params)
        end
        url_params
      end

      def merge_optional_params(url_params)
        symbolized_update(url_params, @options[:params]) if @options[:params]
        url_params
      end

      def add_current_page_param(url_params, page)
        unless param_name.index(/[^\w-]/)
          url_params[param_name.to_sym] = page
        else
          page_param = parse_query_parameters("#{param_name}=#{page}")
          symbolized_update(url_params, page_param)
        end
      end

      private

      def parse_query_parameters(params)
        Rack::Utils.parse_nested_query(params)
      end

      def link(text, target, attributes = {})
        if target.is_a? Fixnum
          attributes[:rel] = rel_value(target)
          target = url(target)
        end
        attributes[:href] = ksp(target)
        tag(:a, text, attributes)
      end

      # copied from ApplicationController
      def ksp(resourceUrl)
        path_string = if resourceUrl.kind_of? String
          resourceUrl
        else
          url_for(resourceUrl)
        end
        path_string.sub!(/^https?:\/\/[^\/]*/, '')
        "#!_" + path_string
      end

    end
  end
end