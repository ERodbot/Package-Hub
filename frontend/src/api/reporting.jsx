import axios from "./axios";

const getRoles = () => axios.get(`/getRoles`);

export {
    getRoles
}