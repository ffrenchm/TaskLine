class AllocationsController < ApplicationController
  def new
    @allocation = Allocation.new
  end
  def create
    @allocation = Allocation.new(allocation_params)
  end

  def destroy
  end

  private

    def allocation_params
      params.require(:allocation).permit(:email, :sender_id)
    end
end
