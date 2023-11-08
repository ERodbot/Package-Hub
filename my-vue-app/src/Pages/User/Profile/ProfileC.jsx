import React, { useState } from "react";
import "./ProfileC.css";
import userImg from "../../../assets/Links/profileFlower.svg";
import { Container, Button } from "react-bootstrap";
import PaginaBase from "../../General/PaginaBase/PaginaBase";

const PerfilCliente = () => {
  // Nombre de los placeholders de los inputs
  const placeholders = [
    "Nombre",
    "Usuario",
    "Telefono",
    "Correo",
    "Ubicacion",
  ];

  // Estados de los inputs por si se ocuparan en un futuro
  const [nombre, setNombre] = useState("");
  const [usuario, setUsuario] = useState("");
  const [telefono, setTelefono] = useState("");
  const [correo, setCorreo] = useState("");
  const [ubicacion, setUbicacion] = useState("");

  // Estado del modo de edición
  const [editMode, setEditMode] = useState(false);

  // Función para manejar el cambio de los inputs
  const handleInputChange = (e, setter) => {
    setter(e.target.value);
  };

  // Función para manejar el click en el botón de editar
  const handleEditClick = () => {
    setEditMode(!editMode);
  };

  // Función para manejar el submit del formulario
  const handleSaveChanges = (e) => {
    e.preventDefault();

    // Recolectar todos los datos del perfil en un array
    const perfilData = [
      nombre,
      usuario,
      telefono,
      correo,
      ubicacion,
    ];

    // Mostrar el array en la consola (puedes eliminar esto en la versión final)
    console.log("Datos del perfil:", perfilData);

    // Aquí se puede acceder al array con los nuevos datos

    // Desactivar el modo de edición
    setEditMode(false);
  };

  return (
    <PaginaBase>
      <div className="background">
        <p className="pageTitle">Perfil</p>
        <div className="content">
          <div className="profile-container">
            <img className="imageUserContainer" src={userImg} alt="User" />
            <Button
              className="buttonT2 greenBtn"
              id="editarProfileButton"
              onClick={handleEditClick}
            >
              {editMode ? "Cancelar" : "Editar"}
            </Button>
            <Button className="buttonT2 redBtn" id="eliminarProfileButton">
              Eliminar
            </Button>
          </div>
          <div className="contact-container">
            <form id="modificarPerfilForm" onSubmit={handleSaveChanges}>
              {placeholders.map((placeholder, index) => (
                <div key={index} className="profile-attribute">
                  <p>{placeholder}:</p>
                  <input
                    type="text"
                    className="form-control buttonT2 modified"
                    placeholder={placeholder}
                    disabled={!editMode}
                    value={eval(placeholder.toLowerCase())}
                    onChange={(e) =>
                      handleInputChange(e, eval(`set${placeholder}`))
                    }
                  />
                </div>
              ))}
              <Button
                type="submit"
                className="buttonT2 btnsucces modified"
                id="saveProfileButton"
              >
                Guardar cambios
              </Button>
            </form>
          </div>
        </div>
      </div>
    </PaginaBase>
  );
};

export default PerfilCliente;