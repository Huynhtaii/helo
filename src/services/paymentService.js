import db from '../models/index';

const updatePayment = async (data) => {
    let transaction;
    try {
        transaction = await db.sequelize.transaction();

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
            price: item.Product.discount_price, // Giả sử price được lấy từ Product object
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
            payment_method: 'qr_code',
            status: 'success'
        }, { transaction });

        await transaction.commit();

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