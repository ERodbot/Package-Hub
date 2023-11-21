import axios from "./axios";

const createOrder = (email, totalPrice, PayType) => axios.post(`/createOrder`, 
{params: {'email': email, 'totalPrice': totalPrice, 'PayType': PayType}});

const createOrderDetail = (orderID, product, quantity, price, discount) => axios.post(`/createOrderDetail`,
{params: {'orderID': orderID, 'product': product, 'quantity': quantity, 'price': price, 'discount': discount}});

const updateEstadoOrder = (orderID, estado) => axios.post(`/updateEstadoOrder`,
{params: {'orderID':orderID, 'estado': estado}});

export {
    createOrder,
    createOrderDetail,
    updateEstadoOrder
}