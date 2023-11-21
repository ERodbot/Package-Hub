// Import necessary components and styles
import React, { useState } from "react";
import { Container, Card, Form, Button, Row, Col } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// CustomService functional component
const CustomService = () => {
  // State variables to manage user inputs
  const [email, setEmail] = useState("");
  const [fullName, setFullName] = useState("");
  const [orderNumber, setOrderNumber] = useState("");
  const [subject, setSubject] = useState("");
  const [date, setDate] = useState(""); // New state for date
  const [consultationType, setConsultationType] = useState(""); // New state for consultation type

  // Function to handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    // Here you can perform actions such as sending data through an API or conducting validations.
    console.log("Datos enviados:", {
      email,
      fullName,
      orderNumber,
      subject,
      date,
      consultationType,
    });
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
              <Row>
                {/* First Column */}
                <Col>
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
                </Col>

                {/* Second Column */}
                <Col>
                  {/* Date input field */}
                  <Form.Group className="mb-3">
                    <Form.Label>Fecha</Form.Label>
                    <Form.Control
                      type="date"
                      value={date}
                      onChange={(e) => setDate(e.target.value)}
                    />
                  </Form.Group>

                  {/* Consultation Type dropdown */}
                  <Form.Group className="mb-3">
                    <Form.Label>Tipo de Consulta</Form.Label>
                    <Form.Control
                      as="select"
                      value={consultationType}
                      onChange={(e) => setConsultationType(e.target.value)}
                    >
                      <option value="">Seleccionar tipo</option>
                      <option value="General">General</option>
                      <option value="Product Inquiry">
                        Consulta de Producto
                      </option>
                      {/* Add more options as needed */}
                    </Form.Control>
                  </Form.Group>
                </Col>
              </Row>

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
