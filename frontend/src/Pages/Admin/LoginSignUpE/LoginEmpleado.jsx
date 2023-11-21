import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import './LoginEmpleadoE.css';
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';
import { useAuth } from "../../../contexts/auth";
import { useNavigate } from "react-router-dom";

const LoginEmpleado = () => {

  const navigate = useNavigate();

  const { isAuthenticated, iniciarSesionEmpleado } = useAuth();

  // Function to save information of the complaint answers
  const [formData, setFormData] = useState({
    username: "",
    password: "",
  });

  // Saves innformation for client login
  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [id]: value,
    }));
  };

  // Function to show on console
  const handleSubmit = (e) => {
    e.preventDefault();
    // Acces the console form data
    console.log(formData);
    iniciarSesionEmpleado(formData);
 
  };
  useEffect(() => {
    if (isAuthenticated)
      navigate("/main");
  }, [isAuthenticated]);
  // Renders the component in the page
  return (
    <div className="mainContainer">
    <div className="formulario">
      <p className="title">Inicio de Sesión Empleado</p>

      <form id="loginEstudianteForm" onSubmit={handleSubmit} method="post" >
        <div className="inputT1 username">
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
          <Link to="/main">
            <button className="buttonT1" type="submit" onClick={handleSubmit}>
              Iniciar Sesión
            </button>
          </Link>
        </div>
        <Link to="/registroEmpleado" className="registrarLink">
        Registrarse
        </Link>
      </form>
      
    </div>
    <div className="contenedor-imagenes">
        <img className = "imagen imagen-headder" src={trevolImage2} alt="LogoPackage" />
        <img className = "imagen" src={trevolImage} alt="LogoPackage" />
    </div>
    </div>
  );
};

export default LoginEmpleado;