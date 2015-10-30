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

      # Maybe change the plan name on stripe
      stripe_customer = Stripe::Customer.create( source: params["stripeToken"], plan: "01", email: params["stripeEmail"] )
      @user.update_attributes(stripe_id: stripe_customer.id)
      @subscription.save
      redirect_to @user, notice: 'Registration was successfully created.'
    rescue => e
      flash[:error] = e.message
      render :new
    end
  end

  def edit
    @user = User.find params[:user_id]
    @subscription = @user.subscription
  end

  def destroy
    @user = User.find params[:user_id]
    @subscription = @user.subscription

    # Stripe.api_key = ENV["STRIPE_TEST_SECRET_KEY"]

    customer = Stripe::Customer.retrieve(@user.stripe_id)
    stripe_subscription_id = customer.subscriptions.first.id
    customer.subscriptions.retrieve(stripe_subscription_id).delete(:at_period_end => true)

    @subscription.update_attributes(level: 0)
    redirect_to @user
  end


  def subscription_params
    params.require(:subscription).permit(:level)
  end

end
