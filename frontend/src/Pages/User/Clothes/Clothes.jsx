import { Container } from "react-bootstrap";
import { useState, useEffect } from "react";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import clothes_icon from "../../../assets/Decorations/clothing_title.jpg";
import "./Clothes.css";
import productsList from "../../../Compoments/Products/productsData.json";

/* Path es temporal, es para cargar productos placeholder, usar el useState para cargar los productos del request */

const Clothes = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    // Load products initially
    setProducts(productsList.products);
  }, []);

  useEffect(() => {
    console.log("products: ", products);
  }, [products]);

  return (
    <PaginaBase>
      <Container className="custom-container-box">
        <Container className="custom-container">
          <div className="align-content-center mb-5">
            <h1>Ropa</h1>
            <img
              src={clothes_icon}
              alt="menú ropa"
              className="custom-title-image"
            />
          </div>
          <Products category={"Ropa"} productsData={products} />
        </Container>
      </Container>
    </PaginaBase>
  );
};
export default Clothes;
