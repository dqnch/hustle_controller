# sourced from http://t.y13i.com/post/83102660768/ruby-on-rails

module HustleController
  module Restful
    extend ActiveSupport::Concern
    include Inflectable

    included do
      before_action :set_model
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
    end

    # GET /resources
    # GET /resources.json
    def index
      instance_variable_set(resource(:tableize), @model.all)
    end

    # GET /resources/1
    # GET /resources/1.json
    def show; end

    # GET /resources/new
    def new
      instance_variable_set(resource, @model.new)
    end

    # GET /resources/1/edit
    def edit; end

    # POST /resources
    # POST /resources.json
    def create
      instance_variable_set(resource, @model.new(resource_params))

      yield if block_given?

      respond_to do |format|
        if instance_variable_get(resource).save
          format.html { redirect_to action: :index, notice: 'Resource was successfully created.' }
          format.json { render :show, status: :created, location: resource_location }
          after_create
        else
          format.html { render :new }
          format.json do
            render json: instance_variable_get(resource).errors.as_json(full_messages: true),
                   status: :unprocessable_entity
          end
        end
      end
    end

    # PATCH/PUT /resources/1
    # PATCH/PUT /resources/1.json
    def update
      respond_to do |format|
        if instance_variable_get(resource).update(resource_params)
          format.html { redirect_to action: :index, notice: 'Resource was successfully updated.' }
          format.json { render :show, status: :ok, location: resource_location }
          after_update
        else
          format.html { render :edit }
          format.json do
            render json: instance_variable_get(resource).errors.as_json(full_messages: true),
                   status: :unprocessable_entity
          end
        end
      end
    end

    # DELETE /resources/1
    # DELETE /resources/1.json
    def destroy
      after_destroy if instance_variable_get(resource).destroy

      respond_to do |format|
        format.html { redirect_to action: :index, notice: 'Resource was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def after_create; end

    def after_update; end

    def after_destroy; end
  end
end
