import axios from "./axios";

const getProductsCategory = (category) => axios.get(`/getProduct/${category}`);
const getProductDetails = (name) => axios.get(`/getProductDetails/${name}`);

export {
    getProductsCategory,
    getProductDetails
}