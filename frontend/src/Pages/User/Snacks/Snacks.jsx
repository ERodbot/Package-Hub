import { Container, Col, Row } from "react-bootstrap";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import snacks_title from "../../../assets/Decorations/food_title.jpg";
import "./Snacks.css";

const Snacks = () => {
  return (
    <PaginaBase>
      <Container className="custom-container-box">
        <Container className="custom-container">
          <div className="align-content-center mb-5">
            <h1>Snacks</h1>
            <img
              src={snacks_title}
              alt="menú snacks"
              className="custom-title-image"
            />
          </div>

          <Products category={"Snacks"}/>
        </Container>
      </Container>
    </PaginaBase>
  );
};
export default Snacks;
