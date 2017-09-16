class Tasks::AllocationsController < ApplicationController

  def new
    @allocation = Allocation.new
    @task = Task.find(params[:task_id])
    @team = @task.team
  end

  def create
    @task = Task.find(params[:task_id])
    @team = @task.team
    @allocation = @task.allocations.build(allocation_params)
    @allocation.update_attributes(sender_id: current_user.id, team_id: @team.id)
    if @allocation.save
      if @allocation.recipient != nil
        @allocation.recipient.received_allocations << @allocation
      end
    end
    redirect_to teams_path
  end

  def destroy
    @allocation = Allocation.find(params[:id])
    if @allocation.destroy
      redirect_to inbox_path
    end
  end

  private

    def allocation_params
      params.require(:allocation).permit(:recipient_id)
    end
end
