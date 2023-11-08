import React, { useState } from "react";
import { Link } from "react-router-dom";
import './LoginEmpleadoE.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Dropdown } from "react-bootstrap";
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';

const SignUpEmpleado = () => {
  const [formData, setFormData] = useState({
    usernameE: "",
    correoE: "",
    telefonoE: "",
    passwordE: "",
    pais: "Pais de origen",
    rol: "Rol en empresa",
  });

  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [id]: value,
    }));
  };

  const handleDropdownSelect = (option) => {
    setFormData((prevData) => ({
      ...prevData,
      pais: option,
    }));
  };

  const handleDropdownSelect2 = (option) => {
    setFormData((prevData) => ({
      ...prevData,
      rol: option,
    }));
  };

  // Asi se guarda la informacion {usernameE: 'fads', correoE: 'fasd@a', telefonoE: 'fasd', passwordE: 'afds', pais: 'Costa rica', rol: 'Admin'}
  const handleSubmit = (e) => {
    e.preventDefault();
    console.log(formData);
    // Aquí puedes realizar otras operaciones con los datos del formulario si es necesario
  };

  const dropdownOptions = ["Costa rica", "Venezuela"];
  const dropdownOptions2 = ["Admin", "Employee"];

  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Registro de Empleado</p>

        <form id="loginEstudianteForm" onSubmit={handleSubmit} method="post">
          <div className="inputT1 usernameC">
            <input id="usernameE" type="text" placeholder="Username" required onChange={handleInputChange} />
          </div>

          <div className="inputT1 correo">
            <input id="correoE" type="email" placeholder="Correo" required onChange={handleInputChange} />
          </div>

          <div className="inputT1 telefono">
            <input id="telefonoE" type="tel" placeholder="Telefono" required onChange={handleInputChange} />
          </div>

          <div className="inputT1 password">
            <input id="passwordE" type="password" placeholder="Password" required onChange={handleInputChange} />
            <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey)}>
              <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
                {formData.pais}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {dropdownOptions.map((option, index) => (
                  <Dropdown.Item key={index} eventKey={option}>
                    {option}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>

            <Dropdown onSelect={(eventKey) => handleDropdownSelect2(eventKey)}>
              <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
                {formData.rol}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {dropdownOptions2.map((option, index) => (
                  <Dropdown.Item key={index} eventKey={option}>
                    {option}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>
            
            <button className="buttonT1" type="submit">
              Iniciar Sesión
            </button>
          </div>
        </form>
      </div>
      <div className="contenedor-imagenes">
        <img className="imagen imagen-headder" src={trevolImage2} alt="LogoPackage" />
        <img className="imagen" src={trevolImage} alt="LogoPackage" />
      </div>
    </div>
  );
};
export default SignUpEmpleado;