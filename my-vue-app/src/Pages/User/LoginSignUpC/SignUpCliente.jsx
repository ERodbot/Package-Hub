import React, { useState } from "react";
import { Link } from "react-router-dom";
import "./LoginSignUp.css";
import "bootstrap/dist/css/bootstrap.min.css";
import { Dropdown } from "react-bootstrap";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";

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
            <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey)}>
              <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
                {selectedOption}
              </Dropdown.Toggle>
              <Dropdown.Menu>
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
          </div>
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

export default SignUpCliente;
