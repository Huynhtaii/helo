'use strict';
module.exports = {
   up: async (queryInterface, Sequelize) => {
      await queryInterface.createTable('chat_messages', {
         id: {
            allowNull: false,
            autoIncrement: true,
            primaryKey: true,
            type: Sequelize.INTEGER,
         },
         user_id: {
            type: Sequelize.INTEGER,
            allowNull: true,
            references: {
               model: 'users',
               key: 'user_id',
            },
         },
         session_id: {
            type: Sequelize.STRING,
            allowNull: true,
         },
         role: {
            type: Sequelize.ENUM('user', 'assistant'),
            allowNull: false,
         },
         content: {
            type: Sequelize.TEXT,
            allowNull: false,
         },
         created_at: {
            allowNull: false,
            type: Sequelize.DATE,
            defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
         },
      });
   },
   down: async (queryInterface, Sequelize) => {
      await queryInterface.dropTable('chat_messages');
   },
};
