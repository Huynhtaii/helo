import orderService from '../services/orderService';
const getAllOrders = async (req, res) => {
   try {
      const data = await orderService.getAllOrders();
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const getOrderById = async (req, res) => {
   try {
      const { id } = req.params;
      const data = await orderService.getOrderById(id);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const createOrder = async (req, res) => {
   try {
      console.log('req.body', req.body);

      const data = await orderService.createOrder(req.body);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const updateOrder = async (req, res) => {
   try {
      const { id } = req.params;
      const data = await orderService.updateOrder(id, req.body);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const updateOrderStatus = async (req, res) => {
   try {
      const { id } = req.params;
      const { status, payment_status } = req.body;

      const data = await orderService.updateOrderStatus(id, status, payment_status);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const deleteOrder = async (req, res) => {
   try {
      const { id } = req.params;
      const data = await orderService.deleteOrder(id);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
const cancelOrder = async (req, res) => {
   try {
      const { id } = req.params;
      // Kiểm tra đơn hàng có ở trạng thái Pending không
      const order = await orderService.getOrderById(id);
      if (order.EC !== '0' || !order.DT) {
         return res.status(404).json({
            EM: 'Không tìm thấy đơn hàng',
            EC: '-1',
            DT: '',
         });
      }

      if (order.DT.status !== 'Pending') {
         return res.status(400).json({
            EM: 'Chỉ có thể hủy đơn hàng đang chờ xử lý',
            EC: '-1',
            DT: '',
         });
      }
      const data = await orderService.updateOrderStatus(id, 'Canceled', null);
      return res.status(200).json({
         EM: data.EM,
         EC: data.EC,
         DT: data.DT,
      });
   } catch (error) {
      console.log(error);
      return res.status(500).json({
         EM: 'error from server',
         EC: '-1',
         DT: '',
      });
   }
};
export default {
   getAllOrders,
   getOrderById,
   createOrder,
   updateOrder,
   deleteOrder,
   updateOrderStatus,
   cancelOrder,
};
