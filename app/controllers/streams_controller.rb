class StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :edit, :update, :destroy]

  require 'twitter'

  

  # GET /streams
  # GET /streams.json
  def index
    @streams = Stream.all
  end

  # GET /streams/1
  # GET /streams/1.json
  def show

    puts keyword_stream
    puts tweet_text
    puts tweet_url
    puts user_name
    puts user_image
    # if defined? keyword_stream
    #   @keyword_stream = keyword_stream
    # else
    #   @keyword_stream = "nothing to see here"
    # end

  end

  # GET /streams/new
  def new
    @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
  end

  # POST /streams
  # POST /streams.json
  def create
    @stream = Stream.new(stream_params)
    if @stream.save

    @keyword_stream = []
    @tweet_text = []
    @tweet_url =[]
    @user_name = []
    @user_image = []

  client = Twitter::REST::Client.new do |config|
    config.consumer_key         = "N8YJIcK8WWbK3MTkzo9UqSqjq"
    config.consumer_secret      = "nXlF2icaP6VObrHtyYFlxwnPQLrqFCdkP3y0BN9WBeku38ZBCz"
    config.access_token         = "1431408439-ZZzAF2m4UTUl0xKPd42uWr5OWHJ59I003dr7ifa"
    config.access_token_secret  = "71QshtxNvCJHhxnxq9pnxgiBh7ynvMgLBrSJ46Ve6DDjI"
  end

    client.search("#{stream_params[:keyword]}", :result_type => "recent").take(10).each do |tweet|
      @tweet = Tweet.new
      # @tweet.keyword_stream << tweet.text
      @tweet.text = tweet.text.to_s
      @tweet.url = tweet.url.to_s
      @tweet.screen_name = tweet.user.screen_name.to_s
      @tweet.img_url = tweet.user.profile_image_url.to_s
      @tweet.stream_id = @stream.id
      @tweet.save
      logger.info tweet.user.methods - Object.methods
    end

    @tweets = Tweet.where("stream_id=?",@stream.id)
    puts @keyword_stream
    puts "success!"

    # respond_to do |format|
    #   if @stream.save
    #     format.html { redirect_to @stream, notice: 'Stream was successfully created.', keyword_stream: "bananas" }
    #     format.json { render :show, status: :created, location: @stream }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @stream.errors, status: :unprocessable_entity }
    #   end
    # end
  end
  end

  # PATCH/PUT /streams/1
  # PATCH/PUT /streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        format.html { redirect_to @stream, notice: 'Stream was successfully updated.' }
        format.json { render :show, status: :ok, location: @stream }
      else
        format.html { render :edit }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.json
  def destroy
    @stream.destroy
    respond_to do |format|
      format.html { redirect_to streams_url, notice: 'Stream was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stream
      @stream = Stream.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stream_params
      params.require(:stream).permit(:keyword, :user_id)
    end
end
