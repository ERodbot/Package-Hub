import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { Container, Row, Col } from "react-bootstrap";
import "./Branches.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// Elements that will be shown in the table
const dataObject = [
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "gerente"],
  },
  {
    rowClass: "no-gutters",
    columns: ["Pais", "sucursal", "Description", "moneda", "odd"],
  },
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
          {`${titles[columnIndex]}:  `}
          {key}
        </Col>
      ))}
    </Row>
  ));
}

// Creates the HTML of the page
const Branches = () => {
  const [searchTerm, setSearchTerm] = useState("");
  const [filterdItems, setFilterdItems] = useState([]);

  useEffect(() => {
    setFilterdItems(dataObject);
  }, []);

  useEffect(() => {
    const filteredData = dataObject.filter((item) =>
      item.columns.some((column) =>
        column.toLowerCase().includes(searchTerm.toLowerCase())
      )
    );
    setFilterdItems(filteredData);
  }, [searchTerm]);

  // Does the search bar work

  // Renders the page
  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Branches</p>
          <input
            type="text"
            placeholder="Buscar branch..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
          <div className="vertical-scroll-container">
            {renderRows(filterdItems)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default Branches;
