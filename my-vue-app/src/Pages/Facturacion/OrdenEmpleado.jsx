import React from "react";
import { Container, Row, Col, OverlayTrigger, Popover  } from "react-bootstrap";
import './Ordenes.css';
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

const renderPopover = () => (
  <Popover id="button-popover" className="popOver-content">
    Contenido del Popover
  </Popover>
);

const renderRows = (data) => {
  return data.map((row, index) => (
    <OverlayTrigger
      key={index}
      placement="right"
      delay={{ show: 250, hide: 400 }}
      overlay={renderPopover}
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