/* ProductCard Component */

import React from "react";
import { Card, Carousel, Col, Row, Button } from "react-bootstrap";
import Color from "../Color/Color";
import "./ProductDetailsDisplay.css";

const ProductCard = ({
  // Props for managing product quantity, value, shipping, images, colors, and details
  cantidad,
  setValQuantity,
  value,
  shipping,
  fotos,
  colors,
  productDetailsData,
  // Functions for updating quantity, subtotal, and total
  updateCantidad,
  setSubtotal,
  setTotal,
}) => {
  return (
    /* Main card for displaying product details */
    <Card className="product-detail-main-card">
      <Row>
        {/* Carousel for displaying product images */}
        <Col md={6}>
          <Carousel className="mx-5">
            {/* Map through images to create carousel items */}
            {fotos.map((item, key) => (
              <Carousel.Item key={key}>
                <img
                  className="d-block w-100"
                  src={item}
                  alt={`slide # ${key}`}
                />
              </Carousel.Item>
            ))}
          </Carousel>
          {/* Display available colors */}
          <h4>Colores disponibles: </h4>
          {colors.map((val, index) => (
            <Color key={index} style={val} />
          ))}
        </Col>
        {/* Product details and quantity section */}
        <Col md={6} className="text-align-start">
          <h2 className="my-5">Detalles del producto.</h2>
          {/* Map through product details and display them */}
          <Row className="m-2">
            {Object.entries(productDetailsData).map(([key, value]) => (
              <React.Fragment key={key}>
                <Col md={5} className="mx-4">
                  <p>
                    <strong>{key}: </strong>
                  </p>
                </Col>
                <Col md={5}>
                  <p>{value}</p>
                </Col>
              </React.Fragment>
            ))}
            <Col md={12}>
              <hr />
            </Col>
            {/* Section for adjusting the quantity of the product */}
            <Col md={6}>
              <p>
                <strong>Unidades a comprar: </strong>
              </p>
            </Col>
            <Col md={6}>
              {/* Buttons to increase or decrease the quantity */}
              <Button
                className="units-to-buy-button"
                onClick={() => {
                  setValQuantity((prevCantidad) => prevCantidad + 1);
                  updateCantidad(cantidad + 1);
                  setSubtotal((prevSubtotal) => (cantidad + 1) * value);
                  setTotal((prevTotal) => (cantidad + 1) * value + shipping);
                }}
              >
                {cantidad} (+)
              </Button>
              <Button
                className="units-to-buy-button"
                onClick={() => {
                  if (cantidad > 1) {
                    setValQuantity((prevCantidad) => prevCantidad - 1);
                    updateCantidad(cantidad - 1);
                    setSubtotal((prevSubtotal) => (cantidad - 1) * value);
                    setTotal((prevTotal) => (cantidad - 1) * value + shipping);
                  }
                }}
              >
                (-)
              </Button>
            </Col>
          </Row>
        </Col>
      </Row>
    </Card>
  );
};

export default ProductCard;
