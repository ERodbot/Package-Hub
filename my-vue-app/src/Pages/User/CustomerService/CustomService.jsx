import React, { useState } from "react";
import { Container, Card, Form, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const CustomService = () => {
  const [email, setEmail] = useState("");
  const [fullName, setFullName] = useState("");
  const [orderNumber, setOrderNumber] = useState("");
  const [subject, setSubject] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    // Aquí puedes realizar acciones como enviar los datos a través de una API o realizar validaciones.
    console.log("Datos enviados:", { email, fullName, orderNumber, subject });
  };

  return (
    <PaginaBase>
      <Container className="d-flex justify-content-center align-items-center custom-main-container">
        <Card>
          <Card.Body>
            <h3>Contacto</h3>
            <Form onSubmit={handleSubmit}>
              <Form.Group className="mb-3">
                <Form.Label>Correo</Form.Label>
                <Form.Control
                  type="email"
                  placeholder="Correo electrónico"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </Form.Group>

              <Form.Group className="mb-3">
                <Form.Label>Nombre Completo</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Nombre completo"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                />
              </Form.Group>

              <Form.Group className="mb-3">
                <Form.Label>Número de Pedido (Opcional)</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Número de Pedido"
                  value={orderNumber}
                  onChange={(e) => setOrderNumber(e.target.value)}
                />
              </Form.Group>

              <Form.Group className="mb-3">
                <Form.Label>Asunto</Form.Label>
                <Form.Control
                  as="textarea"
                  placeholder="Asunto"
                  value={subject}
                  onChange={(e) => setSubject(e.target.value)}
                />
              </Form.Group>

              <Button type="submit">Enviar</Button>
            </Form>
          </Card.Body>
        </Card>
      </Container>
    </PaginaBase>
  );
};

export default CustomService;
