'use strict';
module.exports = {
   up: async (queryInterface, Sequelize) => {
      await queryInterface.createTable('brands', {
         brand_id: {
            allowNull: false,
            autoIncrement: true,
            primaryKey: true,
            type: Sequelize.INTEGER,
         },
         name: {
            type: Sequelize.STRING(100),
            allowNull: false,
         },
         description: {
            type: Sequelize.TEXT,
            allowNull: true,
         },
         logo_url: {
            type: Sequelize.STRING(500),
            allowNull: true,
         },
         country: {
            type: Sequelize.STRING(100),
            allowNull: true,
         },
         created_at: {
            allowNull: false,
            type: Sequelize.DATE,
            defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
         },
      });

      // Clear any orphaned brand_id values before adding the FK constraint
      await queryInterface.sequelize.query('UPDATE products SET brand_id = NULL WHERE brand_id IS NOT NULL');

      // Add foreign key constraint on products.brand_id -> brands.brand_id
      await queryInterface.addConstraint('products', {
         fields: ['brand_id'],
         type: 'foreign key',
         name: 'fk_products_brand',
         references: { table: 'brands', field: 'brand_id' },
         onDelete: 'SET NULL',
         onUpdate: 'CASCADE',
      });
   },

   down: async (queryInterface, Sequelize) => {
      await queryInterface.removeConstraint('products', 'fk_products_brand');
      await queryInterface.dropTable('brands');
   },
};
