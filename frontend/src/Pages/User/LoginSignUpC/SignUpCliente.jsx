import React, { useEffect, useState } from 'react';
import "bootstrap/dist/css/bootstrap.min.css";
import "./LoginSignUp.css";
import { Dropdown } from "react-bootstrap";
import trevolImage from "../../../assets/Decorations/trevol_skate.png";
import trevolImage2 from "../../../assets/Logos/logotype.svg";
import { registerRequest, getCountry, getStates, getCities} from "../../../api/auth";
import { useNavigate } from "react-router-dom";

// Funcion para el registro de un cliente
const SignUpCliente = () => {

  const navigate = useNavigate();

  // Dropdown data
  const [countries, setCountries] = useState([]);
  const [states, setStates] = useState([]);
  const [cities, setCities] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getCountry();
        setCountries(response.data);
      } catch (error) {
        console.log(error);

      }
  };
  fetchData();
  }, []);


  const [formData, setFormData] = useState({
    username: "",
    name: "",
    lastname: "",
    email: "",
    telephone: "",
    password: "",
    country: "Pais",
    state: "Estado",
    city: "Ciudad",
    street: "",
    postal_code: 0
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
  const handleDropdownSelect = async (eventKey, dropdownType) => {
    if (dropdownType === 'country') {
      setFormData({ ...formData, country: eventKey, state: 'Estado', city: 'Ciudad' });
      try {
        const response = await getStates(eventKey);
        setStates(response.data);
        setCities([]); // Clear cities
      } catch (error) {
        console.log(error);
      }
    } else if (dropdownType === 'state') {
      setFormData({ ...formData, state: eventKey, city: 'Ciudad' });
      try {
        const response = await getCities(eventKey);
        setCities(response.data);
      }
      catch (error) {
        console.log(error);
      }
    } else if (dropdownType === 'city') {
      setFormData({ ...formData, city: eventKey });
    }
  };


  // Funcion para mostrarlo en la consola
  // Los datos se guardan asi: {username: 'Davder', password: '123456'}
  const handleSubmit = async (e) => {
    
    e.preventDefault();
    // Aquí puedes acceder a los valores del formulario en formData
    console.log("Form data", formData);
    try {
      const response = await registerRequest(formData);
      console.log(response);
      alert("Usuario registrado con éxito");
      navigate("/inicioSesionCliente")
    } catch (error) {
      console.log(error);
      alert("Error al registrar usuario");
    }

  };



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
              id="name"
              type="text"
              placeholder="name"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 usernameC">
            <input
              id="lastname"
              type="text"
              placeholder="Last Name"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 correo">
            <input
              id="email"
              type="email"
              placeholder="Correo"
              required
              onChange={handleInputChange}
            />
          </div>

          <div className="inputT1 telefono">
            <input
              id="telephone"
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

          {/* Country Dropdown */}
          <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey, 'country')}>
            <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
              {formData.country}
            </Dropdown.Toggle>
            <Dropdown.Menu>
              {countries.map((country, index) => (
                <Dropdown.Item key={index} eventKey={country.name}>
                  {country.name}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>

          {/* State Dropdown */}
          <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey, 'state')}>
            <Dropdown.Toggle variant="secondary" id="dropdownMenuButton" disabled={!formData.country || formData.country === 'Select Country'}>
              {formData.state}
            </Dropdown.Toggle>
            <Dropdown.Menu>
              {states.map((state, index) => (
                <Dropdown.Item key={index} eventKey={state.name}>
                  {state.name}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>

          {/* City Dropdown */}
          <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey, 'city')}>
            <Dropdown.Toggle variant="secondary" id="dropdownMenuButton" disabled={!formData.state || formData.state === 'Select State'}>
              {formData.city}
            </Dropdown.Toggle>
            <Dropdown.Menu>
              {cities.map((city, index) => (
                <Dropdown.Item key={index} eventKey={city.name}>
                  {city.name}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>

            <div className="inputT1 street">
            <input
              id="street"
              type="street"
              placeholder="Calle"
              required
              onChange={handleInputChange}
            />
            </div>

            <div className="inputT1 postal">
            <input
              id="postal_code"
              type="postal"
              placeholder="Codigo Postal"
              required
              onChange={handleInputChange}
            />
            </div>


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
