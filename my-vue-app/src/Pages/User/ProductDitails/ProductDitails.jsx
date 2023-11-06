import React, { useState } from "react";
import { Card, Carousel, Container, Row, Col, Button } from "react-bootstrap";
import { Link } from "react-router-dom";

import Color from "../../../Compoments/Color/Color";
import "./ProductDitails.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

/*imagen de prueba*/
import product_img1 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img1.jpg";
import product_img2 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img2.png";

const productDetailsData = {
  marca: "Ejemplo Marca",
  color: "Rojo",
  descripción: "Este es un producto de ejemplo",
  material: "Plástico",
  peso: "1.5 kg",
};

const colors = ["red", "black", "yellow"];

const ProductDetails = () => {
  const [cantidad, setCantidad] = useState(1);
  const [precioUnitario] = useState(49.99);
  const [envio] = useState(5.0);
  const [fotos, setFotos] = useState([product_img1, product_img2]);
  // Calcular subtotal y total usando el estado de cantidad
  const [subtotal, setSubtotal] = useState(cantidad * precioUnitario);
  const [total, setTotal] = useState(subtotal + envio);
  return (
    <PaginaBase>
      <Container>
        <Row>
          <Col md={9} className="custom-col-product-display">
            <Card className="product-detail-main-card">
              <Row>
                <Col md={6}>
                  <Carousel className="mx-5">
                    {fotos.map((item, key) => {
                      return (
                        <Carousel.Item>
                          <img
                            className="d-block w-100"
                            src={item}
                            alt={`slide # ${key}`}
                          />
                        </Carousel.Item>
                      );
                    })}
                  </Carousel>
                  <h4>Colores: </h4>
                  {colors.map((val) => {
                    return <Color style={val} />;
                  })}
                </Col>
                <Col md={6} className="text-align-start">
                  <h2 className="my-5"> ProductDetails.</h2>
                  <Row className="m-2 ">
                    {Object.entries(productDetailsData).map(([key, value]) => (
                      <>
                        <Col md={5} key={key} className="mx-4">
                          <p>
                            <strong>{key}: </strong>
                          </p>
                        </Col>
                        <Col md={5} key={key}>
                          <p>{value}</p>
                        </Col>
                      </>
                    ))}

                    <Col md={12}>
                      <hr />
                    </Col>
                    <Col md={6}>
                      <p>
                        <strong>Unidades: </strong>
                      </p>
                    </Col>
                    <Col md={6}>
                      <Button
                        className="units-to-buy-button"
                        onClick={() => setCantidad(cantidad + 1)}
                      >
                        {cantidad}. +
                      </Button>
                    </Col>
                  </Row>
                </Col>
              </Row>
            </Card>
          </Col>
          <Col>
            <Card className="buy-options-display">
              <h2 className="my-5">Info del envío</h2>
              <Row>
                <Col md={6}>
                  <p>
                    <strong>Unidad: </strong>
                  </p>
                  <p>
                    <strong>Subtotal: </strong>
                  </p>
                  <p>
                    <strong>Envío: </strong>
                  </p>
                </Col>
                <Col md={6}>
                  <p>${precioUnitario.toFixed(2)}</p>
                  <p>${subtotal.toFixed(2)}</p>
                  <p>${envio.toFixed(2)}</p>
                </Col>
              </Row>
              <hr />
              <h4>
                <strong>Total a Pagar: </strong>
              </h4>
              <h2> ${total.toFixed(2)}</h2>
              <hr />
              <Row>
                <Col md={12}>
                  <Link to="/shoppingCart">
                    <Button className="m-1 w-100 custom-product-detail-button-add">
                      Agregar al carrito
                    </Button>
                  </Link>
                  <Button className="m-1 w-100 custom-product-detail-button-buy">
                    Comprar Ahora
                  </Button>
                </Col>
              </Row>
            </Card>
          </Col>
        </Row>
      </Container>
    </PaginaBase>
  );
};

export default ProductDetails;
