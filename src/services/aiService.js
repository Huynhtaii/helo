import axios from 'axios';
import db from '../models/index';

const consultAI = async (userMessage, userId, sessionId) => {
   try {
      // 0. Save user message to DB
      await db.ChatMessage.create({
         user_id: userId || null,
         session_id: sessionId || null,
         role: 'user',
         content: userMessage,
         created_at: new Date(),
      });

      // 1. Fetch products for context (including ID for linking)
      const products = await db.Product.findAll({
         attributes: ['product_id', 'name', 'description', 'price', 'discount_price', 'origin', 'target_audience'],
         include: [
            {
               model: db.Category,
               attributes: ['name'],
               through: { attributes: [] },
            },
         ],
      });

      const productContext = products
         .map((p) => {
            const categories = p.Categories.map((c) => c.name).join(', ');
            return `ID: ${p.product_id}, Tên: ${p.name}, Giá: ${p.discount_price || p.price}, Mô tả: ${p.description}, Xuất xứ: ${p.origin}, Đối tượng: ${p.target_audience}, Danh mục: ${categories}`;
         })
         .join('\n');

      // 2. Initialize Groq via Axios
      const apiKey = process.env.GROQ_API_KEY;
      const apiUrl = process.env.GROQ_API_URL || 'https://api.groq.com/openai/v1/chat/completions';

      const prompt = `
        Bạn là một chuyên gia tư vấn đồng hồ chuyên nghiệp của cửa hàng WatchStore. 
        Dưới đây là danh sách các sản phẩm đang có trong shop:
        ${productContext}

        NHIỆM VỤ QUAN TRỌNG:
        1. Hãy dựa vào danh sách trên để tư vấn cho khách hàng.
        2. Khi giới thiệu sản phẩm, BẮT BUỘC phải kèm theo tên và link xem chi tiết.
        3. Định dạng hiển thị sản phẩm như sau:
           **Tên sản phẩm**
           Link: [Xem chi tiết tại đây](/product/ID_Sản_Phẩm)
        4. Nếu khách hàng hỏi về sản phẩm không có, hãy gợi ý các mẫu tương tự có trong danh sách.
        5. Luôn trả lời bằng tiếng Việt, thân thiện và chuyên nghiệp.

        Khách hàng hỏi: ${userMessage}
        `;

      const response = await axios.post(
         apiUrl,
         {
            model: 'llama-3.3-70b-versatile',
            messages: [
               {
                  role: 'system',
                  content: 'Bạn là chuyên gia tư vấn đồng hồ của WatchStore. Luôn trả lời bằng tiếng Việt.',
               },
               {
                  role: 'user',
                  content: prompt,
               },
            ],
            temperature: 0.7,
            max_tokens: 1024,
         },
         {
            headers: {
               Authorization: `Bearer ${apiKey}`,
               'Content-Type': 'application/json',
            },
         },
      );

      const text = response.data.choices[0].message.content;

      // 3. Save AI response to DB
      await db.ChatMessage.create({
         user_id: userId || null,
         session_id: sessionId || null,
         role: 'assistant',
         content: text,
         created_at: new Date(),
      });

      return {
         EM: 'AI response generated via Groq',
         EC: '0',
         DT: text,
      };
   } catch (error) {
      console.error('Groq AI Service Error:', error.response?.data || error.message);
      return {
         EM: 'Error generating AI response',
         EC: '-1',
         DT: 'Xin lỗi, tôi đang gặp trục trặc kỹ thuật khi kết nối với AI. Vui lòng thử lại sau!',
      };
   }
};

const getChatHistory = async (userId, sessionId) => {
   try {
      const where = {};
      if (userId) {
         where.user_id = userId;
      } else if (sessionId) {
         where.session_id = sessionId;
      } else {
         return { EM: 'No identifier provided', EC: '1', DT: [] };
      }

      const messages = await db.ChatMessage.findAll({
         where,
         order: [['created_at', 'ASC']],
         limit: 50,
      });

      return {
         EM: 'Get chat history successfully',
         EC: '0',
         DT: messages,
      };
   } catch (error) {
      console.error('Get chat history error:', error);
      return { EM: 'Error getting chat history', EC: '-1', DT: [] };
   }
};

export default {
   consultAI,
   getChatHistory,
};
