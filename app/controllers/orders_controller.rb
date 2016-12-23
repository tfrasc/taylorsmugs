class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :process_photo, only: [:create, :update]

  skip_before_action :verify_authenticity_token


  def process_photo
    if params && params[:photo].present?
      json_data = JSON.parse(params[:photo][:_values])
      data = StringIO.new(Base64.decode64(json_data['data'].split(',')[1]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = json_data['name']
      # data.content_type = "image/jpeg" # json_data['type'] # params[:header_img][:_values]['type']
      params[:photo] = data
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    if params[:sort_by] == 'unpaid'
      @orders = Order.all.order(paid: :asc, id: :desc)
    elsif params[:sort_by] == 'undelivered'
      @orders = Order.all.order(delivered: :asc, id: :desc)
    else
      @orders = Order.all.order(id: :desc)
    end
  end

  def pay_online
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here: https://dashboard.stripe.com/account/apikeys
    Stripe.api_key = ENV['STRIPE_SECRET']

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a charge: this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 2088, # Amount in cents
        :currency => "usd",
        :source => token,
        :description => "Taylor's Mugs Checkout"
        )
      rescue Stripe::CardError => e
        # The card has been declined
        redirect_to :back
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Order was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :phone, :email, :details, :product, :price, :paid, :method, :review, :photo, :delivered, :paid)
    end
end
