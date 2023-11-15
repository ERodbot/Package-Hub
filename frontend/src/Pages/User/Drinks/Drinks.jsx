import { Container } from "react-bootstrap";
import { useEffect, useState } from "react";
import Products from "../../../Compoments/Products/Products";
import PaginaBase from "../../General/PaginaBase/PaginaBase";
import drinks_icon from "../../../assets/Decorations/alcohol_title.jpg";
import "./Drinks.css";
import productsList from "../../../Compoments/Products/productsData.json";

const Drinks = () => {
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
            <h1>Bebidas</h1>
            <img
              src={drinks_icon}
              alt="menú bebidas"
              className="custom-title-image"
            />
          </div>
          <Products category={"Bebidas"} productsData={products} />
        </Container>
      </Container>
    </PaginaBase>
  );
};

export default Drinks;
