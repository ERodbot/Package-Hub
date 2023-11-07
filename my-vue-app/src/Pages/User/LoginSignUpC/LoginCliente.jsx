<<<<<<< HEAD
import React from "react";
import { Link } from "react-router-dom";
import "./LoginSignUp.css";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";
=======
import React, { useState} from "react";
import { Link } from "react-router-dom";
import './LoginSignUp.css';
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b

const LoginCliente = () => {
  return (
    <div className="mainContainer">
<<<<<<< HEAD
      <div className="formulario">
        <p className="title">Inicio de Sesión</p>
=======
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
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b

        <form id="loginEstudianteForm" method="post">
          <div className="inputT1 usernameC">
            <input id="usernameC" type="text" placeholder="Username" required />
          </div>

<<<<<<< HEAD
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
=======
        <div>
          <Link to="/main">
            <button className="buttonT1" type="submit">
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
        <img class = "imagen imagen-headder" src={trevolImage2} alt="LogoPackage" />
        <img class = "imagen" src={trevolImage} alt="LogoPackage" />
    </div>
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b
    </div>
  );
};

export default LoginCliente;
