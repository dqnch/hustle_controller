module HustleController
  module Inflectable
    extend ActiveSupport::Concern

    private

    def set_model
      @model = controller_name.classify.constantize
    rescue NameError # rubocop:disable Lint/HandleExceptions
    end

    def model_name
      @model.to_s
    end

    def resource(inflector = :underscore)
      :"@#{model_name.send(inflector)}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @model || set_model # Why?
      instance_variable_set(resource, @model.find(params[:id])) if @model
    end

    def resource_location
      instance_variable_get(resource)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(resource_name).permit(*permitted_params)
    end

    def permitted_params
      @model.permitted_attributes
    end

    def resource_name(inflector = :to_sym)
      model_name.underscore.send(inflector)
    end
  end
end
