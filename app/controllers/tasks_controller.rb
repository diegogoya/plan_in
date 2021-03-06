  class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @event = Event.find_by(id: params[:event_id])
    @task = Task.find_by(id: params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.find_by(name: params[:type], event_id: params[:event_id])
    if !@task 
      @task = Task.create(name: params[:type], event_id: params[:event_id])
    end
    if params[:type] == "transporte"
      @choice = Choice.new
      @event = Event.find_by(id: params[:event_id])
      render partial: "/choices/form_transport"
    end
    if params[:type] == "alojamiento"
      @choice = Choice.new
      @event = Event.find_by(id: params[:event_id])
      render partial: "/choices/form_accommodation"
    end
    if params[:type] == "extras"
      @choice = Choice.new
      @event = Event.find_by(id: params[:event_id])
      render partial: "/choices/form_extras"
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @event = Event.find_by(id: params[:event_id])
    @task = @event.tasks.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to [@event,@task] }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :event_id)
    end
end
