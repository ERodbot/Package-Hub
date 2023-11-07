import React from "react";
import { Container, Row, Col } from "react-bootstrap";
import { Link } from "react-router-dom";

import "./Ordenes.css";
import PaginaBase from "../General/PaginaBase/PaginaBase";

const dataObject = [
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
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"] },
];

function renderRows(data) {
  return data.map((row, index) => (
    <Row key={index} className={index % 2 === 0 ? "even-row" : "odd-row"}>
      {row.columns.map((column, colIndex) => (
        <Col key={colIndex} className="columnaOrden">
          {column}
        </Col>
      ))}
    </Row>
  ));
}

const OrdenesClientes = () => {
  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage ">
          <p className="title2">Registro de Ordenes</p>
          <div className="vertical-scroll-container">
            {renderRows(dataObject)};
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default OrdenesClientes;
