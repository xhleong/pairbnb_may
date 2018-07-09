class ListingsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :check_update_rights, only: [:edit, :update]
  #only moderator can verify
  before_action :check_verification_rights, only: [:verify]
  #cancancan

  before_action :find_listing, only: [:show, :edit, :verify]

  def index
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      redirect_to root_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
  end

  def edit
    #only user || admin can edit & update
  end

  def verify
    if @listing.verified == true
      @listing.update(verified: false)
    else
      @listing.update(verified: true)
    end

    if @listing.save
      redirect_to listing_path(@listing)
    end
  end

  private
  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :country, :num_of_guests, :user_id, :amenities => [])
  end

  def check_update_rights
    @listing = Listing.find(params[:id])
    if current_user.id != @listing.user_id && !current_user.admin?
      redirect_to root_path
    end
  end

  def check_verification_rights
    if !current_user.moderator?
      flash[:error] = "You do not have access to this"
      redirect_to root_path
    end
  end
end

#customer, moderator, admin