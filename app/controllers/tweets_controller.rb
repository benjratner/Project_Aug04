class TweetsController < ApplicationController

def create
	@tweet = Tweet.new
end

def new
	@tweet = Tweet.new
end

end
