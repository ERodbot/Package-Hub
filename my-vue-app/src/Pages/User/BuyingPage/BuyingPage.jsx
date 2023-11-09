import React, { useState } from "react";
import { Container, Card, Form, Button, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";
import "./BuyingPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const BuyingPage = () => {
  const [address, setAddress] = useState("");
  const [cardNumber, setCardNumber] = useState("");
  const [cardHolder, setCardHolder] = useState("");
  const [expiration, setExpiration] = useState("");
  const [cvc, setCVC] = useState("");
  const price = 100.0;

  return (
    <PaginaBase>
      <Container className="custom-main-container">
        <Row>
          <Col md={9}>
            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Dirección de envío</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <FormGroup label="Dirección">
                    <FormControl
                      type="text"
                      placeholder="Ingrese su dirección"
                      value={address}
                      onChange={(e) => setAddress(e.target.value)}
                    />
                  </FormGroup>
                </Form>
              </Card.Body>
            </Card>

            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Datos de la Tarjeta</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <FormGroup label="Número de tarjeta">
                    <FormControl
                      type="text"
                      placeholder="Ingrese el número de tarjeta"
                      value={cardNumber}
                      onChange={(e) => setCardNumber(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Nombre del titular de la tarjeta">
                    <FormControl
                      type="text"
                      placeholder="Ingrese el nombre del titular"
                      value={cardHolder}
                      onChange={(e) => setCardHolder(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Fecha de vencimiento">
                    <FormControl
                      type="text"
                      placeholder="MM/AA"
                      value={expiration}
                      onChange={(e) => setExpiration(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Código de seguridad">
                    <FormControl
                      type="text"
                      placeholder="CVC"
                      value={cvc}
                      onChange={(e) => setCVC(e.target.value)}
                    />
                  </FormGroup>
                </Form>
              </Card.Body>
            </Card>
          </Col>

          <Col md={3} className="mt-3">
            <Card className="custom-total-card">
              <Card.Body>
                <h3>Total a pagar</h3>
                <p className="custom-text-price">${price.toFixed(2)}</p>
                <Link to="/main">
                  <Button className="custom-button">Continuar Compra</Button>
                </Link>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Container>
    </PaginaBase>
  );
};

const FormGroup = ({ label, children }) => (
  <Form.Group>
    <Form.Label>{label}</Form.Label>
    {children}
  </Form.Group>
);

const FormControl = (props) => <Form.Control {...props} />;

export default BuyingPage;
