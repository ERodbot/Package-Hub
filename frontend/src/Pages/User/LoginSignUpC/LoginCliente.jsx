import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import "./LoginSignUp.css";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../../contexts/auth";


// Funcion para el ingreso de un cliente
const LoginCliente = () => {

  const navigate = useNavigate();

  const { iniciar_sesion, user, isAuthenticated } = useAuth();

  const [formData, setFormData] = useState({
    username: "",
    password: "",
  });

  // Guarda varia informacion importante para el ingreso de un cliente
  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [id]: value,
    }));
  };

  // Funcion para mostrarlo en la consola
  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log(formData);
    iniciar_sesion(formData);
  };

  useEffect(() => {
    if (isAuthenticated)
      navigate("/main");
  }, [isAuthenticated]);

  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Inicio de Sesión</p>

        <form id="loginEstudianteForm" onSubmit={handleSubmit} method="post">
          <div className="inputT1 usernameC">
            <input
              id="username"
              type="text"
              placeholder="Username"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 password">
            <input
              id="password"
              type="password"
              placeholder="Password"
              required
              onChange={handleInputChange}
            />
          </div>

          <div>
            <button className="buttonT1" type="submit" onClick={handleSubmit}>
              Iniciar Sesión
            </button>
          </div>
          <Link to="/registroCliente" className="registrarLink">
            Registrarse
          </Link>
        </form>
      </div>
      <div className="contenedor-imagenes">
        <img
          className="imagen imagen-headder"
          src={trevolImage2}
          alt="LogoPackage"
        />
        <img className="imagen" src={trevolImage} alt="LogoPackage" />
      </div>
    </div>
  );
};

export default LoginCliente;