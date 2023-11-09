/*React*/
import {
  Nav,
  Navbar,
  Container,
  InputGroup,
  FormControl,
  NavDropdown,
} from "react-bootstrap";
import { useState, useEffect } from "react";
import { Link } from "react-router-dom";

/*Custom css*/
import "./Navbar.css";

/*Imagenes*/
import logo from "../../assets/Logos/logotype.svg";
import shopping_cart from "../../assets/Links/shopping_cart.png";
import profile from "../../assets/Links/profile.jpg";
import cr from "../../assets/Links/cr.jpg";

const NavbarPage = () => {
  const [searchTerm, setSearchTerm] = useState("");

  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  useEffect(() => {
    console.log(searchTerm);
  }, [searchTerm]);

  return (
    <Navbar
      className="navbar navbar-expand-sm custom-navbar "
      fixed="top"
      id="custom-navbar"
    >
      <Container id="custom-container">
        <Navbar.Brand href="/main">
          <img src={logo} alt="Logo marca" id="custom-brand" />
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="my-auto">
            {["Inicio", "Acerca", "Otros"].map((val) => {
              return (
                <Nav.Link
                  href={val === "Inicio" ? "/main" : undefined}
                  className="mx-4 mt-3"
                  id="custom-navlink"
                >
                  {val}
                </Nav.Link>
              );
            })}
            <NavDropdown id="custom-dropdown">
              <NavDropdown.Item href="/ordenesCliente">
                Ordenes
              </NavDropdown.Item>
              <NavDropdown.Item href="/receipt">Facturas</NavDropdown.Item>
              <NavDropdown.Item href="/servicioCliente">
                Servicio al Cliente
              </NavDropdown.Item>
              <NavDropdown.Item href="/inicioSesionCliente">
                Salir
              </NavDropdown.Item>
            </NavDropdown>
            <InputGroup className="search-input mt-4">
              <FormControl
                className="my-auto"
                placeholder="Buscar"
                value={searchTerm}
                onChange={handleSearch}
                id="custom-searchbar"
              />
            </InputGroup>
            <Container>
              <Link to="/shoppingCart">
                <img src={shopping_cart} id="custom-img" className="mt-2" />
              </Link>
              <p>Carrito</p>
            </Container>
            <Container>
              <Link to="/profileCliente">
                <img src={profile} id="custom-img" className="mt-2" />
              </Link>
              <p>Perfil</p>
            </Container>
            <Container>
              <img src={cr} id="custom-img" className="mt-3" />
            </Container>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};
export default NavbarPage;
