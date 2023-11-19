import React, { useEffect, useState } from 'react';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./salesReport.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import { getCountry } from '../../../api/auth';
import { getProducts, getCategories, getReportVentas} from '../../../api/reporting';

const secciones2 = [
  {label: "Fecha inicio", placeholder: "AAAA-MM-DD" }
];

const useBuscarProductos = () => {
  const [filtro, setFiltro] = useState({
    "Fecha inicio": null,
    "Pais": null,
    "Rol": null
  });

  const handleFiltroChange = (seccion, value) => {
    setFiltro((prevFiltro) => ({ ...prevFiltro, [seccion]: value }));
  };
  return { filtro, handleFiltroChange};
};

// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"

function renderRows(data) {
  const titles = ["Nombre", "Email", "Fecha de Orden", "nombre producto", "categoria producto", "cantidad", "preciototal"];
  return (
    <>
    {/* Header row with titles */}
    <Row className="header-row">
      {titles.map((title, index) => (
        <Col key={index} className="column-header">
          {title}
        </Col>
      ))}
    </Row>

    {/* Data rows */}
    {data.map((row, index) => (
    <Row key={index} className={index % 2 === 0 ? "even-row" : "odd-row"}>
      {row.columns.map((key, columnIndex) => (
        <Col
          key={columnIndex}
          className="columnaOrden"
          data-index={columnIndex}
        >
          {key}
        </Col>
      ))}
    </Row>
  ))}
  </>
  );
}

// Creates the HTML of the page
const SalesReport = () => {

  const [countries, setProducts] = useState([]);
  const [roles, setCategories] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterdItems, setFilterdItems] = useState([]);
  const { filtro, handleFiltroChange} = useBuscarProductos();
  const [reportingData, setReportingData] = useState([]);


  const secciones = [
  {label: "Nombre producto: ", placeholder: "Selecciona el producto (opcinonal)", values: countries.map((country) => country.name)},
  {label: "Categoria producto: ", placeholder: "Selecciona la categoria (opcional)", values: roles.map((role) => role.name)}
  ];


  useEffect(() => {
    // Call the endpoint to get all the roles and all the countries
    const fectchProducts = async () => {
      try {
        const response = await getProducts();
        setProducts(response.data);
      } catch (error) {
        console.log(error);
      }
    };
  
    const fetchCategory = async () => {
      try {
        const roleResponse = await getCategories();
        setCategories(roleResponse.data);
      } catch (error) {
        console.log(error);
      }
    }
    fectchProducts();
    fetchCategory();
  }, []);


  useEffect(() => {
    setFilterdItems(reportingData);
  }, []);


  const handleBuscarClick = async () => {
    if (filtro["Fecha inicio"] == "") {
      filtro["Fecha inicio"] = null;
    }

    if (filtro["Producto"] == "Selecciona el país") {
      filtro["Producto"] = null;
    }
    if (filtro["Categoria"] == "Selecciona el rol") {
      filtro["Categoria"] = null;
    }

    try {
      const response = await getPerformance(filtro["Fecha inicio"], filtro["Fecha fin"], filtro["Rol"], filtro["Pais"]);
      console.log(response.data);
      
      const reporting = response.data.map((element) => ({
        rowClass: "no-gutters",
        columns: [
          element.name, 
          element.last_name, 
          element.rating, 
          element.department, 
          element.role, 
          element.country, 
          element.state, 
          element.city, 
          element.address
        ]
      }));
      
      setReportingData(reporting);

      console.log(reporting);

    } catch (error) {
      console.log(error);
    }


      // Lógica para buscar productos con los filtros seleccionados
      console.log("Buscar productos con filtro:", filtro);
      // Aca se puede acceder al array o se puede ver en la termianl
    
  };

  const filteredData = reportingData.filter(item =>
    item.columns.some(column => {
      // Convert column to string if it's not already a string
      const columnStr = column.toString().toLowerCase();
      return columnStr.includes(searchTerm.toLowerCase());
    })
  );
  


  // Renders the page
  return (
    <PaginaBase>
      <Container className="background7">
        <Container fluid className="mainPage">
          <p className="title2">Sales Report</p>
          <input
            type="text"
            placeholder="Buscar en performance..."
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
            {renderRows(filteredData)}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default SalesReport;