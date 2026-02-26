import db from '../models';

const getAllBrands = async () => {
   try {
      const brands = await db.Brand.findAll({
         include: [{ model: db.Product, as: 'products', attributes: ['product_id', 'name'] }],
         order: [['name', 'ASC']],
      });
      return { EM: 'Get all brands success', EC: '0', DT: brands };
   } catch (error) {
      console.error('Get all brands error:', error);
      return { EM: 'Get all brands error', EC: '-1', DT: [] };
   }
};

const getBrandById = async (id) => {
   try {
      const brand = await db.Brand.findByPk(id, {
         include: [
            {
               model: db.Product,
               as: 'products',
               attributes: ['product_id', 'name', 'price', 'discount_price'],
               include: [{ model: db.ProductImage, attributes: ['url'] }],
            },
         ],
      });
      if (!brand) return { EM: 'Brand not found', EC: '1', DT: null };
      return { EM: 'Get brand success', EC: '0', DT: brand };
   } catch (error) {
      console.error('Get brand by id error:', error);
      return { EM: 'Get brand error', EC: '-1', DT: null };
   }
};

const createBrand = async (data) => {
   try {
      const brand = await db.Brand.create({
         name: data.name,
         description: data.description || null,
         logo_url: data.logo_url || null,
         country: data.country || null,
         created_at: new Date(),
      });
      return { EM: 'Brand created', EC: '0', DT: brand };
   } catch (error) {
      console.error('Create brand error:', error);
      return { EM: 'Create brand error', EC: '-1', DT: null };
   }
};

const updateBrand = async (id, data) => {
   try {
      const brand = await db.Brand.findByPk(id);
      if (!brand) return { EM: 'Brand not found', EC: '1', DT: null };
      await brand.update({
         name: data.name ?? brand.name,
         description: data.description ?? brand.description,
         logo_url: data.logo_url ?? brand.logo_url,
         country: data.country ?? brand.country,
      });
      return { EM: 'Brand updated', EC: '0', DT: brand };
   } catch (error) {
      console.error('Update brand error:', error);
      return { EM: 'Update brand error', EC: '-1', DT: null };
   }
};

const deleteBrand = async (id) => {
   try {
      const deleted = await db.Brand.destroy({ where: { brand_id: id } });
      if (!deleted) return { EM: 'Brand not found', EC: '1', DT: null };
      return { EM: 'Brand deleted', EC: '0', DT: null };
   } catch (error) {
      console.error('Delete brand error:', error);
      return { EM: 'Delete brand error', EC: '-1', DT: null };
   }
};

export default { getAllBrands, getBrandById, createBrand, updateBrand, deleteBrand };
