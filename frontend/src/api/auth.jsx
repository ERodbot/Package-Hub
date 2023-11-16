import axios from "./axios";

const registerRequest = (client) => axios.post(`/registerClient`, client);
const loginRequest = (client) => axios.post("/loginClient", client);
const verifyToken = (token) => axios.get("/verifyToken", token);

export {
    registerRequest,
    loginRequest,
    verifyToken
};