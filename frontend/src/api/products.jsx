import axios from "./axios";

const getAllInventoryProducts = (category) => axios.get(`/getAllInventoryProducts`);
const getProductsCategory = (category) => axios.get(`/getProduct/${category}`);
const getProductDetails = (name) => axios.get(`/getProductDetails/${name}`);

export {
    getAllInventoryProducts,
    getProductsCategory,
    getProductDetails
}