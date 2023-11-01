import React, { useState } from "react";
import { Container, Row, Col, Form, Button, Card } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import userIcon from "../../Package-Hub/imagenes/PSWLogo.svg";

function App() {
  const [formData, setFormData] = useState({
    username: "",
    password: "",
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Aquí puedes realizar la lógica de inicio de sesión con formData
    console.log("Datos de inicio de sesión:", formData);
  };

  return (
    <Container fluid>
      <Row className="h-100">
        <Col md={4} className="d-flex align-items-center">
          <Card className="mx-auto p-4">
            <h1 className="title text-center">Inicio de Sesión</h1>
            <p className="subtitle text-center">Cliente</p>
            <Form onSubmit={handleSubmit}>
              <Form.Group className="mb-3">
                <Form.Label>Username</Form.Label>
                <Form.Control
                  type="text"
                  name="username"
                  placeholder="Enter your username"
                  value={formData.username}
                  onChange={handleInputChange}
                />
                <div className="input-group-prepend">
                  <span className="input-group-text">
                    <img src={userIcon} alt="User Icon" />
                  </span>
                </div>
              </Form.Group>
              <Form.Group className="mb-3">
                <Form.Label>Password</Form.Label>
                <Form.Control
                  type="password"
                  name="password"
                  placeholder="Enter your password"
                  value={formData.password}
                  onChange={handleInputChange}
                />
              </Form.Group>
              <Button
                variant="primary"
                type="submit"
                className="w-100 buttonT1"
              >
                Iniciar Sesión
              </Button>
            </Form>
          </Card>
        </Col>
      </Row>
    </Container>
  );
}

export default App;
