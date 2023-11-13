import React, { useState, useEffect } from "react";
import { Container, Row, Col, Card } from "react-bootstrap";
import "./Receipt.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const Receipt = () => {
  const [factura, setFactura] = useState(null);
  const [emision, setEmision] = useState(null);
  const [orden, setOrden] = useState(null);
  const [cliente, setCliente] = useState(null);
  const [direccionFacturacion, setDireccionFacturacion] = useState(null);
  const [email, setEmail] = useState(null);
  const [direccionEnvio, setDireccionEnvio] = useState(null);

  const [items, setItems] = useState(null);
  const [subtotal, setSubtotal] = useState(null);
  const [total, setTotal] = useState(null);

  // Cargar los valores de prueba en un useEffect
  useEffect(() => {
    // Simular la carga de valores de prueba
    setFactura("12345");
    setEmision("2023-11-10");
    setOrden("67890");
    setCliente("John Doe");
    setDireccionFacturacion("123 Main St, City");
    setEmail("john.doe@example.com");
    setDireccionEnvio("456 Second St, Town");

    setItems([
      { articulo: "Item 1", precio: 10.0 },
      { articulo: "Item 2", precio: 15.0 },
      { articulo: "Item 3", precio: 20.0 },
    ]);
    setSubtotal(45.0);
    setTotal(45.0);
  }, []);

  if (
    factura === null ||
    emision === null ||
    orden === null ||
    cliente === null ||
    direccionFacturacion === null ||
    email === null ||
    direccionEnvio === null ||
    items === null ||
    subtotal === null ||
    total === null
  ) {
    return <p>Loading...</p>;
  }

  return (
    <Container className="background-receipt">
      <PaginaBase>
        <Container className="receipt-page">
          <h1 className="text-center custom-text my-5">Package Hub</h1>
          <Container>
            <Card className="card-receipt custom-card-receipt mx-auto">
              <Card.Body>
                <Row>
                  <Col>
                    <h2 className="text-center custom-text-h2">
                      Información General
                    </h2>
                    <p className="custom-text-p">{`Número de factura: ${factura}.`}</p>
                    <p className="custom-text-p">{`Fecha de emisión: ${emision}.`}</p>
                    <p className="custom-text-p">{`Número de orden: # ${orden}.`}</p>
                    <h2 className="text-center custom-text-h2">
                      Información Personal
                    </h2>
                    <p className="custom-text-p">{`Nombre del Cliente: ${cliente}.`}</p>
                    <p className="custom-text-p">{`Dirección de facturación: ${direccionFacturacion}.`}</p>
                    <p className="custom-text-p">{`Correo Electrónico: ${email}.`}</p>
                    <h2 className="text-center custom-text-h2">
                      Dirección de envío
                    </h2>
                    <p className="custom-text-p">{`Dirección de envío: ${direccionEnvio}.`}</p>
                  </Col>
                  <Col>
                    <h2 className="text-center custom-text-h2">Detalles</h2>
                    <h3 className="text-center custom-text-h3">Artículos</h3>
                    {items.map((item, index) => (
                      <p
                        className="custom-text-p"
                        key={index}
                      >{`${item.articulo}: $${item.precio}.`}</p>
                    ))}
                    <h3 className="text-center custom-text-h3">
                      Método de pago
                    </h3>
                    <p className="custom-text-p">{`Método de pago: Credit Card.`}</p>
                    <h3 className="text-center custom-text-h3">{`Subtotal: $${subtotal}`}</h3>
                    <h3 className="custom-text-h3">{`Total: $${total}`}</h3>
                  </Col>
                </Row>
              </Card.Body>
            </Card>
          </Container>
        </Container>
      </PaginaBase>
    </Container>
  );
};

export default Receipt;
