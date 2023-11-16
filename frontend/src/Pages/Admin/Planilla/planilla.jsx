import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./planilla.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["Name", "LastName ","department","employeeRole",  "Country ","startDate","EndDate", "GrossSalary","NetSalary","Reduction","Percentage"]},
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "department","employeeRole", "Country", "startDate","EndDate", "GrossSalary", "NetSalary", "Reduction", "Percentage"] },
];

const secciones = [
  { label: "Fecha inicio", placeholder: "AAAA-MM-DD", values: ["Uno", "Two", "Three"] },
  { label: "Fecha fin", placeholder: "AAAA-MM-DD", values: ["A", "B", "C"] }
];

const useBuscarProductos = () => {
  const [filtro, setFiltro] = useState({
    "Fecha inicio": "",
    "Fecha fin": "",
  });

  const handleFiltroChange = (seccion, value) => {
    setFiltro((prevFiltro) => ({ ...prevFiltro, [seccion]: value }));
  };

  const handleBuscarClick = () => {
    // Lógica para buscar productos con los filtros seleccionados
    console.log("Buscar productos con filtro:", filtro);
    // Aca se puede acceder al array o se puede ver en la termianl
  };

  return { filtro, handleFiltroChange, handleBuscarClick };
};

// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"
function renderRows(data) {
  return data.map((row, index) => (
    
      <Row className={index % 2 === 0 ? "even-row" : "odd-row"}>
        <Col className="columnaOrden" data-index={index}>
          {row.columns[0]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[1]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[2]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[3]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[4]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[5]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[6]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[7]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[8]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[9]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[10]}
        </Col>
      </Row>
  ));
}

// Creates the HTML of the page
const Planilla = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const { filtro, handleFiltroChange, handleBuscarClick } = useBuscarProductos();

  // Does the search bar work
  const filteredData = dataObject.filter(item =>
    item.columns.some(column =>
      column.toLowerCase().includes(searchTerm.toLowerCase())
    )
  );

  // Renders the page
  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Registro de Planilla</p>
          <input
            type="text"
            placeholder="Buscar en planilla..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        
        <Form className="contenedorFormulario">
              {secciones.map((seccion, index) => (
                <div key={index} className="labelWrapper">
                  <div className="labelContainer">
                    <label className="label">{seccion.label}:</label>
                  </div>
                  <input
                    type="text"  // Cambia a input
                    className='contenedorFormularioProdu'
                    placeholder={seccion.placeholder}
                    onChange={(e) => handleFiltroChange(seccion.label, e.target.value)}
                    value={filtro[seccion.label]}
                  />
                </div>
              ))}
              <Form.Group as={Row} className="mb-3">
                <Col sm={{ span: 10, offset: 2 }}>
                    <Button className="buscarBtn" type="button" onClick={handleBuscarClick}>
                      Buscar
                    </Button>
                </Col>
              </Form.Group>
            </Form>

          <div className="vertical-scroll-container">
            {renderRows(filteredData)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default Planilla;