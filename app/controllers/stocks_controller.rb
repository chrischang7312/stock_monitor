class StocksController < ApplicationController
	def new
		@stock = Stock.new
	end

	def create
		stock = params[:stock][:symbol]
		data = StockQuote::Stock.quote(stock)
		if data.ask.blank?
			flash[:notice] = "Symbol is Invalid"
      		flash[:color]= "invalid"
		else
			changein_percent = data.changein_percent.to_f 
			@stock = Stock.new(symbol: stock, last_updated: Time.now, user_id: session[:user_id])
			@stock.save
			redirect_to controller: 'sessions', action:"home"
		end
	end
end
