class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  def order_email(order)
    @order = order
    @user = User.find_by_email(@order.email)
    mail(to: @order.email, subject: "Your order details (##{@order.id})")
    

    
  end
end
