import React, { useState } from "react";
import { Card, Dropdown, Form, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import "./SalesInfoRequest.css";

const SalesFormReportConsult = () => {
  const [selectedProduct, setSelectedProduct] = useState("");
  const [selectedProductType, setSelectedProductType] = useState("");
  const [selectedCountry, setSelectedCountry] = useState("");
  const [selectedWarehouse, setSelectedWarehouse] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");

  // Valores para los dropdowns (puedes reemplazarlos con tus propios valores)
  const productOptions = ["Product 1", "Product 2", "Product 3"];
  const productTypeOptions = ["Type 1", "Type 2", "Type 3"];
  const countryOptions = ["Country 1", "Country 2", "Country 3"];
  const warehouseOptions = ["Warehouse 1", "Warehouse 2", "Warehouse 3"];

  const handleProductSelect = (product) => {
    setSelectedProduct(product);
  };

  const handleProductTypeSelect = (type) => {
    setSelectedProductType(type);
  };

  const handleCountrySelect = (country) => {
    setSelectedCountry(country);
  };

  const handleWarehouseSelect = (warehouse) => {
    setSelectedWarehouse(warehouse);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Realizar acciones con los valores seleccionados
    console.log("Producto:", selectedProduct);
    console.log("Tipo de Producto:", selectedProductType);
    console.log("País:", selectedCountry);
    console.log("Bodega:", selectedWarehouse);
    console.log("Fecha de Inicio:", startDate);
    console.log("Fecha de Fin:", endDate);
  };

  return (
    <PaginaBase>
      <Card className="sales-card-form-report-consult ">
        <Card.Body>
          <h3>Consulta de Ventas</h3>
          <Form onSubmit={handleSubmit} className="align-content-center">
            <Dropdown className="m-5 w-100">
              <Dropdown.Toggle variant="light" id="product-dropdown">
                {selectedProduct || "Seleccionar Producto"}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {productOptions.map((product) => (
                  <Dropdown.Item
                    key={product}
                    onSelect={() => handleProductSelect(product)}
                  >
                    {product}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>

            <Dropdown className="m-5 w-100">
              <Dropdown.Toggle variant="light" id="product-type-dropdown">
                {selectedProductType || "Seleccionar Tipo de Producto"}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {productTypeOptions.map((type) => (
                  <Dropdown.Item
                    key={type}
                    onSelect={() => handleProductTypeSelect(type)}
                  >
                    {type}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>

            <Dropdown className="m-5 w-100">
              <Dropdown.Toggle variant="light" id="country-dropdown">
                {selectedCountry || "Seleccionar País"}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {countryOptions.map((country) => (
                  <Dropdown.Item
                    key={country}
                    onSelect={() => handleCountrySelect(country)}
                  >
                    {country}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>

            <Dropdown className="m-5 w-100">
              <Dropdown.Toggle variant="light" id="warehouse-dropdown">
                {selectedWarehouse || "Seleccionar Bodega"}
              </Dropdown.Toggle>
              <Dropdown.Menu>
                {warehouseOptions.map((warehouse) => (
                  <Dropdown.Item
                    key={warehouse}
                    onSelect={() => handleWarehouseSelect(warehouse)}
                  >
                    {warehouse}
                  </Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </Dropdown>

            <Form.Group controlId="startDate">
              <Form.Label>Fecha de Inicio</Form.Label>
              <Form.Control
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
              />
            </Form.Group>

            <Form.Group controlId="endDate">
              <Form.Label>Fecha de Fin</Form.Label>
              <Form.Control
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
              />
            </Form.Group>

            <Button className="mt-4" variant="primary" type="submit">
              Consultar
            </Button>
          </Form>
        </Card.Body>
      </Card>
    </PaginaBase>
  );
};

export default SalesFormReportConsult;
