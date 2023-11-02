import React from "react";
import { Card } from "react-bootstrap";

import "./ProductDisplay.css";

const ProductDisplay = ({ price, image, name, categorystyle, category }) => {
  return (
    <Card id="card-style">
      <div id="image-container">
        <div className="title-container">
          <Card.Title>
            <h4>{name}</h4>
          </Card.Title>
        </div>
        <Card.Img src={image} id="custom-image" />
      </div>
      <Card.Body className="custom-card-body">
        <div className={`price-style ${categorystyle}`}>
          <p>{price}</p>
        </div>
        <div className={`category-style ${categorystyle}`}>{category}</div>
      </Card.Body>
    </Card>
  );
};

export default ProductDisplay;
