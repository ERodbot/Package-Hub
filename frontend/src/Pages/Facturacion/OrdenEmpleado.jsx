import React, { useState, useEffect} from 'react';
import { Container, Row, Col, Form, Button, OverlayTrigger, Popover  } from "react-bootstrap";
import './Ordenes.css';
import { Link } from 'react-router-dom';
import PaginaBase from "../General/PaginaBase/PaginaBase";
import { getEmployeeOrders } from '../../api/reporting';

// Elements that will be shown in the table
const dataObject = [
  { rowClass: "no-gutters", columns: ["#1473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#1473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#7473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#9473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
];

// Function that renders the page for rows
function renderRows(data) {
  const titles = ["ordernId", "factura", "fecha creado", "estado", "nombre del cliente", "apellido del cliente", "usario del cliente", "distancia"];
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

// Function that renders the page
const OrdenesEmpleado = () => {
  const [selectedOrderIndex, setSelectedOrderIndex] = useState(null);
  const [selectedStatusIndex, setSelectedStatusIndex] = useState(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filteredItems, setFilteredItems] = useState([]);
  const [reportingData, setProductData] = useState([]);
  const [uniqueOrderIds, setUniqueOrderIds] = useState([]);
  const [uniqueOrderStatus, setUniqueOrderStatus] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getEmployeeOrders();
        const products = response.data.map((element) => ({
          rowClass: 'no-gutters',
          columns: [
            element.idOrder,
            element.invoiceNumber,
            element.emissionDate,
            element.status,
            element.clientName,
            element.clientLastname,
            element.clientUsername,
            element.distance,
          ],
        }));
        setProductData(products);

        // Obtener orderId y estados únicos y almacenarlos en los estados
        const uniqueOrderIdsArray = [...new Set(products.map((item) => item.columns[0]))];
        const uniqueStatusArray = [...new Set(products.map((item) => item.columns[3]))];

        setUniqueOrderIds(uniqueOrderIdsArray);
        setUniqueOrderStatus(uniqueStatusArray);
      } catch (error) {
        console.log(error);
      }
    };

    fetchData();
  }, []); 

  useEffect(() => {
    setFilteredItems(reportingData);
  }, [reportingData]);

  const handleBuscarClick = () => {
    // Obtains the selected value in the Form.Select for orders
    const selectedOrderId = document.getElementById('orderSelect').value.toString();
  
    // Find the index of the selected order
    const orderIndex = filteredItems.findIndex(item => item.columns[0].toString() === selectedOrderId);
  
    // Save the order index in the state
    setSelectedOrderIndex(orderIndex);
  
    // Obtains the selected value in the Form.Select for status
    const selectedStatus = document.getElementById('statusSelect').value.toString();
  
    // Find the index of the selected status
    const statusIndex = filteredItems.findIndex(item => item.columns[3].toString() === selectedStatus);
  
    setSelectedStatusIndex(statusIndex);
  
    console.log('Índice de la orden seleccionada:', orderIndex);
    console.log('Índice del estado seleccionado:', statusIndex);
  
    // Here you can do the logic to save the answer in the database

    
  };
  

  return (
    <PaginaBase>
      <Container fluid className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Registro de Ordenes</p>
          <div className="vertical-scroll-container">
            {renderRows(filteredItems)} 
          </div>

          <div className="respuesta-container">
            <Row className="answerRows">
              <Col sm={5}>Ingrese la orden a responder:</Col>
              <Col sm={7}>
                <Form.Select
                  id="orderSelect"
                  aria-label="Default select example"
                  onChange={(e) => setSelectedOrderIndex(e.target.value)}
                >
                  <option>Opciones de ordenes</option>
                  {uniqueOrderIds.map((orderId, index) => (
                    <option key={index} value={orderId}>
                      {orderId}
                    </option>
                  ))}
                </Form.Select>
              </Col>
            </Row>

            <Row className="answerRows">
              <Col sm={5}>Ingrese el estado correspondiente:</Col>
              <Col sm={7}>
                <Form.Select
                  id="statusSelect"
                  aria-label="Default select example"
                  onChange={(e) => setSelectedStatusIndex(e.target.value)}
                >
                  <option>Opciones del estado</option>
                  {uniqueOrderStatus.map((status, index) => (
                    <option key={index} value={status}>
                      {status}
                    </option>
                  ))}
                </Form.Select>
              </Col>
            </Row>

            <Row className="answerRows">
              <Col sm={12} className="text-center">
                <Button className="buscarBtn" type="button" onClick={handleBuscarClick}>
                  Buscar
                </Button>
              </Col>
            </Row>
          </div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default OrdenesEmpleado;