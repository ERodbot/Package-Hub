import axios from "./axios";

const getRoles = () => axios.get(`/getRoles`);
const getProducts = () => axios.get(`/getProducts`);
const getCategories = () => axios.get(`/getCategories`);
const getPerformance = (startDate, endDate, role, country) => axios.get(`/getPerformance`, 
{ params: {'startDate': startDate, 'endDate': endDate, 'role': role, 'country': country}});

const getReportVentas = (productName, categoryName, startDate) => axios.get(`/getReportVentas`, 
{ params: {'productName':productName, 'categoryName': categoryName, 'startDate': startDate}});

const getVentas = () => axios.get(`/getVentas`);

export {
    getRoles,
    getProducts,
    getCategories,
    getPerformance,
    getReportVentas,
    getVentas
}