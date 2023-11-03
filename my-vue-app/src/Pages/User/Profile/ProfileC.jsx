import React from "react";
import "./ProfileC.css";
import userImg from "../../../assets/Logos/userLogo.svg";

const PerfilCliente = () => {
  return (
    <div>
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
              className="btn btn-success"
              id="saveProfileButton"
              disabled
            >
              Guardar cambios
            </button>
          </form>
        </div>
      </div>

      <div className="errorContainer">
        <p className="title errorTitle">Alerta</p>
        <p className="errorText"></p>
        <button className="btn btn-danger errorButton">Cerrar</button>
      </div>

      <div className="deleteContainer">
        <p className="title deleteText">Alerta</p>
        <p className="deleteText">
          ¿Está seguro que desea borrar su cuenta? Esta acción no puede ser
          revertida.
        </p>
        <button className="btn btn-danger deleteButton" id="confirmDelButton">
          Confirmar
        </button>
        <button className="btn btn-secondary deleteButton" id="cancelDelButton">
          Cancelar
        </button>
      </div>
    </div>
  );
};

export default PerfilCliente;
