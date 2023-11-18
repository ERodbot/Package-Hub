import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col } from "react-bootstrap";
import "./FindEmployee.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const dataObject = [
  {columns: ["Nombre", "Rol", "Gerenteee" ,"Ventas", "Pais"] },
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

const FindEmployee = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [filteredData, setFilteredData] = useState(dataObject);

  const handleSearchClick = () => {
    if (searchTerm.trim() === '') {
      // Si la búsqueda está vacía, muestra todos los datos
      setFilteredData(dataObject);
    } else {
      // Si hay una búsqueda, filtra los datos
      const newFilteredData = dataObject.filter(item =>
        item.columns.some(column =>
          column.toLowerCase() === searchTerm.toLowerCase()
        )
      );
      setFilteredData(newFilteredData);
    }
  };

  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Busqueda Empleado</p>
          <div className="search-container">
            <input
              type="text"
              placeholder="Buscar órdenes..."
              className="searchBar"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
            <button className="searchButton" onClick={handleSearchClick}>
              Buscar
            </button>
          </div>
          <div className="vertical-scroll-container">
            {renderRows(filteredData)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default FindEmployee;
