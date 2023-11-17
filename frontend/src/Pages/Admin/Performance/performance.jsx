import React, { useEffect, useState } from 'react';
import React, { useState , useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./performance.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import { getCountry } from '../../../api/auth';
import { getRoles } from '../../../api/reporting';


// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"]},
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"]},
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"]},
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
  { rowClass: "no-gutters", columns: ["Name", "LastName", "rating", "department", "employeeRole", "country", "state", "city", "adress"] },
];

const secciones2 = [
  {label: "Fecha inicio", placeholder: "AAAA-MM-DD" },
  {label: "Fecha fin", placeholder: "AAAA-MM-DD"}
];




const useBuscarProductos = () => {
  const [filtro, setFiltro] = useState({
    "Fecha inicio": null,
    "Fecha fin": null,
    "Pais": null,
    "Rol": null
  });

  const handleFiltroChange = (seccion, value) => {
    setFiltro((prevFiltro) => ({ ...prevFiltro, [seccion]: value }));
  };

  const handleBuscarClick = () => {
    if (filtro["Fecha inicio"] == "") {
      filtro["Fecha inicio"] = null;
    }
    if (filtro["Fecha fin"] == "") {
      filtro["Fecha fin"] = null;
    }
    if (filtro["Pais"] == "Selecciona el país") {
      filtro["Pais"] = null;
    }
    if (filtro["Rol"] == "Selecciona el rol") {
      filtro["Rol"] = null;
    }
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
const PerformanceReport = () => {

  const [countries, setCountries] = useState([]);
  const [roles, setRoles] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterdItems, setFilterdItems] = useState([]);
  const { filtro, handleFiltroChange, handleBuscarClick } = useBuscarProductos();


  const secciones = [
  {label: "Pais", placeholder: "Selecciona el país", values: countries},
  {label: "Rol", placeholder: "Selecciona el rol", values: roles }
  ];

  useEffect(() => {
    // Call the endpoint to get all the roles and all the countries
    const fetchCountry = async () => {
      try {
        const response = await getCountry();
        setCountries(response.data);
      } catch (error) {
        console.log(error);
      }
    };
  
    const fetchRole = async () => {
      try {
        const roleResponse = await getRoles();
        setRoles(roleResponse.data);
      } catch (error) {
        console.log(error);
      }
    }
    fetchCountry();
    fetchRole();
  }, []);




  
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
      <Container className="background7">
        <Container fluid className="mainPage">
          <p className="title2">Registro performance</p>
          <input
            type="text"
            placeholder="Buscar en planilla..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        
        <Form className="contenedorFormulario">
          {secciones2.map((seccion, index) => (
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
          {secciones.map((seccion, index) => (
            <div key={index} className="labelWrapper">
              <div className="labelContainer">
                <label className="label">{seccion.label}:</label>
              </div>
              <Form.Select
                aria-label="Default select example"
                className='contenedorFormularioProdu'
                onChange={(e) => handleFiltroChange(seccion.label, e.target.value)}
                value={filtro[seccion.label]}
              >
                <option>{seccion.placeholder}</option>
                {seccion.values.map((value, valueIndex) => (
                  <option key={valueIndex} value={value}>
                    {value}
                  </option>
                ))}
              </Form.Select>

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

export default PerformanceReport;