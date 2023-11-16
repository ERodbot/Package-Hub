// Import necessary components, styles, and images
import { Container, Row, Col, Card } from "react-bootstrap";
import "./MainPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import snacksmenu from "../../../assets/Menus/snacks.svg";
import drinks from "../../../assets/Menus/drinks.svg";
import clothesmenu from "../../../assets/Menus/clothes.svg";
import skatemenugit from "../../../assets/Menus/skate.svg";
import { Link } from "react-router-dom";

// Arrays containing menu images and names
const menus = [snacksmenu, drinks, clothesmenu, skatemenugit];
const menu_names = ["Snacks", "Drinks", "Clothes", "Skate"];
const menu_names_spanish = ["Snacks", "Bebidas", "Ropa", "Skate"];

// MainPage functional component
const MainPage = () => {
  // JSX structure for the MainPage component
  return (
    <PaginaBase>
      <Container id="custom-container">
        <h1 className="text-center">Package Hub</h1>
        {/* Row of menu items */}
        <Row>
          {menus.map((item, index) => (
            // Column for each menu item
            <Col key={index} xs={6} sm={3} id="custom-col">
              {/* Card for each menu item with a link to the respective page */}
              <Card id="custom-card">
                <Link to={"/" + menu_names[index]}>
                  {/* Menu image */}
                  <Card.Img
                    src={menus[index]}
                    alt={menu_names[index]}
                    id="custom-card-img"
                  />
                </Link>
                {/* Card body with menu name */}
                <Card.Body>
                  <Card.Title>{menu_names_spanish[index]}</Card.Title>
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
