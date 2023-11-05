import React from "react";
import { Container, Row, Col, Form, Button, InputGroup } from 'react-bootstrap';
import "./busqueda.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const secciones = [
  { label: "Tipo de Producto", placeholder: "Selecciona el tipo de producto", values: ["Uno", "Two", "Three"] },
  { label: "Producto", placeholder: "Selecciona el producto", values: ["A", "B", "C"] },
  { label: "Pais", placeholder: "Selecciona el país", values: ["USA", "Canada", "Mexico"] },
  { label: "Bodega", placeholder: "Selecciona la bodega", values: ["Alpha", "Beta", "Gamma"] }
];

function Busqueda() {
  return (
    <PaginaBase>
      <Form className="contenedorFormulario">
        {secciones.map((seccion, index) => (
          <div key={index} className="labelWrapper">
            <div class="labelContainer"> 
            <label className="label">{seccion.label}:</label>
            </div>
            <Form.Select aria-label="Default select example" className='contenedorFormularioProdu'>
              <option>{seccion.placeholder}</option>
              {seccion.values.map((value, valueIndex) => (
                <option key={valueIndex} value={value}>{value}</option>
              ))}
            </Form.Select>
          </div>
        ))}
        <Form.Group as={Row} className="mb-3">
          <Col sm={{ span: 10, offset: 2 }}>
            <Button className="buscarBtn" type="submit">Buscar</Button>
          </Col>
        </Form.Group>
      </Form>
    </PaginaBase>
  );
}

export default Busqueda;