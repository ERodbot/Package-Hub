import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./planilla.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["Name", "LastNam","department","employeeRole",  "Country ","startDate","EndDate", "GrossSalary","NetSalary","Reduction","Percentage"]},
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
const Planilla = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [filterdItems, setFilterdItems] = useState([]);
  const { filtro, handleFiltroChange, handleBuscarClick } = useBuscarProductos();

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
            {renderRows(filterdItems)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default Planilla;