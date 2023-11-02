/*React*/
import {
  Nav,
  Navbar,
  Container,
  Row,
  Col,
  Card,
  InputGroup,
  FormControl,
  NavDropdown,
} from "react-bootstrap";
import { useState, useEffect } from "react";

/*Custom css*/
import "./MainPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

/*Imagenes*/
import snacksmenu from "../../../assets/Menus/snacks.svg";
import drinks from "../../../assets/Menus/drinks.svg";
import clothesmenu from "../../../assets/Menus/clothes.svg";
import skatemenugit from "../../../assets/Menus/skate.svg";

const menus = [snacksmenu, drinks, clothesmenu, skatemenugit];
const menu_names = ["Snacks", "Drinks", "Clothes", "Skate"];
import { Link } from "react-router-dom";

const MainPage = () => {
  return (
    <PaginaBase>
      <Container id="custom-container">
        <h1 className="text-center">Package Hub</h1>
        <Row>
          {menus.map((item, index) => (
            <Col key={index} xs={6} sm={3} id="custom-col">
              <Card id="custom-card">
                <Link to={"/" + menu_names[index]}>
                  <Card.Img
                    src={menus[index]}
                    alt={menu_names[index]}
                    id="custom-card-img"
                  />
                </Link>

                <Card.Body>
                  <Card.Title>{menu_names[index]}</Card.Title>
                </Card.Body>
              </Card>
            </Col>
          ))}
        </Row>
      </Container>
    </PaginaBase>
  );
};
export default MainPage;
