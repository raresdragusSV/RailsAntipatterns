class UserSession < Authlogic::Session::Base
  # specify configuration here
end

  # UserSession.create(
  #   login: 'bjohnson',
  #   password: 'mu password',
  #   remember_me: true
  # )

  # session = UserSession.new(
  #   login: 'bjohnson',
  #   password: 'mu password',
  #   remember_me: true
  #)

  # requires the authlogic-oid "add on" gem
  # UserSession.create(
  #   openid_identifier: 'identifier',
  #   remember_me: true
  #)

  # skip authentication and log the user in directly,
  # the true means "remember me"
  # UserSession.create(my_user_object, true)
