/*React*/
import React from "react";
/*Navbar para usuario sin permisos admin*/
import NavbarPage from "../../../Compoments/Navbar/Navbar";
/*Custom css*/
import "./PaginaBase.css";

const PaginaBase = ({ children, isadmin = false }) => {
  return (
    <>
      <div>
        {/* navbar se incluye como componente, "children son los "
       componentes hijos (el front end de cada pagina individual)*/}
        <NavbarPage />
        <div>{children}</div>
      </div>
    </>
  );
};
export default PaginaBase;
