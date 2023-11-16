import React, { useState } from 'react';
import { Container, Row, Col, Form, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import './AnswerComplaints.css';
import PaginaBase from "../../General/PaginaBase/PaginaBase";

// Element list for mapping
const dataObject = [
  { rowClass: "no-gutters", columns: ["#7473-8273", "usuario", "El problema es que no se guardan. Ademas sucede que los datos no se guarden de la fomra que yo quiero y necesito", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#4473-8273", "usuario", "problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#4473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#4473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#4473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#8473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#8473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#8473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#8473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#1473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#7473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#1473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#1473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#7473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
  { rowClass: "no-gutters", columns: ["#9473-8273", "usuario","problema...", "nombre@estudiantec.cr"] },
];

// For the redirection of the page can be donde like this: /productDetail/0"
// This function renders the rows of the table
function renderRows(data) {
  return data.map((row, index) => (
    <Link key={index} to={`/productDetail/${index}`} style={{ color: 'black' , textDecoration: 'none' }}>
      <Row className={index % 2 === 0 ? "even-row" : "odd-row"}>
        <Col className="columnaOrden" data-index={index}>
          {row.columns[0]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[1]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[2]}
        </Col>
        <Col className="columnaOrden">
          {row.columns[3]}
        </Col>
      </Row>
    </Link>
  ));
}
// Function to save information of the complaint answers
const AnswerComplaints = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedRowIndex, setSelectedRowIndex] = useState(null);
  const [respuestaTexto, setRespuestaTexto] = useState(null);

  // Makes the search bar work
  const filteredData = dataObject.filter(item =>
    item.columns.some(column =>
      column.toLowerCase().includes(searchTerm.toLowerCase())
    )
  );

  const handleBuscarClick = () => {
    // Obtains the selected valie in the Form.Select
    const ordenSeleccionada = document.getElementById('formSelect').value;

    // Find the index of the selected row
    const indiceFila = dataObject.findIndex(item => item.columns[0] === ordenSeleccionada);

    // Save the index and the text of the answer in the state
    setSelectedRowIndex(indiceFila);
    let textAreaValue = document.getElementById('formTextArea').value;
    if (textAreaValue != null) {
      setRespuestaTexto(textAreaValue);
    } else {
      setRespuestaTexto(null);
    }

    // Here we can do the logic to save the answer in the database

    console.log('Índice de la fila:', indiceFila);
    console.log('Texto de respuesta:', respuestaTexto);
  };

  // Render the answer text in the text area
  return (
    <PaginaBase>
      <Container className="background5">
        <Container fluid className="mainPage">
          <p className="title2">Registro de Quejas y Consultas</p>
          <input
            type="text"
            placeholder="Buscar órdenes..."
            className="searchBar"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
          <div className="vertical-scroll-container">
            {renderRows(filteredData)}
          </div>

          <div className="respuesta-container">
            <Row className="answerRows">
              <Col sm={5}>Ingrese la orden a responder:</Col>
              <Col sm={7}>
              <Form.Select 
                id="formSelect" 
                aria-label="Default select example"
                onChange={(e) => setSelectedRowIndex(e.target.value)}
              >
                <option>Opciones de ordenes</option>
                {dataObject.map((item, index) => (
                  <option key={index} value={item.columns[0]}>
                    {item.columns[0]}
                  </option>
                ))}
              </Form.Select>
              </Col>
            </Row>
            <Row className="answerRows">
              <Col sm={5}>Respuesta del empleado</Col>
              <Col sm={7}>
                <Form.Control id="formTextArea" as="textarea" className="input-text" rows={3} placeholder="Texto grande aquí" onChange={(e) => setRespuestaTexto(e.target.value)}/>
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

export default AnswerComplaints;