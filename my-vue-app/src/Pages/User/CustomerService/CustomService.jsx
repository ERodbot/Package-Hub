// Import necessary components and styles
import React, { useState } from "react";
import { Container, Card, Form, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// CustomService functional component
const CustomService = () => {
  // State variables to manage user inputs
  const [email, setEmail] = useState("");
  const [fullName, setFullName] = useState("");
  const [orderNumber, setOrderNumber] = useState("");
  const [subject, setSubject] = useState("");

  // Function to handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    // Here you can perform actions such as sending data through an API or conducting validations.
    console.log("Datos enviados:", { email, fullName, orderNumber, subject });
  };

  // JSX structure for the CustomService component
  return (
    <PaginaBase>
      <Container className="d-flex justify-content-center align-items-center custom-main-container">
        <Card>
          <Card.Body>
            <h3>Contacto</h3>
            {/* Form for user input */}
            <Form onSubmit={handleSubmit}>
              {/* Email input field */}
              <Form.Group className="mb-3">
                <Form.Label>Correo</Form.Label>
                <Form.Control
                  type="email"
                  placeholder="Correo electrónico"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </Form.Group>

              {/* Full Name input field */}
              <Form.Group className="mb-3">
                <Form.Label>Nombre Completo</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Nombre completo"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                />
              </Form.Group>

              {/* Order Number input field (optional) */}
              <Form.Group className="mb-3">
                <Form.Label>Número de Pedido (Opcional)</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Número de Pedido"
                  value={orderNumber}
                  onChange={(e) => setOrderNumber(e.target.value)}
                />
              </Form.Group>

              {/* Subject input field */}
              <Form.Group className="mb-3">
                <Form.Label>Asunto</Form.Label>
                <Form.Control
                  as="textarea"
                  placeholder="Asunto"
                  value={subject}
                  onChange={(e) => setSubject(e.target.value)}
                />
              </Form.Group>

              {/* Submit button */}
              <Button type="submit">Enviar</Button>
            </Form>
          </Card.Body>
        </Card>
      </Container>
    </PaginaBase>
  );
};

export default CustomService;
