class ProfilesController < ApplicationController
  skip_before_action :ensure_login, only: [:get_api, :update_api]
  skip_before_action :verify_authenticity_token, only: [:update_api]
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :get_api, :update_api]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # get /portfolio_api/user_info/:id
  def get_api
    head :not_found and return unless @profile
    data_response = {
        profile_id: @profile.id,
        name: @profile.name,
        description: @profile.description,
        twitter_account: @profile.twitter_account,
        image: rails_blob_url(@profile.image)
    }

    render json: data_response, status: :ok
  end

  # post /portfolio_api/modify_user_info/
  def update_api
    if @profile.update(api_params)
      response_code = :ok
    else
      response_code = :bad_request
    end
    head response_code
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @profile = nil
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:name, :description, :twitter_account, :image)
  end

  def api_params
    params.permit(:name, :description, :twitter_account)
  end
end
