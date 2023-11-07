<<<<<<< HEAD
import React, { useState } from "react";
import { Link } from "react-router-dom";

import "./LoginSignUp.css";
import "bootstrap/dist/css/bootstrap.min.css";
import { Container, Row, Col, Dropdown } from "react-bootstrap";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";
=======
import React, { useState} from "react";
import { Link } from "react-router-dom";
import './LoginSignUp.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import {Dropdown } from "react-bootstrap";
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b

const SignUpCliente = () => {
  const [selectedOption, setSelectedOption] = useState("Pais de origen");

  const handleDropdownSelect = (option) => {
    setSelectedOption(option);
  };

  const dropdownOptions = ["Costa rica", "Venezuela"];

  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Registro de Cliente</p>

        <form id="loginEstudianteForm" method="post">
          <div className="inputT1 usernameC">
            <input id="usernameC" type="text" placeholder="Username" required />
          </div>

          <div className="inputT1 correo">
            <input id="correoC" type="correo" placeholder="Correo" required />
          </div>

          <div className="inputT1 telefono">
<<<<<<< HEAD
            <input
              id="telefonoC"
              type="telefono"
              placeholder="Telefono"
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
=======
            <input id="telefonoC" type="telefono" placeholder="Telefono" required />
          </div>

          <div className="inputT1 password">
            <input id="passwordEstLog" type="password" placeholder="Password" required />
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b
            <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey)}>
              <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
                {selectedOption}
              </Dropdown.Toggle>
              <Dropdown.Menu>
<<<<<<< HEAD
                <Dropdown.Item eventKey="Action">Action</Dropdown.Item>
                <Dropdown.Item eventKey="Another action">
                  Another action
                </Dropdown.Item>
                <Dropdown.Item eventKey="Something else here">
                  Something else here
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
            <Link to="/inicioSesionCliente">
              <button className="buttonT1" type="submit">
                Iniciar Sesión
              </button>
            </Link>
=======
                {dropdownOptions.map((option, index) => (
                  <Dropdown.Item key={index} eventKey={option}>
                    {option}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>
          <Link to="/main">
            <button className="buttonT1" type="submit">
              Iniciar Sesión
            </button>
          </Link>
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b
          </div>
        </form>
      </div>
      <div className="contenedor-imagenes">
<<<<<<< HEAD
        <img
          class="imagen imagen-headder"
          src={trevolImage2}
          alt="LogoPackage"
        />
        <img class="imagen" src={trevolImage} alt="LogoPackage" />
=======
        <img className="imagen imagen-headder" src={trevolImage2} alt="LogoPackage" />
        <img className="imagen" src={trevolImage} alt="LogoPackage" />
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b
      </div>
    </div>
  );
};

export default SignUpCliente;
