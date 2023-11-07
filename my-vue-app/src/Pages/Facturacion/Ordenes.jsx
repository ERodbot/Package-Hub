import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col } from "react-bootstrap";
import './Ordenes.css';
import PaginaBase from "../General/PaginaBase/PaginaBase";

const dataObject = [
  { rowClass: "no-gutters", columns: ["No es", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
];
// Para la redireccion de pagina se puede hacer de esta forma /productDetail/0"
// Esta funcion se supone que redirige a la facturación 
function renderRows(data) {
  return data.map((row, index) => (
    <Link key={index} to={`/productDetail/${index}`} style={{ color: 'black' , textDecoration: 'none' }}>
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
      </Row>
    </Link>
  ));
}

// Esta crea el HTML de la pagina 
const OrdenesClientes = () => {
  const [searchTerm, setSearchTerm] = useState('');

  // Se encarga de busquedas en la tabla
  const filteredData = dataObject.filter(item =>
    item.columns.some(column =>
      column.toLowerCase().includes(searchTerm.toLowerCase())
    )
  );

  // Se encarga de renderizar la pagina
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