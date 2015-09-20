class TasksController < ApplicationController
  before_action :authenticate_admin
  before_action :all_tasks, only: [:index, :create, :update, :destroy, :toggle]
  before_action :set_task, only: [:edit, :update, :destroy, :toggle]
  respond_to :html, :js




  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
  end

  def update
    @task.update_attributes(task_params)
  end

  def destroy
    @task.destroy
  end


  def toggle
    @task.toggle!(:task_status)
  end



  def cancel

  end








  private

    def all_tasks
      @tasks = Task.where(:admin_id => current_admin.id).order(created_at: :asc)
    end


    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :notes, :due_date, :admin_id, :task_status)
    end




end
