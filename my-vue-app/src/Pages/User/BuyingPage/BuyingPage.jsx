import React, { useState } from "react";
import { Container, Card, Form, Button } from "react-bootstrap";
import "./BuyingPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const BuyingPage = () => {
  // Create useState hooks for form input values
  const [address, setAddress] = useState("");
  const [cardNumber, setCardNumber] = useState("");
  const [cardHolder, setCardHolder] = useState("");
  const [expiration, setExpiration] = useState("");
  const [cvc, setCVC] = useState("");

  // Create a variable for the price
  const price = 100.0;

  return (
    <PaginaBase>
      <Container className="d-flex justify-content-center align-items-center custom-main-container">
        <Container className="sizing-container">
          <h1>{address}</h1>
          <h1>{cardNumber}</h1>
          <h1>{cardHolder}</h1>
          <h1>{expiration}</h1>
          <h1>{cvc}</h1>
          <div className="main-div">
            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Dirección de envío</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <Form.Group>
                    <Form.Label>Dirección</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="Ingrese su dirección"
                      value={address}
                      onChange={(e) => setAddress(e.target.value)}
                    />
                  </Form.Group>
                </Form>
              </Card.Body>
            </Card>

            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Datos de la Tarjeta</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <Form.Group>
                    <Form.Label>Número de tarjeta</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="Ingrese el número de tarjeta"
                      value={cardNumber}
                      onChange={(e) => setCardNumber(e.target.value)}
                    />
                  </Form.Group>
                  <Form.Group>
                    <Form.Label>Nombre del titular de la tarjeta</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="Ingrese el nombre del titular"
                      value={cardHolder}
                      onChange={(e) => setCardHolder(e.target.value)}
                    />
                  </Form.Group>
                  <Form.Group>
                    <Form.Label>Fecha de vencimiento</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="MM/AA"
                      value={expiration}
                      onChange={(e) => setExpiration(e.target.value)}
                    />
                  </Form.Group>
                  <Form.Group>
                    <Form.Label>Código de seguridad</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="CVC"
                      value={cvc}
                      onChange={(e) => setCVC(e.target.value)}
                    />
                  </Form.Group>
                </Form>
              </Card.Body>
            </Card>
          </div>

          <Card className="custom-total-card">
            <Card.Body>
              <h3>Total a pagar</h3>
              <p className="custom-text-price">${price.toFixed(2)}</p>
              <Button className="custom-button">Continuar Compra</Button>
            </Card.Body>
          </Card>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default BuyingPage;
