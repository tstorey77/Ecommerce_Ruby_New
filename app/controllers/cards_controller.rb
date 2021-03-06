# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :set_card, only: %i[show edit update destroy]
  before_action :initialize_session
  before_action :load_cart

  # GET /cards
  # GET /cards.json
  def index
    # @cards = Card.all
    @cards = Card.order(:name).page(params[:page])
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = 1
    item = { id => quantity }
    session[:cart].merge!(item) unless session[:cart].include?(item)

    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)

    redirect_to root_path
  end

  def search
    if params[:SearchWCat] == 'true'
      @card = Card.where('name LIKE ? AND card_type LIKE ?', "%#{params[:keyword]}%", "#{params[:Category]}%")
    else
      @card = Card.where('name LIKE ?', "%#{params[:keyword]}%")
    end
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def load_cart
    items = session[:cart]
    @cart = Card.find(items.keys)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:name, :card_type, :description, :attack, :defence, :price)
  end
end
