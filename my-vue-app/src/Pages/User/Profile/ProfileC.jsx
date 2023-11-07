import React, { useState } from "react";
import "./ProfileC.css";
import userImg from "../../../assets/Links/profileFlower.svg";
import { Container, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const PerfilCliente = () => {
  // Estado para cada campo de entrada
  const [nombre, setNombre] = useState("");
  const [usuario, setUsuario] = useState("");
  const [telefono, setTelefono] = useState("");
  const [correo, setCorreo] = useState("");
  const [ubicacion, setUbicacion] = useState("");

  return (
<<<<<<< HEAD
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
              />
            </div>

            <div className="profile-attribute">
              <p>Usuario:</p>
              <input
                id="usernameProfile"
                type="text"
                className="form-control"
                placeholder=""
              />
            </div>

            <div className="profile-attribute">
              <p>Telefono:</p>
              <input
                id="telefonoProfile"
                type="text"
                className="form-control"
                placeholder=""
              />
            </div>

            <div className="profile-attribute">
              <p>Correo:</p>
              <input
                id="correoProfile"
                type="text"
                className="form-control"
                placeholder=""
                x
              />
            </div>

            <div className="profile-attribute">
              <p>Ubicacion:</p>
              <input
                id="ubicacionProfile"
                type="text"
                className="form-control"
                placeholder=""
              />
            </div>

            <button
              type="submit"
              className="buttonT1 btnsucces"
              id="saveProfileButton"
            >
              Guardar cambios
            </button>
          </form>
        </div>
      </div>
    </div>
=======
    <PaginaBase>
      <div className="background">
        <p className="pageTitle">Perfil</p>
        <div className="content">
          <div className="profile-container"> 
            <img className="imageUserContainer" src={userImg} alt="User" />
            <Button className="buttonT1 greenBtn" id="editarProfileButton">
              Editar
            </Button>
            <Button className="buttonT1 redBtn" id="eliminarProfileButton">
              Eliminar
            </Button>
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
                  enabled
                  value={nombre}
                  onChange={(e) => setNombre(e.target.value)}
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
                  value={usuario}
                  onChange={(e) => setUsuario(e.target.value)}
                />
              </div>

              <div className="profile-attribute">
                <p>Teléfono:</p>
                <input
                  id="telefonoProfile"
                  type="text"
                  className="form-control"
                  placeholder=""
                  disabled
                  value={telefono}
                  onChange={(e) => setTelefono(e.target.value)}
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
                  value={correo}
                  onChange={(e) => setCorreo(e.target.value)}
                />
              </div>

              <div className="profile-attribute">
                <p>Ubicación:</p>
                <input
                  id="ubicacionProfile"
                  type="text"
                  className="form-control"
                  placeholder=""
                  disabled
                  value={ubicacion}
                  onChange={(e) => setUbicacion(e.target.value)}
                />
              </div>

              <Button
                type="submit"
                className="buttonT1 btnsucces"
                id="saveProfileButton"
                enabled
              >
                Guardar cambios
              </Button>
            </form>
          </div>
        </div>
      </div>
    </PaginaBase>
>>>>>>> e97d82d49a815b1e333c3fac15798ac0b13b3f8b
  );
};

export default PerfilCliente;