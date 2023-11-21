import React, { useState, useEffect } from "react";
import { Card, Form, Row, Col, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import "./BranchesAdministration.css";

const BranchesAdministration = () => {
  const [formData, setFormData] = useState({
    description: "",
    startTime: "",
    endTime: "",
    location: "",
    country: "",
    currency: "",
    manager: "",
  });
  const [countryOptions, setCountryOptions] = useState([]);
  const [currencyOptions, setCurrencyOptions] = useState([]);
  const [managerOptions, setManagerOptions] = useState([]);

  useEffect(() => {
    // Cargar las opciones para los dropdowns desde los estados
    setCountryOptions(["Estados Unidos", "España", "Suiza", "Japón"]);
    setCurrencyOptions(["Dólar", "Euro", "Libra", "Yen"]);
    setManagerOptions(["juanca12", "cristoferrobin"]);
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSaveChanges = () => {
    console.log("Datos del formulario:", formData);
  };

  return (
    <PaginaBase>
      <Card className="branchesCard">
        <Card.Body>
          <Card.Title>Crear Evento</Card.Title>
          <Form>
            <Form.Group controlId="description">
              <Form.Label>Descripción</Form.Label>
              <Form.Control
                type="text"
                placeholder="Ingrese la descripción"
                name="description"
                value={formData.description}
                onChange={handleChange}
                className="m-3"
              />
            </Form.Group>

            <Row>
              <Col>
                <Form.Group controlId="startTime">
                  <Form.Label>Hora de inicio</Form.Label>
                  <Form.Control
                    type="time"
                    name="startTime"
                    value={formData.startTime}
                    onChange={handleChange}
                    className="m-3"
                  />
                </Form.Group>
              </Col>
              <Col>
                <Form.Group controlId="endTime">
                  <Form.Label>Hora de fin</Form.Label>
                  <Form.Control
                    type="time"
                    name="endTime"
                    value={formData.endTime}
                    onChange={handleChange}
                    className="m-3"
                  />
                </Form.Group>
              </Col>
            </Row>

            <Form.Group controlId="location">
              <Form.Label>Ubicación</Form.Label>
              <Form.Control
                type="text"
                placeholder="Ingrese la ubicación"
                name="location"
                value={formData.location}
                onChange={handleChange}
                className="m-3"
              />
            </Form.Group>

            <Form.Group controlId="country">
              <Form.Label>País</Form.Label>
              <Form.Control
                as="select"
                name="country"
                value={formData.country}
                onChange={handleChange}
                className="m-3"
              >
                {/* Opciones para el dropdown de países */}
                {countryOptions.map((country, index) => (
                  <option key={index}>{country}</option>
                ))}
              </Form.Control>
            </Form.Group>

            <Form.Group controlId="currency">
              <Form.Label>Moneda</Form.Label>
              <Form.Control
                as="select"
                name="currency"
                value={formData.currency}
                onChange={handleChange}
                className="m-3"
              >
                {/* Opciones para el dropdown de monedas */}
                {currencyOptions.map((currency, index) => (
                  <option key={index}>{currency}</option>
                ))}
              </Form.Control>
            </Form.Group>

            <Form.Group controlId="manager">
              <Form.Label>Gerente</Form.Label>
              <Form.Control
                as="select"
                name="manager"
                value={formData.manager}
                onChange={handleChange}
                className="m-3"
              >
                {/* Opciones para el dropdown de gerentes */}
                {managerOptions.map((manager, index) => (
                  <option key={index}>{manager}</option>
                ))}
              </Form.Control>
            </Form.Group>

            <Button
              variant="primary"
              type="button"
              onClick={handleSaveChanges}
              className="m-3"
            >
              Guardar Cambios
            </Button>
          </Form>
        </Card.Body>
      </Card>
    </PaginaBase>
  );
};

export default BranchesAdministration;
