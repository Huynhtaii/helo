import aiService from '../services/aiService';

const consultAI = async (req, res) => {
   try {
      const { message, userId, sessionId } = req.body;
      if (!message) {
         return res.status(400).json({
            EM: 'Message is required',
            EC: '1',
            DT: '',
         });
      }
      const data = await aiService.consultAI(message, userId, sessionId);
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

const getChatHistory = async (req, res) => {
   try {
      const { userId, sessionId } = req.query;
      const data = await aiService.getChatHistory(userId, sessionId);
      return res.status(200).json(data);
   } catch (error) {
      return res.status(500).json({ EM: 'error from server', EC: '-1', DT: [] });
   }
};

export default {
   consultAI,
   getChatHistory,
};
