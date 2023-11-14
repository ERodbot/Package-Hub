/* ProductDisplay Component */

import React from "react";
import { Card } from "react-bootstrap";

import "./ProductDisplay.css";

const ProductDisplay = ({
  // Props for displaying product information
  price,
  image,
  name,
  categorystyle,
  category,
  url,
}) => {
  // Function to handle redirection to the specified URL
  const handleRedirection = (url) => {
    window.open(url);
  };

  return (
    /* Card component for displaying product details */
    <Card id="card-style" onClick={() => handleRedirection(url)}>
      <div id="image-container">
        {/* Container for product image and title */}
        <div className="title-container">
          {/* Display product title */}
          <Card.Title>
            <h4>{name}</h4>
          </Card.Title>
        </div>
        {/* Display product image */}
        <Card.Img src={image} id="custom-image" />
      </div>
      {/* Product details and category */}
      <Card.Body className="custom-card-body">
        {/* Container for displaying product price */}
        <div className={`price-style ${categorystyle}`}>
          <p className="price-style-p">{price}</p>
        </div>

        {/* Display product category */}
        <div className={`category-style ${categorystyle}`}>{category}</div>
      </Card.Body>
    </Card>
  );
};

export default ProductDisplay;
