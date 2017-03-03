class OrdersController < ApplicationController
  def new
    session[:order] = Order.new
  end

  def billing
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: 'new'
    end
  end

  def shipping
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: :billing
    end
  end

  def payment
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: :shipping
    end
  end

  def create
    if session[:order].save
      flash[:success] = 'Order placed successfully'
      redirect_to order_path(session[:order])
    else
      render action: :payment
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end

# refactoring

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def billing
    @order = Order.new(params[:order])
    if !@order.valid?
      render action: :new
    end
  end

  def shipping
    @order = Order.new(params[:order])
    if !@order.valid?
      render action: :billing
    end
  end

  def payment
    @order = Order.new(params[:order])
    if !@order.valid?
      render action: :shipping
    end
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:success] = 'Order placed successfully'
      redirect_to order_path(@order)
    else
      render action: :payment
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
