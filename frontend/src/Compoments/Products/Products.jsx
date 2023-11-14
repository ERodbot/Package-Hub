/* Products Component */

import ProductDisplay from "../ProductDisplay/ProductDisplay";
import { Col, Container, Row } from "react-bootstrap";
import { useState, useEffect } from "react";

/* CSS Styles */
import "./Products.css";

const Products = ({
  // Props for the product category and data
  category,
  productsData,
}) => {
  // Use useState to manage the product data
  const [products, setProducts] = useState([]);

  useEffect(() => {
    // Update the state with the provided productsData
    // Only update if productsData is not empty
    if (productsData && productsData.length > 0) {
      setProducts(productsData);
    }
    // Log the products data for debugging
    console.log("products data: ", productsData);
  }, [productsData]);

  return (
    /* Container to display products in a grid layout */
    <Container className="custom-container">
      {/* Row to organize products in a grid */}
      <Row className="g-5 ">
        {products.map((product, index) => (
          /* Individual product display within a column */
          <Col key={index} className="g-4">
            <ProductDisplay
              // Pass product details as props to ProductDisplay component
              price={product.price}
              name={product.name}
              image={product.image}
              categorystyle={category}
              category={category}
              url={`/productDetail${product.name}`}
            />
          </Col>
        ))}
      </Row>
    </Container>
  );
};

export default Products;
