import { Container, Col, Row } from "react-bootstrap";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import clothes_icon from "../../../assets/Links/clothing_title.jpg";
import "./Clothes.css";

const Clothes = () => {
  return (
    <PaginaBase>
      <Container className="custom-container-box">
        <Container className="custom-container">
          <h1 className="mb-5">Ropa</h1>
          <img src="clothes_icon" alt="menú ropa" />
          <Products category={"Ropa"} />
        </Container>
      </Container>
    </PaginaBase>
  );
};
export default Clothes;
