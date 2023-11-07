import React, { useState } from "react";
import { Card, Carousel, Container, Row, Col, Button } from "react-bootstrap";
import { Link } from "react-router-dom";

import Color from "../../../Compoments/Color/Color";
import "./ProductDitails.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import ProductCard from "../../../Compoments/ProductDetailsDisplay/ProductDetailsDisplay";

/*imagen de prueba*/
import product_img1 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img1.jpg";
import product_img2 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img2.png";

const productDetailsData = {
  marca: "Ejemplo Marca",
  descripción: "Este es un producto de ejemplo",
  material: "Plástico",
  peso: "1.5 kg",
  precio: 49.99,
  unidades: 1,
  envio: 5.0,
  fotos: [product_img1, product_img2],
  colors: ["red", "black", "yellow"],
  tipo: "snack",
};

const ProductDetails = () => {
  const [brand, setBrand] = useState(productDetailsData.marca);
  const [type, setType] = useState(productDetailsData.tipo);
  const [weight, setWeight] = useState(productDetailsData.peso);
  const [material, setMaterial] = useState(productDetailsData.material);
  const [quantity, setQuantity] = useState(productDetailsData.unidades);
  const [precioUnitario, setPrecioUnitario] = useState(
    productDetailsData.precio
  );
  const [envio, setEnvio] = useState(productDetailsData.envio);
  const [fotos, setFotos] = useState(productDetailsData.fotos);
  const [colors, setColors] = useState(productDetailsData.colors);
  const [description, setDescription] = useState(
    productDetailsData.descripción
  );
  // Calcular subtotal y total usando el estado de cantidad
  const [subtotal, setSubtotal] = useState(quantity * precioUnitario);
  const [total, setTotal] = useState(subtotal + envio);

  const updateCantidad = (newCantidad) => {
    setQuantity(newCantidad);
  };

  return (
    <PaginaBase>
      <Container>
        <Row>
          <Col md={9} className="custom-col-product-display">
            <ProductCard
              cantidad={quantity}
              setValQuantity={setQuantity}
              value={precioUnitario}
              shipping={envio}
              colors={colors}
              fotos={fotos}
              productDetailsData={{
                brand: brand,
                description: description,
                material: material,
                weight: weight,
                type: type,
              }}
              updateCantidad={updateCantidad}
              setSubtotal={setSubtotal}
              setTotal={setTotal}
            />
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
                  <Button className="m-1 w-100 custom-product-detail-button-add">
                    Agregar al carrito
                  </Button>
                  <Link to="/buying">
                    <Button className="m-1 w-100 custom-product-detail-button-buy">
                      Comprar Ahora
                    </Button>
                  </Link>
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
