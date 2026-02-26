'use strict';
module.exports = {
   up: async (queryInterface, Sequelize) => {
      // Bước 1: Tìm tên foreign key hiện tại
      const [results] = await queryInterface.sequelize.query(`
         SELECT CONSTRAINT_NAME
         FROM information_schema.KEY_COLUMN_USAGE
         WHERE TABLE_SCHEMA = DATABASE()
           AND TABLE_NAME = 'feedbacks'
           AND COLUMN_NAME = 'order_id'
           AND REFERENCED_TABLE_NAME = 'orders';
      `);

      // Bước 2: Drop foreign key nếu tồn tại
      if (results && results.length > 0) {
         const fkName = results[0].CONSTRAINT_NAME;
         await queryInterface.sequelize.query(`ALTER TABLE feedbacks DROP FOREIGN KEY \`${fkName}\`;`);
      }

      // Bước 3: Thay đổi cột cho phép NULL
      await queryInterface.sequelize.query(`
         ALTER TABLE feedbacks
         MODIFY COLUMN order_id INT NULL;
      `);

      // Bước 4: Thêm lại foreign key với ON DELETE SET NULL
      await queryInterface.sequelize.query(`
         ALTER TABLE feedbacks
         ADD CONSTRAINT fk_feedbacks_order_id
         FOREIGN KEY (order_id) REFERENCES orders(order_id)
         ON UPDATE CASCADE ON DELETE SET NULL;
      `);
   },

   down: async (queryInterface, Sequelize) => {
      // Bước 1: Drop FK hiện tại
      await queryInterface.sequelize
         .query(
            `
         ALTER TABLE feedbacks DROP FOREIGN KEY fk_feedbacks_order_id;
      `,
         )
         .catch(() => {}); // bỏ qua nếu không tồn tại

      // Bước 2: Đổi lại cột về NOT NULL
      await queryInterface.sequelize.query(`
         ALTER TABLE feedbacks
         MODIFY COLUMN order_id INT NOT NULL;
      `);

      // Bước 3: Thêm lại FK gốc
      await queryInterface.sequelize.query(`
         ALTER TABLE feedbacks
         ADD CONSTRAINT fk_feedbacks_order_id
         FOREIGN KEY (order_id) REFERENCES orders(order_id)
         ON UPDATE CASCADE ON DELETE CASCADE;
      `);
   },
};
