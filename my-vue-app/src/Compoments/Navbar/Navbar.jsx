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

/*Custom css*/
import "./Navbar.css";

/*Imagenes*/
import logo from "../../assets/logotype.svg";
import shopping_cart from "../../assets/shoes.png";
import profile from "../../assets/profile.jpg";
import cr from "../../assets/cr.jpg";

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
      <Container>
        <Navbar.Brand href="/Principal" className="mr-4">
          <img src={logo} alt="ucr logo" id="custom-brand" />
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="my-auto">
            {["Inicio", "Acerca", "Otros"].map((val) => {
              return (
                <Nav.Link
                  href={"/" + val}
                  className="mx-4 "
                  id="custom-navlink"
                >
                  {val}
                </Nav.Link>
              );
            })}
            <NavDropdown id="custom-dropdown">
              <NavDropdown.Item href="/ordenes">Ordenes</NavDropdown.Item>
              <NavDropdown.Item href="/facturas">Facturas</NavDropdown.Item>
              <NavDropdown.Item href="/servicio-cliente">
                Servicio al Cliente
              </NavDropdown.Item>
              <NavDropdown.Item href="/salir">Salir</NavDropdown.Item>
            </NavDropdown>
            <InputGroup className="search-input">
              <FormControl
                className="my-auto"
                placeholder="Buscar"
                value={searchTerm}
                onChange={handleSearch}
                id="custom-searchbar"
              />
            </InputGroup>
            <Container>
              <img src={shopping_cart} id="custom-img" />
            </Container>
            <Container>
              <img src={profile} id="custom-img" />
            </Container>
            <Container>
              <img src={cr} id="custom-img" />
            </Container>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};
export default NavbarPage;
