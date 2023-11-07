import ProductDisplay from "../ProductDisplay/ProductDisplay";
import PaginaBase from "../../Pages/General/PaginaBase/PaginaBase";
import { Col, Container, Row } from "react-bootstrap";
import React, { useState, useEffect } from "react";
import productsData from "./productsData";

/*Css*/
import "./Products.css";

const Products = ({ category, url }) => {
  // Use useState to store the product data
  const [products, setProducts] = useState(productsData);

  useEffect(() => {
    setProducts(productsData);
  }, [productsData]);

  return (
    <Container className="custom-container">
      <Row className="g-5 ">
        {products.map((product, index, ul) => (
          <Col key={index} className="g-4">
            <ProductDisplay
              price={product.price}
              name={product.name}
              image={product.image}
              categorystyle={category}
              category={category}
              url={url}
            />
          </Col>
        ))}
      </Row>
    </Container>
  );
};

export default Products;
