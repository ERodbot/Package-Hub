import React, { useState } from 'react';
import "bootstrap/dist/css/bootstrap.min.css";
import "./LoginSignUp.css";
import { Dropdown } from "react-bootstrap";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";

// Funcion para el registro de un cliente
const SignUpCliente = () => {
  const [formData, setFormData] = useState({
    username: "",
    correo: "",
    telefono: "",
    password: "",
    pais: "Pais de origen",
  });

  // Guarda varia informacion importante para el registro de un cliente
  // Basicamente lo que ingresa el usuario lo guarda en un array de la siguiente manera
  // {username: 'fasd', correo: 'fad', telefono: 'fads', password: 'fad', pais: 'Costa rica'}
  // Y en la consola se imprime por si se quiere ver los datos guardados
  
  // Funcion para tomar el input
  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [id]: value,
    }));
  };

  // Funcion para tomar el dropdown
  const handleDropdownSelect = (option) => {
    setFormData((prevData) => ({
      ...prevData,
      pais: option,
    }));
  };

  // Funcion para mostrarlo en la consola
  // Los datos se guardan asi: {username: 'Davder', password: '123456'}
  const handleSubmit = (e) => {
    
    e.preventDefault();
    // Aquí puedes acceder a los valores del formulario en formData
    console.log(formData);

  };

  // Datos del dropdown los cuales solo se agregan a la lista
  const dropdownOptions = ["Costa rica", "Venezuela"];

  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Registro de Cliente</p>

        <form id="loginEstudianteForm" onSubmit={handleSubmit}>
          <div className="inputT1 usernameC">
            <input
              id="username"
              type="text"
              placeholder="Username"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 usernameC">
            <input
              id="Name"
              type="text"
              placeholder="Name"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 usernameC">
            <input
              id="LastName"
              type="text"
              placeholder="Last Name"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 correo">
            <input
              id="correo"
              type="email"
              placeholder="Correo"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 telefono">
            <input
              id="telefono"
              type="tel"
              placeholder="Telefono"
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
              <button className="buttonT1" type="submit" onClick={handleSubmit}>
                Registrarse
              </button>
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
