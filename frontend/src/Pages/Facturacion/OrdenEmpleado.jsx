import React from "react";
import { Container, Row, Col, OverlayTrigger, Popover  } from "react-bootstrap";
import './Ordenes.css';
import PaginaBase from "../General/PaginaBase/PaginaBase";

// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["Orden #1727471", "Fecha emisión", "Estado: Pendiente"] },
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
// Funtion to redirect to the billing page
const renderPopover = (labelsAndValues) => (
  <Popover id="button-popover" className="popOver-content">
    {Object.entries(labelsAndValues).map(([label, value], index) => (
      <p key={index}>
        <strong>{label}:</strong> {value}
      </p>
    ))}
  </Popover>
);

// Function that renders the page for rows
const renderRows = (data) => {
  return data.map((row, index) => (
    <OverlayTrigger
      key={index}
      placement="right"
      delay={{ show: 250, hide: 400 }}
      overlay={renderPopover({ Etiqueta1: "Valor1", Etiqueta2: "Valor2" })}  
      className="overlay-trigger"
    >
      <Row className={index % 2 === 0 ? "even-row" : "odd-row"}>
        {row.columns.map((column, colIndex) => (
          <Col key={colIndex} className="columnaOrden">
            {column}
          </Col>
        ))}
      </Row>
    </OverlayTrigger>
  ));
};

// Function that renders the page
const OrdenesEmpleado = () => (
  <PaginaBase>
    <Container fluid className="mainPage">
      <p className="title2">Registro de Ordenes</p>
      <div className="vertical-scroll-container">
        {renderRows(dataObject)}
      </div>
    </Container>
  </PaginaBase>
);

export default OrdenesEmpleado;