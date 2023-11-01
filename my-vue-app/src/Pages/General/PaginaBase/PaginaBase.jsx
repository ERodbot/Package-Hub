/*React*/
import React from "react";
/*Navbar para usuario sin permisos admin*/
import NavbarPage from "../../../Compoments/Navbar/Navbar";
/*Custom css*/
import "./PB.css";

const PaginaBase = ({ children, isadmin = false }) => {
  return (
    <>
      <div className="pagina-base" styles={{ marginBottom: "10rem" }}>
        {/* navbar se incluye como componente, "children son los "
       componentes hijos (el front end de cada pagina individual)*/}
        <NavbarPage />
      </div>
      <div>
        <div>{children}</div>
      </div>
    </>
  );
};
export default PaginaBase;
