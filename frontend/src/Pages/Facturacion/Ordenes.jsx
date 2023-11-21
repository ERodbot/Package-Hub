import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col } from "react-bootstrap";
import "./Ordenes.css";
import PaginaBase from "../General/PaginaBase/PaginaBase";

// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión Fecha emisión Fecha emisiónFecha emisiónFecha emisión Fecha emisión", "Estado: Pendiente"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Pendiente"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Pendiente"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Entragado"] },
];
// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"
function renderRows(data) {
  const titles = ["Pais", "sucursal", "Description", "moneda", "odd"];
  return data.map((row, index) => (
    <Row key={index} className={index % 2 === 0 ? "even-row" : "odd-row"}>
      {row.columns.map((key, columnIndex) => (
        <Col
          key={columnIndex}
          className="columnaOrden"
          data-index={columnIndex}
        >
          {index === 0 ? `${titles[columnIndex]}: ` : ''} {key}
        </Col>
      ))}
    </Row>
  ));
}

// Creates the HTML of the page
const OrdenesClientes = () => {
  const [searchTerm, setSearchTerm] = useState('');

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
          <p className="title2">Registro de Ordenes</p>
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

export default OrdenesClientes;