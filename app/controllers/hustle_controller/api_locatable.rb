module HustleController
  module ApiLocatable
    extend ActiveSupport::Concern

    protected

    def resource_location
      format(
        '/%<controller_path>s/%<id>d',
        controller_path: controller_path,
        id: instance_variable_get(resource).id
      )
    end
  end
end
