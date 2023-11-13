import React, { useState, useEffect } from "react";
import { Card, Button, Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";

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
    setProducts(jsonData.products);
    // Calculate the total price considering the units purchased for each product
    const total = jsonData.products.reduce(
      (acc, product) => acc + product.price * product.unitsPurchased,
      0
    );
    setTotalPrice(total);
  }, []);

  const deleteElement = (productName) => {
    // Find the product with the given name
    const selectedProduct = products.find(
      (product) => product.name === productName
    );

    if (selectedProduct) {
      const updatedProducts = products.map((product) =>
        product.name === productName
          ? {
              ...product,
              unitsPurchased: Math.max(product.unitsPurchased - 1, 0),
            }
          : product
      );

      // Filter out products with quantity 0
      const filteredProducts = updatedProducts.filter(
        (product) => product.unitsPurchased > 0
      );

      // Calculate the total price based on the updated products
      const total = filteredProducts.reduce(
        (acc, product) => acc + product.price * product.unitsPurchased,
        0
      );

      // Update the state with the updated products and total price
      setProducts(filteredProducts);
      setTotalPrice(total);
    }
  };

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
                <Button
                  className="custom-button-shopping-cart-delete my-3 mx-5"
                  onClick={() => deleteElement(product.name)}
                >
                  Eliminar
                </Button>
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
              {totalPrice > 0 ? (
                <Link to="/Buying">
                  <Button className="custom-button-shopping-cart">
                    Comprar
                  </Button>
                </Link>
              ) : (
                <p>Sin productos</p>
              )}
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
