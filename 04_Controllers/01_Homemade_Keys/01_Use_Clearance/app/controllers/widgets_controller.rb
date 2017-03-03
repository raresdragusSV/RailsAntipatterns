class WidgetsController < ApplicationController
  # clearance method
  before filter :authenticate

  def index
    @widgets = Widget.all
  end
end
