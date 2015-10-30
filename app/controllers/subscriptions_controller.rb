class SubscriptionsController < ApplicationController

  def new
    @user = User.find params[:user_id]
    @subscription = @user.build_subscription
  end

  def create
    @user = User.find params[:user_id]
    @subscription = @user.build_subscription subscription_params

    begin
      raise "Please, check subscription errors" unless @subscription.valid?
      stripe_customer = Stripe::Customer.create( source: params["stripeToken"], plan: "01", email: params["stripeEmail"] )
      @user.update_attributes(stripe_id: stripe_customer.id)
      @subscription.save
      redirect_to @user, notice: 'Registration was successfully created.'
    rescue => e
      flash[:error] = e.message
      render :new
    end
  end

  def show
  end


  def subscription_params
    params.require(:subscription).permit(:level)
  end

end
