/* React components and hooks */
import React, { useState, useEffect } from "react";
import {
  Nav,
  Navbar,
  Container,
  InputGroup,
  FormControl,
  NavDropdown,
  Button,
} from "react-bootstrap";
import { Link, useNavigate } from "react-router-dom";

/* Custom CSS styles */
import "./NavbarEmpleado.css";

/* Images */
import logo from "../../assets/Logos/logotype.svg";
import shopping_cart from "../../assets/Links/shopping_cart.png";
import profile from "../../assets/Links/profile.jpg";
import cr from "../../assets/Links/cr.jpg";
import { useAuth } from "../../contexts/auth";

// Functional component definition
const NavbarPage = () => {

  const navigate = useNavigate();
  // State for search term input
  const [searchTerm, setSearchTerm] = useState("");
  const { logout } = useAuth();

  // Event handler for search input
  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  // Effect for logging search term to console
  useEffect(() => {
    console.log(searchTerm);
  }, [searchTerm]);

  const salir = () => {
    logout();
  };

  const handleButtonClick = (searchTerm) => {
    if (searchTerm === "Inicio") {
      navigate("/main");
    }
    else if (searchTerm === "Acerca") {
      navigate("/about");
    }
    else {
      navigate("/other");
    }
  }

  return (
    <Navbar
      className="navbar navbar-expand-sm custom-navbar "
      fixed="top"
      id="custom-navbar"
    >
      <Container id="custom-container">
        {/* Brand logo */}
        <Navbar.Brand href="/main">
          <img src={logo} alt="Logo marca" id="custom-brand" />
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="my-auto">
            {/* Map through navigation links */}
            {["Inicio", "Acerca", "Otros"].map((val, index) => (
              <Button className="mx-auto mt- btn btn-link "
              id="custom-navlink"
              key={index}
              onClick={
                () => handleButtonClick(val)
              }>
                
                {val}
              </Button>
            ))}
            {/* Dropdown menu for additional links */}
            <NavDropdown id="custom-dropdown">
              <NavDropdown.Item href="/answerComplaints"> Responder quejas </NavDropdown.Item>
              <NavDropdown.Item href="/invetoryManager">Inventario</NavDropdown.Item>
              <NavDropdown.Item href="/ReportSales"> Reporte ventas </NavDropdown.Item>
              <NavDropdown.Item href="/ordenesEmpleado"> Ordenes Empleado </NavDropdown.Item>
            </NavDropdown>
            {/* Search input */}
            <InputGroup className="search-input mt-4">
              <FormControl
                className="my-auto"
                placeholder="Buscar"
                value={searchTerm}
                onChange={handleSearch}
                id="custom-searchbar"
              />
            </InputGroup>
            {/* Shopping cart link */}
            <Container>
              <Link to="/shoppingCart">
                <img src={shopping_cart} id="custom-img" className="mt-2" />
              </Link>
              <p>Carrito</p>
            </Container>
            {/* Profile link */}
            <Container>
              <Link to="/profileCliente">
                <img src={profile} id="custom-img" className="mt-2" />
              </Link>
              <p>Perfil</p>
            </Container>
            {/* Image for "Otros" section */}
            <Container>
              <img src={cr} id="custom-img" className="mt-3" />
            </Container>
            <Container>
              <button id="custom-img" className="btn mt-3" onClick={salir}>
                Salir
              </button>
            </Container>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

// Exporting the NavbarPage component
export default NavbarPage;
