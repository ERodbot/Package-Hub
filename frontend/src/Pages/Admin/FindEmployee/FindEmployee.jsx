import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col } from "react-bootstrap";
import "./FindEmployee.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// The row class and the information that goes in the columns.
const dataObject = [
  {columns: ["Nombre", "Rol", "Departamento" ,"Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
  {columns: ["Nombre", "Rol", "Departamento", "Ventas", "Pais"] },
];
// For the redirection of the page can be donde like this: /productDetail/0"
// Function has to be changed to redirect to the employee detail page
function renderRows(data) {
  return data.map((row, index) => (
    <Link key={index} to={`/employeeDetail/${index}`} style={{ color: 'black' , textDecoration: 'none' }}>
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
      </Row>
    </Link>
  ));
}
// Creats the HTML of the page
const FindEmployee = () => {
  const [searchTerm, setSearchTerm] = useState('');

  // Makes the search bar work
  const filteredData = dataObject.filter(item =>
    item.columns.some(column =>
      column.toLowerCase().includes(searchTerm.toLowerCase())
    )
  );

  // Se renders the page
  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Busqueda Empleado</p>
          <input
            type="text"
            placeholder="Buscar órdenes..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
          <div className="vertical-scroll-container">
            {renderRows(filteredData)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default FindEmployee;