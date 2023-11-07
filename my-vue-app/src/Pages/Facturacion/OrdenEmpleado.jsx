import React from "react";
import { Container, Row, Col, OverlayTrigger, Popover  } from "react-bootstrap";
import './Ordenes.css';
import PaginaBase from "../General/PaginaBase/PaginaBase";

// Elementos que se mostraran en la tabla
const dataObject = [
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
  { rowClass: "no-gutters", columns: ["1 of 3", "2 of 3", "3 of 3"], popoverContent: { Etiqueta1: "Valor1", Etiqueta2: "Valor2" }},
];
// Funcion que renderiza el contenido del popover
const renderPopover = (labelsAndValues) => (
  <Popover id="button-popover" className="popOver-content">
    {Object.entries(labelsAndValues).map(([label, value], index) => (
      <p key={index}>
        <strong>{label}:</strong> {value}
      </p>
    ))}
  </Popover>
);

// Función que renderiza las filas de la tabla
const renderRows = (data) => {
  return data.map((row, index) => (
    <OverlayTrigger
      key={index}
      placement="right"
      delay={{ show: 250, hide: 400 }}
      overlay={renderPopover({ Etiqueta1: "Valor1", Etiqueta2: "Valor2" })}  // Puedes pasar las etiquetas y valores específicos aquí
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

// Función que renderiza la página
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