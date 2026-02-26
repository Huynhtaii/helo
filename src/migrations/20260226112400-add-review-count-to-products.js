'use strict';
module.exports = {
   up: async (queryInterface, Sequelize) => {
      await queryInterface.addColumn('products', 'review_count', {
         type: Sequelize.INTEGER,
         allowNull: false,
         defaultValue: 0,
      });
   },
   down: async (queryInterface) => {
      await queryInterface.removeColumn('products', 'review_count');
   },
};
