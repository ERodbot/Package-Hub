import React from "react";
import "./ProfileC.css";
import userImg from "../../../assets/Links/profileFlower.svg";
import { Container } from "react-bootstrap";

const PerfilCliente = () => {
  return (
    <div className="background">
     
      <p className="pageTitle">Perfil</p>
      <div className="content">
        <div className="profile-container">
          <img className="imageUserContainer" src={userImg} alt="User" />
          <button className="buttonT1 greenBtn" id="editarProfileButton">
            Editar
          </button>
          <button className="buttonT1 redBtn" id="eliminarProfileButton">
            Eliminar
          </button>
        </div>
        <div className="contact-container">
          <form id="modificarPerfilForm" method="post">
            <div className="profile-attribute">
              <p>Nombre:</p>
              <input
                id="nameProfile"
                type="text"
                className="form-control"
                placeholder=""
                disabled
              />
            </div>

            <div className="profile-attribute">
              <p>Usuario:</p>
              <input
                id="usernameProfile"
                type="text"
                className="form-control"
                placeholder=""
                disabled
              />
            </div>

            <div className="profile-attribute">
              <p>Telefono:</p>
              <input
                id="telefonoProfile"
                type="text"
                className="form-control"
                placeholder=""
                disabled
              />
            </div>

            <div className="profile-attribute">
              <p>Correo:</p>
              <input
                id="correoProfile"
                type="text"
                className="form-control"
                placeholder=""
                disabled
              />
            </div>

            <div className="profile-attribute">
              <p>Ubicacion:</p>
              <input
                id="ubicacionProfile"
                type="text"
                className="form-control"
                placeholder=""
                disabled
              />
            </div>

            <button
              type="submit"
              className="buttonT1 btnsucces"
              id="saveProfileButton"
              disabled
            >
              Guardar cambios
            </button>
          </form>
        </div>
      </div>
    </div>




  );
};

export default PerfilCliente;
