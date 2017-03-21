class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    registration = Registration.find_by(event_id: params[:id], user_id: current_user.id)
    @event = Event.find_by(id: params[:id])
    if registration.role == "admin"
       render :show
    else
       render :show_guest
    end

  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      registration = Registration.new(event_id: @event.id, user_id: current_user.id, role: 1)
      
      respond_to do |format|
        if registration.save
          format.html { redirect_to @event}
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def send_email
    event = Event.find_by(id: params[:id])
    emails = params[:message]
    emails_array = emails.split "\r\n"
    emails_array.each do |email|
      user = User.find_by(email: email)
      if !user
        user = User.create(email: email, password: '123456')
      end
        Registration.create(event_id: event.id, user_id: user.id)
        WelcomeMailer.event_email(user, event).deliver_now
    end
    redirect_to event_path(event)
  end

  def send_event_invitation (user, event)
    
  end

  def public_email

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description)
    end
end
