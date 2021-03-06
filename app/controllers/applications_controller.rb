require 'tropo-webapi-ruby'
require 'net/http'
require 'uri'

class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, :apply]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to edit_application_path(@application), notice: 'Application was successfully created.' }
        format.json { render action: 'show', status: :created, location: @application }
      else
        format.html { render action: 'new' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def apply
    @application.update_attributes(applied: true)
    token = '686b62647a714d79664c796a534b746f4b6e764358465570675a4a6c747556506f794f545a42774e616e7946'
    url = 'https://tropo.developergarden.com/api/sessions?action=create&token=' + token + '&phone=' + url_encode(request[:phone]) + '&msg=' + url_encode(request[:message])
    uri = URI.parse(url)
    Net::HTTP.get(uri)
    redirect_to '/application_overview'
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:immo_id, :user_id, :title, :picture_url, :price, :living_space, :rooms, :address, :email, :mobile, :landline, :applied, :immo_url)
    end
end
