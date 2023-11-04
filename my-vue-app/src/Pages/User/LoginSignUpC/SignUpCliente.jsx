import React, { useState } from "react";
import './LoginSignUp.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Container, Row, Col, Dropdown } from "react-bootstrap";
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';

const SignUpCliente = () => {
  const [selectedOption, setSelectedOption] = useState("Dropdown button");

  const handleDropdownSelect = (option) => {
    setSelectedOption(option);
  };

  return (
    <div className="mainContainer">
    <div className="formulario">
      <p className="title">Registro de Cliente</p>
      
      <form id="loginEstudianteForm" method="post">
        <div className="inputT1 usernameC">
          <input
            id="usernameC"
            type="text"
            placeholder="Username"
            required
          />
        </div>

        <div className="inputT1 correo">
          <input
            id="correoC"
            type="correo"
            placeholder="Correo"
            required
          />
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
              <Dropdown.Item eventKey="Action">Action</Dropdown.Item>
              <Dropdown.Item eventKey="Another action">Another action</Dropdown.Item>
              <Dropdown.Item eventKey="Something else here">Something else here</Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>

          <button className="buttonT1" type="submit">
            Iniciar Sesión
          </button>
        </div>
      </form>
      
    </div>
    <div className="contenedor-imagenes">
        <img class = "imagen imagen-headder" src={trevolImage2} alt="LogoPackage" />
        <img class = "imagen" src={trevolImage} alt="LogoPackage" />
    </div>
    </div>
  );
};

export default SignUpCliente;