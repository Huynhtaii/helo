import feedbackService from '../services/feedbackService';

const createFeedback = async (req, res) => {
   try {
      const data = req.body;
      const result = await feedbackService.createFeedback(data);
      return res.status(200).json({
         EM: result.EM,
         EC: result.EC,
         DT: result.DT,
      });
   } catch (error) {
      return res.status(500).json({
         EM: 'Lỗi từ server',
         EC: '-1',
         DT: '',
      });
   }
};

export default { createFeedback };
