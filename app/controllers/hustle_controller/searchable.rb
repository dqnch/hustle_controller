module HustleController
  module Searchable
    extend ActiveSupport::Concern
    include Inflectable

    included do
      before_action :set_model
      after_action :pagination_headers!, only: :index
    end

    ITEMS_PER_PAGE = 25

    def index
      instance_variable_set(
        resource(:tableize),
        search.page(params[:page]).per(limit)
      )
    end

    protected

    def search(model = nil)
      model ||= @model
      model.ransack(params[:q]).result
    end

    def limit
      params[:limit] || ITEMS_PER_PAGE
    end

    # Sourced from http://jaketrent.com/post/pagination-headers-with-kaminari/
    # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize
    def pagination_headers!(scope = nil)
      scope ||= instance_variable_get(resource(:tableize))
      request_params = request.query_parameters
      unless request_params.empty?
        url_without_params = request.original_url.slice(0..(request.original_url.index('?') - 1))
      end
      url_without_params ||= request.original_url

      page = {}
      page[:first] = 1 if scope.total_pages > 1 && !scope.first_page?
      page[:last] = scope.total_pages  if scope.total_pages > 1 && !scope.last_page?
      page[:next] = scope.current_page + 1 unless scope.last_page?
      page[:prev] = scope.current_page - 1 unless scope.first_page?

      pagination_links = []
      page.each do |k, v|
        new_request_hash = request_params.merge(page: v)
        pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>; rel=\"#{k}\""
      end
      headers['Link'] = pagination_links.join(', ')
      headers['X-Total-Count'] = scope.total_count.to_s
    end
    # rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize
  end
end
