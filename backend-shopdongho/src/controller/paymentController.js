import paymentService from '../services/paymentService';
const updatePayment = async (req, res) => {
    try {
        console.log('req.body', req.body);
        const data = await paymentService.updatePayment(req.body);
        console.log('data', data);
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT,
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            EM: 'error from server',
            EC: '-1',
            DT: '',
        });
    }
}

export default {
    updatePayment
}

