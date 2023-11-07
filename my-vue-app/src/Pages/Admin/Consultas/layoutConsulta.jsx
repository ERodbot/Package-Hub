import React from "react";
import {Row, Col, Form, Button} from 'react-bootstrap';
import "./layoutConsulta.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

function Busqueda() {
  return (
    <PaginaBase>
      <p className="title2">Nombre de la consulta</p>
      <div className="vertical-scroll-container">
      <Form className="contenedorFormulario">
        <div className="labelWrapper">
          <div className="labelContainer">
            <label className="label">Tipo de Producto:</label>
          </div>
          <div className='contenedorFormularioProdu'>
            <label className="label">Producto</label>
          </div>
        </div>

        <div className="labelWrapper">
          <div className="labelContainer">
            <label className="label">Tipo de Producto:</label>
          </div>
          <div className='contenedorFormularioProdu'>
            <label className="label">Producto</label>
          </div>
        </div>

        <div className="labelWrapper">
          <div className="labelContainer">
            <label className="label">Tipo de Producto:</label>
          </div>
          <div className='contenedorFormularioProdu'>
            <label className="label">Producto</label>
          </div>
        </div>

        <div className="labelWrapper">
          <div className="labelContainer">
            <label className="label">jafdsffadfasdfafsdfasdffadfasdfasd fasdffdafasdfasdfasdklj:</label>
          </div>
          <div className='contenedorFormularioProdu'>
            <label className="label">Producto</label>
          </div>
        </div>
      </Form>
      </div>
    </PaginaBase>
  );
}

export default Busqueda;