import { Container, Col, Row } from "react-bootstrap";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import skate_title from "../../../assets/Decorations/skate_title.jpg";
import "./Skate.css";

const Skate = () => {
  return (
    <PaginaBase>
      <Container className="custom-container-box">
        <Container className="custom-container">
          <div className="align-content-center mb-5">
            <h1>Skate</h1>
            <img
              src={skate_title}
              alt="menú skate"
              className="custom-title-image"
            />
          </div>

          <Products category={"Skate"} url={"/productDetail"} />
        </Container>
      </Container>
    </PaginaBase>
  );
};
export default Skate;
