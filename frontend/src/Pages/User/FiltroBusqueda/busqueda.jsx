import React, { useState } from "react";
import { Container, Row, Col, Form, Button } from 'react-bootstrap';
import { Link } from "react-router-dom";
import "./busqueda.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
// Se encarga de generar un forms para la busqueda de productos
// Todos los datos que se ingresan son mediante el placeholder y un array
// En const secciones se puede modificar el label, placeholder y los valores
const secciones = [
  { label: "Tipo de Producto", placeholder: "Selecciona el tipo de producto", values: ["Uno", "Two", "Three"] },
  { label: "Producto", placeholder: "Selecciona el producto", values: ["A", "B", "C"] },
  { label: "Pais", placeholder: "Selecciona el país", values: ["USA", "Canada", "Mexico"] },
  { label: "Bodega", placeholder: "Selecciona la bodega", values: ["Alpha", "Beta", "Gamma"] }
];

// Caso de uso para manejar la lógica de búsqueda
const useBuscarProductos = () => {
  const [filtro, setFiltro] = useState({
    "Tipo de Producto": "",
    "Producto": "",
    "Pais": "",
    "Bodega": ""
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

// La funcion busqueda se encarga de generar el formulario
function Busqueda() {
  const { filtro, handleFiltroChange, handleBuscarClick } = useBuscarProductos();

  return (
    <PaginaBase>
      <Form className="contenedorFormulario">
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
            <Link to="/snacks">
              <Button className="buscarBtn" type="button" onClick={handleBuscarClick}>
                Buscar
              </Button>
            </Link>
          </Col>
        </Form.Group>
      </Form>
    </PaginaBase>
  );
}

export default Busqueda;