import React, { useState, useEffect} from 'react';
import { Link } from 'react-router-dom';
import { Container, Row, Col, Form, Button  } from "react-bootstrap";
import "./inventoryManager.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import { getAllInventoryProducts} from '../../../api/products';



// Works for redirecting to other page like this /productDetail/0"
// Has to redirect to the "facturación"
function renderRows(data) {
  
  const titles = ["Producto", "Descripcion", "Marca", "Exclusividad", "Cantidad", "Precio", "Bodega"];
  return (
    <>
    <Row className="header-row">
      {titles.map((title, index) => (
        <Col key={index} className="column-header">
          {title}
        </Col>
      ))}
    </Row>
  
  
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
const managerInventory = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [filterdItems, setFilterdItems] = useState([]);
  const [reportingData, setProductData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getAllInventoryProducts();
        const products = response.data.map((element) => ({
          rowClass: 'no-gutters',
          columns: [
            element.producto,
            element.descripcion,
            element.marca,
            element.inventario,
            element.cantidad,
            element.precio,
            element.bodega,
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
    setFilterdItems(reportingData);
  }, [reportingData]);

  const handleBuscarClick = () => {
    console.log('Buscar productos con filtro:', searchTerm);
    // Lógica para filtrar productos y actualizar el estado
    // ...

    // Si necesitas hacer algo específico con el término de búsqueda, hazlo aquí
  };

  // Renders the page
  return (
    <PaginaBase>
      <Container className="background2">
        <Container fluid className="mainPage">
          <p className="title2">Inventario global de productos</p>
          <input
            type="text"
            placeholder="Buscar en planilla..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            onBlur={handleBuscarClick} // Agregado: Ejecutar al perder el foco
          />

          <div className="vertical-scroll-container">{renderRows(filterdItems)}</div>
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default managerInventory;

