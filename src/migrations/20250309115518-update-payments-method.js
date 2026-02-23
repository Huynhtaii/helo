module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.changeColumn('Payments', 'payment_method', {
      type: Sequelize.ENUM('Credit Card', 'PayPal', 'cod', 'qr_code', 'Bank Transfer'),
      allowNull: false,
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.changeColumn('Payments', 'payment_method', {
      type: Sequelize.ENUM('Credit Card', 'PayPal', 'COD', 'Bank Transfer'),
      allowNull: false,
    });
  }
};
