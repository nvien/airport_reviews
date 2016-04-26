class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_airport
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.airport_id = @airport.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to airport_path(@airport), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to airport_path(@airport), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to airport_path(@airport), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_airport
      @airport = Airport.find(params[:airport_id])
    end

    def check_user
      unless (@review.user == current_user) || (current_user.admin?)
        redirect_to root_path, alert: "This review cannot be changed or deleted because it belongs to someone else"
      end
    end

    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
