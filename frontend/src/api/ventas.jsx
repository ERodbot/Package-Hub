import axios from "./axios";

const createOrder = (email, totalPrice, PayType) => axios.post(`/createOrder`, null,
{params: {'email': email, 'totalPrice': totalPrice, 'payType': PayType}});

const createOrderDetail = (orderID, product, quantity, price, discount) => axios.post(`/createOrderDetail`, null,
{params: {'orderid': orderID, 'product': product, 'quantity': quantity, 'price': price, 'discount': discount}});

const updateEstadoOrder = (orderID, estado) => axios.post(`/updateEstadoOrder`,
{params: {'orderID':orderID, 'estado': estado}});

export {
    createOrder,
    createOrderDetail,
    updateEstadoOrder
}