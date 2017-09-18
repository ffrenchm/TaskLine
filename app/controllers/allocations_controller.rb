class AllocationsController < ApplicationController

  def accept_form
    @allocation = Allocation.find(params[:id])
    @task = @allocation.task
  end

  def accept
    @allocation = Allocation.find(params[:id])
    @task = @allocation.task
    if @task.update(allocation_params)
      @allocation.destroy
      redirect_to categories_path
    end
  end

  def destroy
    @allocation = Allocation.find(params[:id])
    if @allocation.destroy
      redirect_to request.referrer
    end
  end

  private

    def allocation_params
      params.require(:task).permit(:category_id)
    end
end
