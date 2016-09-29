class SpeakersController < ApplicationController

  # GET /speakers
  def index
    @speakers = Speaker.all
  end

  # GET /speakers/1
  def show
    @speaker = Speaker.find(params[:id])
  end

  # GET /speakers/new
  def new
    @speaker = Speaker.new
  end

  # GET /speakers/1/edit
  def edit
    @speaker = Speaker.find(params[:id])
  end

  # POST /speakers
  def create
    @speaker = Speaker.new(speaker_params)

    if @speaker.save
      redirect_to @speaker, notice: 'Speaker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /speakers/1
  def update
    @speaker = Speaker.find(params[:id])
    if @speaker.update(speaker_params)
      redirect_to @speaker, notice: 'Speaker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /speakers/1
  def destroy
    @speaker = Speaker.find(params[:id])
    @speaker.destroy
    redirect_to speakers_url, notice: 'Speaker was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def speaker_params
      params.require(:speaker).permit(:first, :last, :email)
    end
end
