import axios from "./axios";

const registerRequest = (client) => axios.post(`/registerClient`, client);
const loginRequest = (client) => axios.post("/loginClient", client);
const verifyToken = (token) => axios.get("/verifyToken", token);
const getCountry = () => axios.get("/getCountry");
const getStates = (name) => axios.get(`/getState/${name}`);
const getCities = (name) => axios.get(`/getCity/${name}`);




export {
    registerRequest,
    loginRequest,
    verifyToken,
    getCountry,
    getStates,
    getCities
};