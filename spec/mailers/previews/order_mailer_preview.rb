# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order_email
    OrderMailer.order_email(Order.last)
  end
end
