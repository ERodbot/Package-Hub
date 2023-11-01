import React, { useState } from "react";
import { Container, Row, Col, Form, Button, Card } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";
function App() {
  const [formData, setFormData] = useState({
    username: "",
    password: "",
  });

  const [buttonColor, setButtonColor] = useState("#f58071"); // Color inicial

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

  const changeButtonColor = () => {
    // Cambia el color del botón al azar (puedes ajustarlo según tus necesidades)
    const randomColor = `#${Math.floor(Math.random() * 16777215).toString(16)}`;
    setButtonColor(randomColor);
  };

  return (
    <Container fluid>
      <Row className="h-100">
        <Col md={4} className="d-flex align-items-center">
          <Card className="mx-auto p-4">
             {/* <img
                    src={PSWLogo} // Reemplaza "ruta_de_tu_imagen" con la ruta de tu imagen
                    alt="Icono de usuario"
                    className="icono-usuario"
            /> */}
            <h1 className="title text-center">Inicio de Sesión</h1>
            <p className="subtitle text-center">Cliente</p>
            <Form onSubmit={handleSubmit}>
              <Form.Group className="mb-3">
                <Form.Label>
                Username</Form.Label>
                <Form.Control
                
                  type="text"
                  name="username"
                  placeholder="Enter your username"
                  value={formData.username}
                  onChange={handleInputChange}
                />
                <div className="input-group-prepend">
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
                style={{ backgroundColor: buttonColor }}
                onClick={changeButtonColor}
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
