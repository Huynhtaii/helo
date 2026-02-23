import db from '../models/index';
import emailService from '../services/emailService';
const updatePayment = async (data) => {
    let transaction;
    try {
        transaction = await db.sequelize.transaction();
        console.log('data >>>>>>>>>>>>>>>>>>>>', data);
        // 1. Tạo order mới
        const newOrder = await db.Order.create({
            user_id: data.id,
            order_date: new Date(),
            total_amount: data.totalAmount,
            status: 'Shipped',
        }, { transaction });

        // 2. Tạo order_items từ cartItems
        const orderItems = data.cartItem.map(item => ({
            order_id: newOrder.order_id,
            product_id: item.product_id,
            quantity: item.quantity,
            price: item.Product.discount_price || item.Product.price,
        }));

        await db.OrderItem.bulkCreate(orderItems, { transaction });

        // 3. Xóa cart_items
        const cartItemIds = data.cartItem.map(item => item.cart_item_id);
        await db.CartItem.destroy({
            where: {
                cart_item_id: cartItemIds
            }
        }, { transaction });

        // 4. Tạo payment record
        await db.Payment.create({
            order_id: newOrder.order_id,
            payment_date: new Date(),
            amount: data.totalAmount,
            payment_method: data.paymentMethod,
            status: 'success'
        }, { transaction });

        await transaction.commit();
        if (data.paymentMethod === 'cod') {
            await emailService.sendOrderConfirmation(data.email, {
                nameProduct: data.cartItem.map(item => item.Product.name + ' - Số Lượng: ' + item.quantity),
                order_id: newOrder.order_id,
                order_date: newOrder.order_date,
                total_amount: data.totalAmount,
                status: 'Shipped'
            }, data.paymentMethod);
        }
        if (data.paymentMethod === 'qr_code') {
            await emailService.sendOrderConfirmation(data.email, {
                nameProduct: data.cartItem.map(item => item.Product.name + ' - Số Lượng: ' + item.quantity),
                order_id: newOrder.order_id,
                order_date: newOrder.order_date,
                total_amount: data.totalAmount,
                status: 'Shipped'
            }, data.paymentMethod);
        }

        return {
            EM: 'Payment processed successfully',
            EC: 0,
            DT: newOrder
        };

    } catch (error) {
        if (transaction) await transaction.rollback();
        console.error('Error in updatePayment:', error);
        return {
            EM: 'Error processing payment',
            EC: -1,
            DT: null
        };
    }
};
export default {
    updatePayment
};