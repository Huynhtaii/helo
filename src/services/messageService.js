import db from "../models";
import { Op } from "sequelize"; // Bổ sung import Op từ Sequelize
import dotenv from "dotenv";
dotenv.config();
const getChatHistory = async (userId) => {
    try {
        const messages = await db.Message.findAll({
            where: {
                [Op.or]: [{ sender_id: userId }, { receiver_id: userId }],
            },
            include: [
                {
                    model: db.User,
                    as: "sender",
                    attributes: ["user_id", "name"],
                },
                {
                    model: db.User,
                    as: "receiver",
                    attributes: ["user_id", "name"],
                },
            ],
            order: [["created_at", "ASC"]], // Sắp xếp theo thời gian tăng dần
        });

        return {
            EM: "Get chat history successfully",
            EC: "0",
            DT: messages,
        };
    } catch (error) {
        console.log("Error in getChatHistory:", error);
        return {
            EM: "Get chat history failed",
            EC: "-1",
            DT: [],
        };
    }
};
const sendMessage = async (sender_id, receiver_id, content, created_at) => {
    try {
        const message = await db.Message.create({
            sender_id: sender_id,
            receiver_id: receiver_id,
            content: content,
            created_at: created_at,
        });
        return {
            EM: "Message sent successfully",
            EC: "0",
            DT: message,
        };
    } catch (error) {
        console.log("Error in sendMessage:", error);
        return {
            EM: "Message sending failed",
            EC: "-1",
            DT: [],
        };
    }
};
const getAllChat = async () => {
    try {
        const messages = await db.Message.findAll({
            include: [
                {
                    model: db.User,
                    as: "sender",
                    attributes: ["user_id", "name", "email"], // Lấy thông tin người gửi
                },
                {
                    model: db.User,
                    as: "receiver",
                    attributes: ["user_id", "name", "email"], // Lấy thông tin người nhận
                },
            ],
            order: [["created_at", "DESC"]], // Sắp xếp theo thời gian mới nhất
        });

        return {
            EM: "Lấy danh sách tin nhắn thành công",
            EC: 0,
            DT: messages,
        };
    } catch (error) {
        console.log("Error in getAllChat:", error);
        return {
            EM: "Lỗi server",
            EC: -1,
            DT: [],
        };
    }
};
const getUnreadCounts = async () => {
    try {
        // Đếm số tin nhắn chưa đọc (status = 'Sent' hoặc 'Delivered')
        const unreadCounts = await db.Message.count({
            where: {
                status: {
                    [Op.in]: ['Sent', 'Delivered']
                }
            },
            group: ['receiver_id'],
            include: [
                {
                    model: db.User,
                    as: 'receiver',
                    attributes: ['user_id', 'name', 'email']
                }
            ]
        });

        return {
            EM: "Lấy số tin nhắn chưa đọc thành công",
            EC: 0,
            DT: unreadCounts
        };
    } catch (error) {
        console.log("Error in getUnreadCounts:", error);
        return {
            EM: "Lỗi server",
            EC: -1,
            DT: []
        };
    }
};
const markAsRead = async (userId) => {
    try {
        // Cập nhật tất cả tin nhắn chưa đọc của user thành 'Seen'
        const result = await db.Message.update(
            { status: 'Seen' },
            {
                where: {
                    receiver_id: userId,
                    status: {
                        [Op.in]: ['Sent', 'Delivered']
                    }
                }
            }
        );

        return {
            EM: "Đánh dấu tin nhắn đã đọc thành công",
            EC: 0,
            DT: result
        };
    } catch (error) {
        console.log("Error in markAsRead:", error);
        return {
            EM: "Lỗi server",
            EC: -1,
            DT: []
        };
    }
};

export default {
    getChatHistory,
    sendMessage,
    getAllChat,
    getUnreadCounts,
    markAsRead
};
