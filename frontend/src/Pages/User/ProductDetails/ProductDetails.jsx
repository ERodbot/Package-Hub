// Import React, Bootstrap components, and styles
import React, { useState, useEffect } from "react";
import { Card, Container, Row, Col, Button } from "react-bootstrap";
import { Link } from "react-router-dom";
import "./ProductDetails.css";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import { useLocation } from "react-router-dom";
import { getProductDetails } from "../../../api/products";
import ProductCard from "../../../Compoments/ProductDetailsDisplay/ProductDetailsDisplay";
import product_img1 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img1.jpg";
import product_img2 from "../../../assets/Products/trululu-gusanos-acidos-bolsa-img2.png";

// ProductDetails functional component
const ProductDetails = () => {

  const location = useLocation();
  const nombre = location.state?.nombre;
  const categoria = location.state?.categoria;


  // Initialize state variables with default values
  const [brand, setBrand] = useState("");
  const [type, setType] = useState("");
  const [weight, setWeight] = useState("");
  const [material, setMaterial] = useState("");
  const [quantity, setQuantity] = useState(0);
  const [precioUnitario, setPrecioUnitario] = useState(0);
  const [envio, setEnvio] = useState(0);
  const [fotos, setFotos] = useState([]);
  const [colors, setColors] = useState("");
  const [description, setDescription] = useState("");

  // Calculate subtotal and total using the quantity state
  const [subtotal, setSubtotal] = useState(0);
  const [total, setTotal] = useState(0);

  // Load data using useEffect
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getProductDetails(nombre)
        setBrand(response.data.brand);
        setType(categoria);
        setWeight(response.data.weight);
        setMaterial(response.data.material);
        setPrecioUnitario(response.data.price);
        setColors([response.data.color]);
        setDescription(response.data.description);
        setFotos([response.data.image, product_img1, product_img2]);

        // Calculate initial subtotal and total
        const initialSubtotal = 1 * precioUnitario; // Assuming initial quantity is 1
        const initialTotal = initialSubtotal + envio; // Assuming initial shipping cost is 5.0

        // Set initial values for subtotal and total
        setSubtotal(initialSubtotal);
        setTotal(initialTotal);




      } catch (error) {
        console.log(error);
      }
    };
    fetchData();


    // Simulate data loading (you can fetch data using an API call)
    // setTimeout(() => {
    //   setBrand("Ejemplo Marca");
    //   setType("snack");
    //   setWeight("1.5 kg");
    //   setMaterial("Plástico");
    //   setQuantity(1);
    //   setPrecioUnitario(49.99);
    //   setEnvio(5.0);
    //   setFotos([product_img1, product_img2]);
    //   setColors(["red", "black", "yellow"]);
    //   setDescription("Este es un producto de ejemplo");

    //   // Calculate initial subtotal and total
    //   const initialSubtotal = 1 * 49.99; // Assuming initial quantity is 1
    //   const initialTotal = initialSubtotal + 5.0; // Assuming initial shipping cost is 5.0

    //   // Set initial values for subtotal and total
    //   setSubtotal(initialSubtotal);
    //   setTotal(initialTotal);
    // }, 1000); // Simulate a delay for data loading



  }, []);

  // Function to update quantity and recalculate subtotal and total
  const updateCantidad = (newCantidad) => {
    setQuantity(newCantidad);
    setSubtotal(newCantidad * precioUnitario);
    setTotal(newCantidad * precioUnitario + envio);
  };

  // JSX structure for the ProductDetails component
  return (
    <PaginaBase>
      <Container>
        <Row>
          {/* Product details display */}
          <Col md={9} className="custom-col-product-display">
            <ProductCard
              nombre={nombre}
              cantidad={quantity}
              setValQuantity={setQuantity}
              value={precioUnitario}
              shipping={envio}
              colors={colors}
              fotos={fotos}
              productDetailsData={{
                brand: brand,
                description: description,
                material: material,
                weight: weight,
                type: type,
              }}
              updateCantidad={updateCantidad}
              setSubtotal={setSubtotal}
              setTotal={setTotal}
            />
          </Col>

          {/* Buying options display */}
          <Col>
            <Card className="buy-options-display">
              <h2 className="my-5">Info del envío</h2>
              <Row>
                <Col md={6}>
                  <p>
                    <strong>Precio Unidad: </strong>
                  </p>
                  <p>
                    <strong>Subtotal: </strong>
                  </p>
                  <p>
                    <strong>Envío: </strong>
                  </p>
                </Col>
                <Col md={6}>
                  <p>${precioUnitario.toFixed(2)}</p>
                  <p>${subtotal.toFixed(2)}</p>
                  <p>${envio.toFixed(2)}</p>
                </Col>
              </Row>
              <hr />
              <h4>
                <strong>Total a Pagar: </strong>
              </h4>
              <h2>${total.toFixed(2)}</h2>
              <hr />
              <Row>
                <Col md={12}>
                  {/* Add to cart and Buy now buttons */}
                  <Button className="m-1 w-100 custom-product-detail-button-add">
                    Agregar al carrito
                  </Button>
                  <Link to="/buying">
                    <Button className="m-1 w-100 custom-product-detail-button-buy">
                      Comprar Ahora
                    </Button>
                  </Link>
                </Col>
              </Row>
            </Card>
          </Col>
        </Row>
      </Container>
    </PaginaBase>
  );
};

// Export the ProductDetails component
export default ProductDetails;
