class V1::BaseController < ApplicationController
  before_action :set_collection, only: [:index]
  before_action :set_resource, only: [:show, :update, :destroy]
  
  def index
    render json: @collection, adapter: :json
  end

  def show
    render json: @resource
  end
  
  def create
    @resource = resource_class.new(resource_params)
  
    if @resource.save
      render json: @resource, status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @resource.destroy
  end
end
