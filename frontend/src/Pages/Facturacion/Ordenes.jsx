import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col } from "react-bootstrap";
import "./Ordenes.css";
import PaginaBase from "../General/PaginaBase/PaginaBase";
import { getClientOrders } from '../../api/reporting';


// Elements that will be shown in the table

// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"
function renderRows(data) {
  const titles = ["Invoice", "fecha de orden", "estado", "cliente"];
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
const OrdenesClientes = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [filteredItems, setFilteredItems] = useState([]);
  const [reportingData, setProductData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getClientOrders('client1');
        const products = response.data.map((element) => ({
          rowClass: 'no-gutters',
          columns: [
            element.invoiceNumber,
            element.emissionDate,
            element.status,
            element.distance, 

          ],
        }));
        setProductData(products);
      } catch (error) {
        console.log(error);
      }
    };

    fetchData();
  }, []); // Se ejecuta solo al montar el componente

  useEffect(() => {
    setFilteredItems(reportingData);
  }, [reportingData]);

  return (
    <PaginaBase>
      <Container fluid className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Registro de Ordenes</p>
          <div className="vertical-scroll-container">
            {renderRows(filteredItems)} {/* Usar filteredItems en lugar de dataObject */}
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default OrdenesClientes;