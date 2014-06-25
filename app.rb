require 'sinatra'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  	erb :index
end

post '/charge' do
  	# Amount in cents
  	@amount = 99

  	customer = Stripe::Customer.create(
    	:email => params[:stripeEmail],
    	:card  => params[:stripeToken]
 	)

  	charge = Stripe::Charge.create(
    	:amount      => @amount,
    	:description => 'HIREMEv2.0 Charge',
    	:currency    => 'usd',
    	:customer    => customer.id
  	)

  	erb :charge
end

error Stripe::CardError do
  	env['sinatra.error'].message
end