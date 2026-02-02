import messageService from "../services/messageService";

const getChatHistory = async (req, res) => {
    try {
        let { userId } = req.params;
        userId = parseInt(userId);
        console.log(">>>>>>>>>>>>>.check userId", userId);
        if (isNaN(userId)) {
            return res.status(400).json({
                EM: "Invalid user ID",
                EC: "-2",
                DT: [],
            });
        }

        const data = await messageService.getChatHistory(userId);
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT,
        });
    } catch (error) {
        console.log("Error in getChatHistory:", error);
        return res.status(500).json({
            EM: "Server error",
            EC: "-1",
            DT: [],
        });
    }
};
const sendMessage = async (req, res) => {
    try {
        const { sender_id, receiver_id, content, created_at } = req.body;
        console.log(">>>>>>>>>>>>>.check senderId", sender_id);
        console.log(">>>>>>>>>>>>>.check receiverId", receiver_id);
        console.log(">>>>>>>>>>>>>.check content", content);
        console.log(">>>>>>>>>>>>>.check createdAt", created_at);
        const data = await messageService.sendMessage(sender_id, receiver_id, content, created_at);
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT,
        });
    } catch (error) {
        console.log("Error in sendMessage:", error);
        return res.status(500).json({
            EM: "Server error",
            EC: "-1",
            DT: [],
        });
    }
};
const getAllChat = async (req, res) => {
    try {
        const data = await messageService.getAllChat();
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT,
        });
    } catch (error) {
        console.log("Error in getAllChat:", error);
        return res.status(500).json({
            EM: "Server error",
            EC: "-1",
            DT: [],
        });
    }
};
const getUnreadCounts = async (req, res) => {
    try {
        const data = await messageService.getUnreadCounts();
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        });
    } catch (error) {
        console.log("Error in getUnreadCounts controller:", error);
        return res.status(500).json({
            EM: "Lỗi server",
            EC: -1,
            DT: []
        });
    }
};
const markAsRead = async (req, res) => {
    try {
        const { userId } = req.params;

        if (!userId) {
            return res.status(400).json({
                EM: "Missing userId parameter",
                EC: -1,
                DT: []
            });
        }

        const data = await messageService.markAsRead(userId);
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        });
    } catch (error) {
        console.log("Error in markAsRead controller:", error);
        return res.status(500).json({
            EM: "Lỗi server",
            EC: -1,
            DT: []
        });
    }
};
export default {
    getChatHistory,
    sendMessage,
    getAllChat,
    getUnreadCounts,
    markAsRead
};
