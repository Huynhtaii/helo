import express from 'express';
import userController from '../controller/userController';
import productController from '../controller/productController';
import categoryController from '../controller/categoryController';
import orderController from '../controller/orderController';
import { upload } from '../middleware/uploadImage';
import roleCotroller from '../controller/roleController';
import loginRegisterController from '../controller/loginRegisterController';
import jwtAction from '../middleware/jwtAction';
import cartController from '../controller/cartController';
import messageController from '../controller/messageController';
import paymentController from '../controller/paymentController';
const router = express.Router();

const initAPIRoutes = (app) => {
   // PUBLIC ROUTES (không cần đăng nhập)
   router.get('/read-all/products', productController.getAllProducts);
   router.get('/recent-products', productController.getResentProducts);
   router.get('/product/:id', productController.getProductById);
   router.get('/read-all/categories', categoryController.getAllCategories);
   router.get('/product-search', productController.searchProduct);
   router.get('/read-product-by-categories/:name', productController.getProductByCategories);
   router.get('/read-product-by-categories-with-pagination', productController.getProductByCategoriesWithPaginate);
   router.get('/getChatHistory/:userId', messageController.getChatHistory);  // Lấy lịch sử chat
   router.post('/sendMessage', messageController.sendMessage);  // Gửi tin nhắn mới
   router.get('/getAllChat', messageController.getAllChat);  // Lấy tất cả chat của user chat vs admin
   // router.get('/getUnreadCounts', messageController.getUnreadCounts);  // Lấy số tin nhắn chưa đọc
   // router.post('/markAsRead/:userId', messageController.markAsRead);  // Đánh dấu tin nhắn đã đọc
   //API PAYMENT
   router.post('/update-payment', paymentController.updatePayment);

   // AUTH ROUTES
   router.post('/register/user', loginRegisterController.handleRegister);
   router.post('/login/user', loginRegisterController.handleLogin);
   router.post('/logout/user', loginRegisterController.handleLogout);

   // USER PROTECTED ROUTES (cần JWT)
   router.get('/read/account-user/:id', jwtAction.checkUserJWT, loginRegisterController.getInforAccount);
   router.put('/update/account-user/:id', jwtAction.checkUserJWT, loginRegisterController.updateInforAccount);
   router.get('/account', jwtAction.checkUserJWT, loginRegisterController.getAccount);

   // Cart Routes
   router.get('/read/cart/:user_id', jwtAction.checkUserJWT, cartController.getCartByUserId);
   router.post('/create/cart-item/:user_id', jwtAction.checkUserJWT, cartController.createCartItem);
   router.put('/update/quantity-cart-item/:id', jwtAction.checkUserJWT, cartController.updateQuantityCartItem);
   router.delete('/delete/cart-item/:id', jwtAction.checkUserJWT, cartController.deleteCartItem);

   // Order Routes
   router.post('/create/order', jwtAction.checkUserJWT, orderController.createOrder);

   // ADMIN ROUTES
   router.get('/read-all/users', jwtAction.checkUserJWT, userController.getAllUsers);
   router.post('/create/user', jwtAction.checkUserJWT, userController.createUser);
   router.put('/update/user/:id', jwtAction.checkUserJWT, userController.updateUser);
   router.delete('/delete/user/:id', jwtAction.checkUserJWT, userController.deleteUser);

   router.post('/create/product', jwtAction.checkUserJWT, upload.single('images'), productController.createProduct);
   router.put('/update/product/:id', jwtAction.checkUserJWT, productController.updateProduct);
   router.delete('/delete/product/:id', jwtAction.checkUserJWT, productController.deleteProduct);

   router.post('/create/category', jwtAction.checkUserJWT, categoryController.createCategory);
   router.put('/update/category/:id', jwtAction.checkUserJWT, categoryController.updateCategory);
   router.delete('/delete/category/:id', jwtAction.checkUserJWT, categoryController.deleteCategory);

   router.get('/read-all/orders', jwtAction.checkUserJWT, orderController.getAllOrders);
   router.put('/update/order-status/:id', jwtAction.checkUserJWT, orderController.updateOrderStatus);
   router.delete('/delete/order/:id', jwtAction.checkUserJWT, orderController.deleteOrder);

   router.get('/read-all/roles', jwtAction.checkUserJWT, roleCotroller.getAllRoles);


   return app.use('/api/v1/', router);
};

export default initAPIRoutes;
