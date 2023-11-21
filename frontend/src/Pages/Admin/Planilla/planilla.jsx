  import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { getPayroll } from '../../../api/reporting';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./planilla.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";


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



  return { filtro, handleFiltroChange };
};

// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"
function renderRows(data) {
  const titles = ["Nombre", "Apellido", "Departamento", "Rol", "Pais", "Fecha inicio", "Fecha fin", "Salario bruto", "Salario neto", "Deducciones", "Porcentaje"];
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
const Planilla = () => {

  const [reportingData, setReportingData] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterdItems, setFilterdItems] = useState([]);
  const { filtro, handleFiltroChange } = useBuscarProductos();



  const handleBuscarClick = () => {
    if (filtro["Fecha inicio"] === "") {
      filtro["Fecha inicio"] = null;
    }
    if (filtro["Fecha fin"] === "") {
      filtro["Fecha fin"] = null;
    }

    try {
      const handleBuscarClick = async () => {
        if (filtro["Fecha inicio"] === "") {
          filtro["Fecha inicio"] = null;
        }
        if (filtro["Fecha fin"] === "") {
          filtro["Fecha fin"] = null;
        }

        try {
          const response = await getPayroll(); // Assuming getPayroll is an async function that returns a promise
          const reporting = response.data.map((element) => ({
            rowClass: "no-gutters",
            columns: [
              element.name,
              element.lastName,
              element.department,
              element.role,
              element.country,
              element.startDate,
              element.endDate,
              element.grossSalary,
              element.netSalary,
              element.deductions,
              element.percentage
            ],
          }));

          setReportingData(reporting);
          console.log(reporting)

        } catch (error) {
          console.log(error);
        }
      };
        if (filtro["Fecha inicio"] === "") {
          filtro["Fecha inicio"] = null;
        }
        if (filtro["Fecha fin"] === "") {
          filtro["Fecha fin"] = null;
        }

        try {
          const response = await getPayroll(filtro["Fecha inicio"], filtro["Fecha fin"]);
          console.log(response.data);

          const reporting = response.data.map((element) => ({
            rowClass: "no-gutters",
            columns: [
              element.name,
              element.lastName,
              element.department,
              element.role,
              element.country,
              element.startDate,
              element.endDate,
              element.grossSalary,
              element.netSalary,
              element.deductions,
              element.percentage
            ],
          }));

          setReportingData(reporting);
          console.log(reporting)

        } catch (error) {
          console.log(error);
        }
      };

      const reporting = response.data.map((element) => ({
        rowClass: "no-gutters",
        columns: [
          element.name,
          element.lastName,
          element.department,
          element.role,
          element.country,
          element.startDate,
          element.endDate,
          element.grossSalary,
          element.netSalary,
          element.deductions,
          element.percentage
        ],
      }));

      setReportingData(reporting);
      console.log(reporting);

    try {
      // Your code for handling the error goes here
    } catch (error) {
      console.log(error);
    }

    // Logic for searching products with the selected filters
    // Lógica para buscar productos con los filtros seleccionados
    console.log("Buscar productos con filtro:", filtro);
    // Aca se puede acceder al array o se puede ver en la termianl
  };





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