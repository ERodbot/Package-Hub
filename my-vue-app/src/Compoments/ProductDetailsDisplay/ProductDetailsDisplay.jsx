import React, { useState } from "react";
import { Card, Carousel, Col, Row, Button } from "react-bootstrap";
import Color from "../Color/Color";
import "./ProductDetailsDisplay.css";

const ProductCard = ({
  cantidad,
  setValQuantity,
  value,
  shipping,
  fotos,
  colors,
  productDetailsData,
  updateCantidad,
  setSubtotal,
  setTotal,
}) => {
  return (
    <Card className="product-detail-main-card">
      <Row>
        <Col md={6}>
          <Carousel className="mx-5">
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
          <h4>Colores: </h4>
          {colors.map((val, index) => {
            return <Color key={index} style={val} />;
          })}
        </Col>
        <Col md={6} className="text-align-start">
          <h2 className="my-5">ProductDetails.</h2>
          <Row className="m-2 ">
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
            <Col md={6}>
              <p>
                <strong>Unidades: </strong>
              </p>
            </Col>
            <Col md={6}>
              <Button
                className="units-to-buy-button"
                onClick={() => {
                  setValQuantity((prevCantidad) => prevCantidad + 1);
                  updateCantidad(cantidad + 1);
                  setSubtotal((prevSubtotal) => (cantidad + 1) * value);
                  setTotal((prevTotal) => (cantidad + 1) * value + shipping);
                }}
              >
                {cantidad}. +
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
                -
              </Button>
            </Col>
          </Row>
        </Col>
      </Row>
    </Card>
  );
};

export default ProductCard;
