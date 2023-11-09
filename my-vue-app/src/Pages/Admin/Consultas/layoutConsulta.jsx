import React from "react";
import {Row, Col, Form, Button} from 'react-bootstrap';
import "./layoutConsulta.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

function Busqueda() {
  const items = [
    { type: 'Tipo de Producto:', product: 'Producto' },
    { type: 'Tipo de Producto:', product: 'Producto' },
    { type: 'Tipo de Producto:', product: 'Producto' },
    { type: 'jafdsff:', product: 'Producto' },
    // Add more items as needed
  ];

  return (
    <PaginaBase>
      <p className="title2">Nombre de la consulta</p>
      <div className="vertical-scroll-container">
        <Form className="contenedorFormulario">
          {items.map((item, index) => (
            <div className="labelWrapper" key={index}>
              <div className="labelContainer">
                <label className="label">{item.type}</label>
              </div>
              <div className='contenedorFormularioProdu'>
                <label className="label">{item.product}</label>
              </div>
            </div>
          ))}
        </Form>
      </div>
    </PaginaBase>
  );
}

export default Busqueda;