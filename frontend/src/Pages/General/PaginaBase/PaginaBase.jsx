/*React*/
import React from "react";
/*Navbar for users without admin permissions*/
import NavbarPage from "../../../Compoments/Navbar/Navbar";
/*Custom css*/
import "./PaginaBase.css";
import { useAuth } from "../../../contexts/auth";
import NavbarGerente from "../../../Compoments/NavbarGerente/NavbarGerente";
import NavbarEmpleado from "../../../Compoments/NavbarEmpleado/NavbarEmpleado";

const PaginaBase = ({ children }) => {
  
  const { user } = useAuth();
  console.log(user)

  return (
    <>
      <div>
        {/* Navbar is included as a component, "children" are the 
       child components (the frontend of each individual page)*/}
        {
          !user.data.role ? (
            <NavbarPage />
          ) : user.data.role === "Gerente" ? (
            <NavbarGerente />
          ) : (
            <NavbarEmpleado />
          )
        }
        <div>{children}</div>
      </div>
    </>
  );
};
export default PaginaBase;
