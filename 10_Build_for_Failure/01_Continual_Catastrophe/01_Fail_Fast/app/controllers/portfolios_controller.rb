class PortfoliosController < ApplicationController
  before_filter :ensure_can_close_all_portfolios, only: :close_all

  def close_all
    portfolio.close_all!
    redirect_to portfolios_url, notice: 'All of your portfolios have been
closed.'
  end

  private

  def ensure_can_close_all_portfolios
    if Portfolio.can_close_all?
      redirect_to portfolios_url, error: 'Some of your portfolios have photos!'
    end
  end
end
