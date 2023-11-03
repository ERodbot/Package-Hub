import React from "react";
import './LoginSignUp.css';
import trevolImage from '../../../assets/Decorations/trevol_skate.png';


const LoginCliente = () => {
  return (
    <div className="formulario">
      <p className="title">Inicio de Sesión</p>
    
      <form id="loginEstudianteForm" method="post">
        <div className="inputT1 usernameC">
          <input
            id="usernameC"
            type="text"
            placeholder="Username"
            required
          />
        </div>

        <div className="inputT1 password">
          <input
            id="passwordEstLog"
            type="password"
            placeholder="Password"
            required
          />
        </div>

        <div>
          <button className="buttonT1" type="submit">
            Iniciar Sesión
          </button>
        </div>
      </form>
      <div className="imagenInicio">
        <img src={trevolImage} alt="LogoPackage" />
      </div>
    </div>
  );
};

export default LoginCliente;