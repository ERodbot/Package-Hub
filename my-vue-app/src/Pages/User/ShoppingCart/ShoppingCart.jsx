import React, { useState, useEffect } from "react";
import { Card, Button, Container, Row, Col } from "react-bootstrap";
import ProductDisplay from "../../../Compoments/ProductDisplay/ProductDisplay";
import jsonData from "./data.json";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import cart_decoration from "../../../assets/Decorations/cart_decoration.jpg";
import "./ShoppingCart.css";

const ShoppingCart = () => {
  // Initialize state to hold product data and total price
  const [products, setProducts] = useState([]);
  const [totalPrice, setTotalPrice] = useState(0);

  useEffect(() => {
    // Load data from the JSON file into the state
    setProducts(jsonData.products);

    // Calculate the total price considering the units purchased for each product
    const total = jsonData.products.reduce(
      (acc, product) => acc + product.price * product.unitsPurchased,
      0
    );
    setTotalPrice(total);
  }, []);

  return (
    <PaginaBase>
      <Row className="row-content-shopping-cart mx-auto">
        <Col md={9} className="mb-5 ">
          <Row className="g-5 scrollable">
            {products.map((product, index) => (
              <Col>
                <ProductDisplay
                  price={`${product.unitsPurchased} Unidades - ${(
                    product.price * product.unitsPurchased
                  ).toFixed(2)}`}
                  image={product.image}
                  name={product.name}
                  categorystyle={product.categorystyle}
                  category={product.category}
                  url={product.url}
                />
              </Col>
            ))}
          </Row>
        </Col>
        <Col>
          <Card className="custom-card-shopping-cart">
            <Card.Body>
              <Card.Title>Total a pagar</Card.Title>
              <Card.Text>
                <h3>${totalPrice.toFixed(2)}</h3>
              </Card.Text>
              <Button className="custom-button-shopping-cart">Comprar</Button>
            </Card.Body>
          </Card>
          <img
            src={cart_decoration}
            className="cart-decoration"
            alt="man holding house decorative"
          />
        </Col>
      </Row>
    </PaginaBase>
  );
};

export default ShoppingCart;
