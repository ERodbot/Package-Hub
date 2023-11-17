import axios from "./axios";

const getRoles = () => axios.get(`/getRoles`);
const getPerformance = (startDate, endDate, role, country) => axios.get(`/getPerformance`, 
{ params: {'startDate': startDate, 'endDate': endDate, 'role': role, 'country': country}});

export {
    getRoles,
    getPerformance
}