# frozen_string_literal: true

# Basic API controller actions: index, show, create, update, destroy
module BasicApiActions
  extend ActiveSupport::Concern

  def index
    render json: collection, adapter: :json
  end

  def show
    render json: resource
  end

  def create
    resource = resource_class.new(resource_params)
  
    if resource.save
      render json: resource, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if resource.update(resource_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
  end

  private

  def collection
    resource_class.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def resource
    resource_class.find(params[:id])
  end
end
