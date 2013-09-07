class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    #@document = Document.new(document_params)
    session = RubyBox::Session.new({
      client_id: AUTH['box']['client_id'],
      client_secret: AUTH['box']['client_secret'],
      access_token: 'DXQZEJaKmN9rJASZBdFdk2UxdJcWskBI'
    })
    client = RubyBox::Client.new(session)

    binding.pry
    # respond_to do |format|
    #   if @document.save
    #     format.html { redirect_to @document, notice: 'Document was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @document }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @document.errors, status: :unprocessable_entity }
    #   end
    # end
    redirect_to root_url
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params[:document]
    end
end
