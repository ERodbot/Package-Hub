import ProductDisplay from "../../../Compoments/ProductDisplay/ProductDisplay";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import { Col, Container, Row } from "react-bootstrap";
import React, { useState, useEffect } from "react";
import productsData from "./productsData";

/*Css*/
import "./Products.css";

const productType = Object.freeze({
  SNACKS: "Snacks",
  SKATE: "Skate",
  CLOTHES: "Ropa",
  DRINKS: "Bebidas",
});

const Products = ({ category }) => {
  // Use useState to store the product data
  const [products, setProducts] = useState(productsData);

  useEffect(() => {
    setProducts(productsData);
  }, [productsData]);

  return (
    <PaginaBase className="background">
      <Container id="top-8">
        <Container>
          <Row className="g-5">
            {products.map((product, index) => (
              <Col key={index} className="g-1">
                <ProductDisplay
                  price={product.price}
                  name={product.name}
                  image={product.image}
                  categorystyle={product.category}
                  category={product.category}
                />
              </Col>
            ))}
          </Row>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default Products;
