'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
   async up(queryInterface, Sequelize) {
      await queryInterface.addColumn('products', 'origin', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'target_audience', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'product_line', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'water_resistance', {
         type: Sequelize.STRING(50),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'movement_type', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'glass_material', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'strap_material', {
         type: Sequelize.STRING(100),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'case_size', {
         type: Sequelize.STRING(50),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'case_thickness', {
         type: Sequelize.STRING(50),
         allowNull: true,
      });
      await queryInterface.addColumn('products', 'utilities', {
         type: Sequelize.TEXT,
         allowNull: true,
      });
   },

   async down(queryInterface, Sequelize) {
      await queryInterface.removeColumn('products', 'origin');
      await queryInterface.removeColumn('products', 'target_audience');
      await queryInterface.removeColumn('products', 'product_line');
      await queryInterface.removeColumn('products', 'water_resistance');
      await queryInterface.removeColumn('products', 'movement_type');
      await queryInterface.removeColumn('products', 'glass_material');
      await queryInterface.removeColumn('products', 'strap_material');
      await queryInterface.removeColumn('products', 'case_size');
      await queryInterface.removeColumn('products', 'case_thickness');
      await queryInterface.removeColumn('products', 'utilities');
   },
};
