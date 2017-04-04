class ChoicesController < ApplicationController
  before_action :set_choice, only: [:show, :edit, :update, :destroy]

  # GET /choices
  # GET /choices.json
  def index
    @choices = Choice.all
  end

  # GET /choices/1
  # GET /choices/1.json
  def show
    @task = Task.find_by(id: params[:task_id])
    @event = Event.find_by(id: params[:event_id])
    @choice = Choice.find_by(id: params[:id])
  end

  # GET /choices/new
  def new
    @choice = Choice.new
    @task = Task.find_by(id: params[:task_id])
    @event = Event.find_by(id: params[:event_id])
  end

  # GET /choices/1/edit
  def edit
  end

  # POST /choices
  # POST /choices.json
  def create
    @event = Event.find_by(id: params[:event_id])
    @task = Task.find_by(id: params[:task_id])
    @choice = @task.choices.new(choice_params)
    render partial: "/choices/option_card"
  end

  # PATCH/PUT /choices/1
  # PATCH/PUT /choices/1.json
  def update
    respond_to do |format|
      if @choice.update(choice_params)
        format.html { redirect_to @choice, notice: 'Choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @choice }
      else
        format.html { render :edit }
        format.json { render json: @choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /choices/1
  # DELETE /choices/1.json
  def destroy
    @choice.destroy
    respond_to do |format|
      format.html { redirect_to choices_url, notice: 'Choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_choice
      @choice = Choice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def choice_params
      params.require(:choice).permit(:name, :url, :selected, :price)
    end
end
