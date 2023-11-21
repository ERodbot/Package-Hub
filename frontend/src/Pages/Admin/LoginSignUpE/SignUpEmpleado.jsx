import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import './LoginEmpleadoE.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Dropdown } from "react-bootstrap";
import trevolImage from '../../../assets/Decorations/trevol_skate.png';
import trevolImage2 from '../../../assets/Logos/logotype.svg';
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../../contexts/auth";
import { getCountry, getStates, getCities, registerEmployee } from "../../../api/auth";
import { getRoles } from "../../../api/reporting";

// Function to save information of the complaint answers
const SignUpEmpleado = () => {

  const { isAuthenticated } = useAuth();

  const navigate = useNavigate();

  const [countries, setCountries] = useState([]);
  const [states, setStates] = useState([]);
  const [cities, setCities] = useState([]);
  const [roles, setRoles] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getCountry();
        setCountries(response.data);
        const response2 = await getRoles();
        setRoles(response2.data);
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
    phone: "",
    password: "",
    country: "Pais",
    state: "Estado",
    city: "Ciudad",
    street: "",
    postal_code: "",
    rol: "Rol en empresa",
    
    
    
  });

  // Saves the information of the form
  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [id]: value,
    }));
  };

  // Saves the information of the dropdown contry
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

    } else if (dropdownType === 'rol') {
      setFormData({ ...formData, rol: eventKey });
    }
  };

  // The information is saved like this {usernameE: 'fads', correoE: 'fasd@a', telefonoE: 'fasd', passwordE: 'afds', pais: 'Costa rica', rol: 'Admin'}
  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await registerEmployee(formData);
      console.log(response);
      alert("Usuario registrado con éxito");
      navigate("/inicioSesionEmpleado")
    } catch (error) {
      console.log(error);
      alert("Error al registrar usuario");
    }
    // Here you can make some backend operations
  };

  useEffect(() => {
    if (isAuthenticated)
      navigate("/main");
  }, [isAuthenticated]);

  // Renders the component in the page
  return (
    <div className="mainContainer">
      <div className="formulario">
        <p className="title">Registro de Empleado</p>

        <form id="loginEstudianteForm" onSubmit={handleSubmit} method="post">
          <div className="inputT1 usernameC">
            <input id="username" type="text" placeholder="Username" required onChange={handleInputChange} />
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
            <input id="email" type="email" placeholder="Correo" required onChange={handleInputChange} />
          </div>

          <div className="inputT1 telefono">
            <input id="phone" type="tel" placeholder="Telefono" required onChange={handleInputChange} />
          </div>

          <div className="inputT1 password">
            <input id="password" type="password" placeholder="Password" required onChange={handleInputChange} />

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
              type="street  "
              placeholder="Calle"
              required
              onChange={handleInputChange}
            />
            </div>

            <div className="inputT1 postal">
            <input
              id="postal"
              type="postal"
              placeholder="Codigo Postal"
              required
              onChange={handleInputChange}
            />
            </div>

            <Dropdown onSelect={(eventKey) => handleDropdownSelect(eventKey, 'rol')}>
              <Dropdown.Toggle variant="secondary" id="dropdownMenuButton">
                {formData.rol}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {roles.map((rol, index) => (
                  <Dropdown.Item key={index} eventKey={rol.name}>
                    {rol.name}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>
            
            <button className="buttonT1" type="submit">
              Registrarse
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