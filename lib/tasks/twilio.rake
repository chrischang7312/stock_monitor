namespace :twilio do
  desc "Send text messages to everyone"
  task :send => :environment do
    account_sid = 'AC33410b9d5e371d72a129e4e3c1644050'
    auth_token = '2afc284331b45c3b946fcd08997252ae'

    @client = Twilio::REST::Client.new account_sid, auth_token

    Twilio.configure do |config|
      config.account_sid = account_sid
      config.auth_token = auth_token
    end

    @client = Twilio::REST::Client.new  


    Stock.find_each do |stock|
      user = stock.user
      if stock.last_updated < 1.hour.ago
        data = StockQuote::Stock.quote(stock.symbol)
        percent_change = data.percent_change
        avg_daily_vol = data.average_daily_volume
        dividend_share = data.dividend_share
        dividend_yield = data.dividend_yield 
        pe_ratio = data.pe_ratio

        @client.messages.create(
          from: '+15204644813',
          to: "+1#{user.phone_number}",
          body: "#{stock.symbol}-Percent Change: #{percent_change}-Avg Daily Vol #{avg_daily_vol}-Dividend Share #{dividend_share}-Dividend_Yield #{dividend_yield}-PE Ratio #{pe_ratio}"
        )
        stock.last_updated = Time.now
        stock.save
      end
    end
  end
end