# change the behavior provided by Clearance
class SessionsController < Clearance::SessionsCoontroller
  def new
    # your special new behavior
  end

  # override actions that redirect in Clearance controllers
  def url_after_create
    # your special path
  end
end
