import axios from "./axios";

const getRoles = () => axios.get(`/getRoles`);
const getProducts = () => axios.get(`/getProducts`);
const getCategories = () => axios.get(`/getCategories`);
const getPerformance = (startDate, endDate, role, country) => axios.get(`/getPerformance`, 
{ params: {'startDate': startDate, 'endDate': endDate, 'role': role, 'country': country}});
const getPayroll = (startDate, endDate) => axios.get(`/getPayroll`,
{ params: {'startDate': startDate, 'endDate': endDate}});

const getReportVentas = (productName, categoryName, startDate) => axios.get(`/getReportVentas`, 
{ params: {'productName':productName, 'categoryName': categoryName, 'startDate': startDate}});

const getVentas = () => axios.get(`/getVentas`);

const getTickets = () => axios.get(`/getTickets`);

const getEmployeeOrders = (usernameclient, email) => axios.get(`/getEmployeeOrders`,
{ params: {'usernameclient': usernameclient, 'email': email}});

const getClientOrders = (usernameclient, email) => axios.get(`/getClientOrders`,
{ params: {'usernameclient': usernameclient, 'email': email}});

export {
    getRoles,
    getProducts,
    getCategories,
    getPerformance,
    getPayroll,
    getReportVentas,
    getVentas,
    getTickets, 
    getEmployeeOrders,
    getClientOrders
}
