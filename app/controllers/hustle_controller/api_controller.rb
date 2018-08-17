module HustleController
  class ApiController < ApplicationController
    include HustleController::Restful
    include HustleController::Searchable

    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, if: -> { respond_to? :authenticate_user! }

    private

    def resource_location
      format(
        '/%<controller_path>s/%<id>d',
        controller_path: controller_path,
        id: instance_variable_get(resource).id
      )
    end
  end
end
