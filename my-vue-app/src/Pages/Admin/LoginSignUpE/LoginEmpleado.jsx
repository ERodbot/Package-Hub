import React, { useState} from "react";
import { Link } from "react-router-dom";
import './LoginEmpleadoE.css';
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';

const LoginEmpleado = () => {
  // Funcion para guardar los valores de username y password
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
  const handleSubmit = (e) => {
    e.preventDefault();
    // Aquí se peude acceder a los valores del formulario en formData
    console.log(formData);
 
  };
  // Funcion para renderizar el componente
  return (
    <div className="mainContainer">
    <div className="formulario">
      <p className="title">Inicio de Sesión Empleado</p>

      <form id="loginEstudianteForm" onSubmit={handleSubmit} method="post" >
        <div className="inputT1 usernameC">
          <input
            id="usernameC"
            type="text"
            placeholder="Username"
            required
            onChange={handleInputChange}
          />
        </div>

        <div className="inputT1 password">
          <input
            id="passwordEstLog"
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
        <Link to="/registroCliente" className="registrarLink">
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