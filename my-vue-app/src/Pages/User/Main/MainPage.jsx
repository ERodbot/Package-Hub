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
import "./MainPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

/*Imagenes*/
import snaksmenu from "../../../assets/";
clothesmenu;
skatemenu;
drinksmenu;

const items = [];

const MainPage = () => {
  return (
    <PaginaBase>
      <Container>
        <h1 className="text-center">Títulos Principales</h1>
        <Row>
          {["snaks", "bebidad", "ropa", "skate"].map((item, index) => (
            <Col key={index} xs={6} sm={3}>
              <Card>
                <Card.Img src={item.imageSrc} alt={item} />
                <Card.Body>
                  <Card.Title>{item.title}</Card.Title>
                  <Card.Text>{item.subtitle}</Card.Text>
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
