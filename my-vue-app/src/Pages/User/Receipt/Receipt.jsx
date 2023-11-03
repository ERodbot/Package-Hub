import React, { useState, useEffect } from "react";
import { Container, Row, Col, Card } from "react-bootstrap";
import "./Receipt.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const Receipt = () => {
  const [invoiceData, setInvoiceData] = useState(null);
  const [itemsData, setItemsData] = useState(null);

  // Cargar los datos desde los archivos JSON
  useEffect(() => {
    // Simular una carga asíncrona de los datos (puedes usar fetch o axios)
    // invoiceData.json y itemsData.json deben estar en la misma ubicación que este componente
    import("./invoiceData.json")
      .then((data) => setInvoiceData(data))
      .catch((error) => console.error("Error loading invoice data:", error));

    import("./itemsData.json")
      .then((data) => setItemsData(data))
      .catch((error) => console.error("Error loading items data:", error));
  }, []);

  if (!invoiceData || !itemsData) {
    return <p>Loading...</p>;
  }

  const {
    factura,
    emision,
    orden,
    cliente,
    direccionFacturacion,
    email,
    direccionEnvio,
  } = invoiceData;

  const { items, subtotal, total } = itemsData;

  return (
    <Container className="background">
      <PaginaBase>
        <Container>
          <h1 className="text-center custom-text my-5">Package Hub</h1>
          <Container>
            <Card className="card custom-card">
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
                    {items.map((item, index) => {
                      <p
                        className="custom-text-p"
                        key={index}
                      >{`${item.articulo}: $${item.precio}.`}</p>;
                    })}
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
