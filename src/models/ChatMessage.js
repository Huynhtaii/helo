'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
   class ChatMessage extends Model {
      static associate(models) {
         // Define association here
         ChatMessage.belongsTo(models.User, { foreignKey: 'user_id' });
      }
   }
   ChatMessage.init(
      {
         id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
         },
         user_id: {
            type: DataTypes.INTEGER,
            allowNull: true,
         },
         session_id: {
            type: DataTypes.STRING,
            allowNull: true,
         },
         role: {
            type: DataTypes.ENUM('user', 'assistant'),
            allowNull: false,
         },
         content: {
            type: DataTypes.TEXT,
            allowNull: false,
         },
         created_at: {
            type: DataTypes.DATE,
            defaultValue: DataTypes.NOW,
         },
      },
      {
         sequelize,
         modelName: 'ChatMessage',
         tableName: 'chat_messages',
         timestamps: false,
      },
   );
   return ChatMessage;
};
