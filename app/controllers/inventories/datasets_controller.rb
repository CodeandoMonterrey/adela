class Inventories::DatasetsController < ApplicationController
  include DatasetActions
  include InventoryActions

  before_action :authenticate_user!

  def confirm_destroy
    @dataset = Dataset.find(params[:id])
  end

  private

  def create_customization
    if @dataset.valid?
      redirect_to inventories_path
      return
    else
      render :new
      return
    end
  end

  def update_customization
    redirect_to inventories_path
    return
  end

  def destroy_customization
    redirect_to inventories_path
    return
  end

  def dataset_params
    params.require(:dataset).permit(
      :title,
      :description,
      :contact_position,
      :public_access,
      :accrual_periodicity,
      :publish_date,
      distributions_attributes: [:id, :title, :description, :publish_date, :media_type, :format, :_destroy]
    )
  end
end
