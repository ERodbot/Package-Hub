/*React*/
import React from "react";
/*Navbar for users without admin permissions*/
import NavbarPage from "../../../Compoments/Navbar/Navbar";
/*Custom css*/
import "./PaginaBase.css";

const PaginaBase = ({ children, isAdmin = false }) => {
  return (
    <>
      <div>
        {/* Navbar is included as a component, "children" are the 
       child components (the frontend of each individual page)*/}
        <NavbarPage />
        <div>{children}</div>
      </div>
    </>
  );
};
export default PaginaBase;
