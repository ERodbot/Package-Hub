import React from "react";
import { Link } from "react-router-dom";
import "./LoginSignUp.css";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";

const LoginCliente = () => {
  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Inicio de Sesión</p>

        <form id="loginEstudianteForm" method="post">
          <div className="inputT1 usernameC">
            <input id="usernameC" type="text" placeholder="Username" required />
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
            <Link to="/main">
              <button className="buttonT1" type="submit">
                Iniciar Sesión
              </button>
            </Link>
          </div>
        </form>
      </div>
      <div className="contenedor-imagenes">
        <img
          class="imagen imagen-headder"
          src={trevolImage2}
          alt="LogoPackage"
        />
        <img class="imagen" src={trevolImage} alt="LogoPackage" />
      </div>
    </div>
  );
};

export default LoginCliente;
