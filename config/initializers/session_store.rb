# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tolmach_session',
  :secret      => 'e2a9a5070780169b5e6287083de6aee61242650226ac967b24fa6afbc9dc98696ccec0c39fb0fec5be914623290a42ce9aac83e21de53d81a750101a4d967fd0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
