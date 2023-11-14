// Import necessary components and styles
import React, { useState } from "react";
import {
  Container,
  Card,
  Form,
  FormGroup,
  FormControl,
  Button,
  Row,
  Col,
} from "react-bootstrap";
import { Link } from "react-router-dom";
import "./BuyingPage.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// BuyingPage functional component
const BuyingPage = () => {
  // State variables to manage user inputs
  const [address, setAddress] = useState("");
  const [cardNumber, setCardNumber] = useState("");
  const [cardHolder, setCardHolder] = useState("");
  const [expiration, setExpiration] = useState("");
  const [cvc, setCVC] = useState("");
  const [price, setPrice] = useState(0);

  // JSX structure for the BuyingPage
  return (
    <PaginaBase>
      <Container className="custom-main-container">
        <Row>
          <Col md={9}>
            {/* Shipping Address Section */}
            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Dirección de envío</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <FormGroup label="Dirección">
                    {/* Input field for the user to enter their address */}
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

            {/* Card Information Section */}
            <Card className="custom-card">
              <Card.Header className="card-header">
                <h4>Datos de la Tarjeta</h4>
              </Card.Header>
              <Card.Body>
                <Form>
                  <FormGroup label="Número de tarjeta">
                    {/* Input field for the user to enter their card number */}
                    <FormControl
                      type="text"
                      placeholder="Ingrese el número de tarjeta"
                      value={cardNumber}
                      onChange={(e) => setCardNumber(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Nombre del titular de la tarjeta">
                    {/* Input field for the user to enter the cardholder name */}
                    <FormControl
                      type="text"
                      placeholder="Ingrese el nombre del titular"
                      value={cardHolder}
                      onChange={(e) => setCardHolder(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Fecha de vencimiento">
                    {/* Input field for the user to enter the card expiration date */}
                    <FormControl
                      type="text"
                      placeholder="MM/AA"
                      value={expiration}
                      onChange={(e) => setExpiration(e.target.value)}
                    />
                  </FormGroup>
                  <FormGroup label="Código de seguridad">
                    {/* Input field for the user to enter the card security code */}
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

          {/* Total Amount and Continue Purchase Section */}
          <Col md={3} className="mt-3">
            <Card className="custom-total-card">
              <Card.Body>
                <h3>Total a pagar</h3>
                {/* Display the total amount to be paid */}
                <p className="custom-text-price">${price.toFixed(2)}</p>
                {/* Button to continue with the purchase */}
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

export default BuyingPage;
