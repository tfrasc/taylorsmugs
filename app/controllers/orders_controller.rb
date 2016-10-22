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
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    # # WePay Ruby SDK - http://git.io/a_c2uQ
    # require 'wepay'
    #
    # # application settings
    # account_id = 123456789  # your app's account_id
    # client_id = 123456789
    # client_secret = '1a3b5c7d9'
    # access_token = 'STAGE_8a19aff55b85a436dad5cd1386db1999437facb5914b494f4da5f206a56a5d20' # your app's access_token
    #
    # # set _use_stage to false for live environments
    # wepay = WePay::Client.new(client_id, client_secret, _use_stage = true)
    #
    # # create the checkout
    # response = wepay.call('/checkout/create', access_token, {
    #   :account_id         => account_id,
    #   :amount             => '24.95',
    #   :short_description  => 'Services rendered by freelancer',
    #   :type               => 'service',
    #   :currency           => 'USD'
    # })
    #
    # @checkout_id = response['checkout_id']
    # @checkout_uri = response['checkout_uri']
    #
    # # display the response
    # p response
    # p @checkout_id
    # p @checkout_uri
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
      params.require(:order).permit(:name, :phone, :email, :details, :product, :price, :paid, :method, :photo)
    end
end
