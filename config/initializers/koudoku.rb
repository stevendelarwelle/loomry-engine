Koudoku.setup do |config|
  config.subscriptions_owned_by = :user
  config.stripe_publishable_key = 'pk_test_W9iRadINkPGpheGHpG2lLKan'
  config.stripe_secret_key = 'sk_test_lSLzyUkFbiAE4LjUOLXjt2Ga'
  
  Stripe.api_version = '2015-01-11' #Making sure the API version used is compatible.
  # config.prorate = false # Default is true, set to false to disable prorating subscriptions
  config.free_trial_length = 30

  # Specify layout you want to use for the subscription pages, default is application
  config.layout = 'application'
  
  # you can subscribe to additional webhooks here
  # we use stripe_event under the hood and you can subscribe using the 
  # stripe_event syntax on the config object: 
  # config.subscribe 'charge.failed', Koudoku::ChargeFailed
  
end
