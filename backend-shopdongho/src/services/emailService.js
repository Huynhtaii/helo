const nodemailer = require("nodemailer");
require('dotenv').config();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

const sendOrderConfirmation = async (toEmail, orderDetails, paymentMethod) => {
  try {
    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: toEmail,
      replyTo: process.env.EMAIL_USER,
      subject: "Xác nhận đơn hàng của bạn 🛒",
      html: `
            <html>
            <head>
              <style>
                body {
                  font-family: Arial, sans-serif;
                  background-color: #f4f4f4;
                  padding: 0;
                  margin: 0;
                }
                .email-container {
                  max-width: 600px;
                  margin: 30px auto;
                  background: #ffffff;
                  padding: 20px;
                  border-radius: 10px;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                  border-left: 5px solid #26BED6;
                }
                h2 {
                  text-align: center;
                  color: #26BED6;
                }
                p {
                  font-size: 16px;
                  color: #333;
                  line-height: 1.6;
                }
                .order-info {
                  background: #f8f8f8;
                  padding: 15px;
                  border-radius: 5px;
                  margin: 10px 0;
                }
                .order-info strong {
                  color: #26BED6;
                }
                .footer {
                  text-align: center;
                  margin-top: 20px;
                  padding-top: 10px;
                  border-top: 1px solid #ddd;
                  font-size: 14px;
                  color: #777;
                }
              </style>
            </head>
            <body>
              <div class="email-container">
                <h2>🎉 Cảm ơn bạn đã đặt hàng! 🎉</h2>
                <div class="order-info">
                  <p><strong>Mã đơn hàng:</strong> ${orderDetails.order_id}</p>
                  <p><strong>Tên sản phẩm:</strong> ${orderDetails.nameProduct}</p>
                  <p><strong>Ngày đặt hàng:</strong> ${new Date(orderDetails.order_date).toLocaleDateString('vi-VN')}</p>
                  <p><strong>Tổng tiền:</strong> 
                    ${new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(orderDetails.total_amount)}
                  </p>
                  <p><strong>Trạng thái:</strong> 
                    ${paymentMethod === "qr_code"
          ? "Đã Thanh Toán, đang được gửi đi"
          : "Chưa Thanh Toán (Thanh toán khi nhận hàng), đang được gửi đi"}
                  </p>
                </div>
                <p>📦 Đơn hàng của bạn sẽ được giao sớm nhất trong những ngày tới. Vui lòng kiểm tra email để cập nhật thông tin giao hàng.</p>
                <div class="footer">
                  🚀 <strong>Shop của chúng tôi</strong> | Hotline: 0123 456 789 | Email: support@shop.com
                </div>
              </div>
            </body>
            </html>
         `
    };

    await transporter.sendMail(mailOptions);
    console.log("✅ Email gửi thành công!");
  } catch (error) {
    console.error("❌ Gửi email thất bại:", error);
  }
};

const sendOrderStatusUpdate = async (toEmail, orderDetails, newStatus) => {
  try {
    let statusMessage = '';
    switch (newStatus) {
      case 'Pending':
        statusMessage = 'Đơn hàng của bạn đang được xử lý';
        break;
      case 'Shipped':
        statusMessage = 'Đơn hàng của bạn đang được vận chuyển';
        break;
      case 'Completed':
        statusMessage = 'Đơn hàng của bạn đã được giao thành công';
        break;
      case 'Canceled':
        statusMessage = 'Đơn hàng của bạn đã bị hủy';
        break;
      default:
        statusMessage = `Trạng thái đơn hàng: ${newStatus}`;
    }

    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: toEmail,
      replyTo: process.env.EMAIL_USER,
      subject: "Cập nhật trạng thái đơn hàng 🚚",
      html: `
            <html>
            <head>
              <style>
                body {
                  font-family: Arial, sans-serif;
                  background-color: #f4f4f4;
                  padding: 0;
                  margin: 0;
                }
                .email-container {
                  max-width: 600px;
                  margin: 30px auto;
                  background: #ffffff;
                  padding: 20px;
                  border-radius: 10px;
                  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                  border-left: 5px solid #26BED6;
                }
                h2 {
                  text-align: center;
                  color: #26BED6;
                }
                .status-update {
                  background: #e8f7ff;
                  padding: 15px;
                  border-radius: 5px;
                  margin: 20px 0;
                  text-align: center;
                  font-size: 18px;
                  color: #26BED6;
                }
                .order-info {
                  background: #f8f8f8;
                  padding: 15px;
                  border-radius: 5px;
                  margin: 10px 0;
                }
                .order-info strong {
                  color: #26BED6;
                }
                .footer {
                  text-align: center;
                  margin-top: 20px;
                  padding-top: 10px;
                  border-top: 1px solid #ddd;
                  font-size: 14px;
                  color: #777;
                }
              </style>
            </head>
            <body>
              <div class="email-container">
                <h2>Cập nhật đơn hàng</h2>
                <div class="status-update">
                  <strong>📦 ${statusMessage}</strong>
                </div>
                <div class="order-info">
                  <p><strong>Mã đơn hàng:</strong> ${orderDetails.order_id}</p>
                  <p><strong>Sản phẩm:</strong> ${orderDetails.nameProduct}</p>
                  <p><strong>Số lượng:</strong> ${orderDetails.quantity}</p>
                  <p><strong>Ngày đặt hàng:</strong> ${new Date(orderDetails.order_date).toLocaleDateString('vi-VN')}</p>
                  <p><strong>Tổng tiền:</strong> 
                    ${new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(orderDetails.total_amount)}
                  </p>
                  <h4 style="text-align: center;">🎉 Cảm ơn bạn đã tin tưởng và đồng hành cùng chúng tôi! 🎉</h4>
                </div>
                <div class="footer">
                  🚀 <strong>Shop của chúng tôi</strong> | Hotline: 0123 456 789 | Email: support@shop.com
                </div>
              </div>
            </body>
            </html>
            `
    };

    await transporter.sendMail(mailOptions);
    console.log("✅ Email cập nhật trạng thái đơn hàng đã được gửi!");
  } catch (error) {
    console.error("❌ Gửi email thất bại:", error);
  }
};

module.exports = {
  sendOrderConfirmation,
  sendOrderStatusUpdate
};
