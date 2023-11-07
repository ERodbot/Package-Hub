import { Container, Col, Row } from "react-bootstrap";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import clothes_icon from "../../../assets/Decorations/clothing_title.jpg";
import "./Clothes.css";

const Clothes = () => {
  return (
    <PaginaBase>
      <Container className="custom-container-box">
        <Container className="custom-container">
          <div className="align-content-center mb-5">
            <h1>Ropa</h1>
            <img
              src={clothes_icon}
              alt="menú ropa"
              className="custom-title-image"
            />
          </div>

          <Products category={"Ropa"} url={"/productDetail"} />
        </Container>
      </Container>
    </PaginaBase>
  );
};
export default Clothes;
