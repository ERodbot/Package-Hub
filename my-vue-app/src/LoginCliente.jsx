import React from "react";
import "./LoginCliente.css";

const LoginCliente = () => {
  return (
    <div className="formulario">
      <p className="title">Inicio de Sesión</p>
      <p className="subtitle">Cliente</p>
      <form id="loginEstudianteForm" method="post">
        <div className="inputT1 usernameE">
          <input
            id="usernameEstLog"
            type="text"
            placeholder="Username"
            required
          />
        </div>

        <div className="inputT1 password">
          <input
            id="passwordEstLog"
            type="password"
            placeholder="Password"
            required
          />
        </div>

        <div>
          <button className="buttonT1" type="submit">
            Iniciar Sesión
          </button>
        </div>
      </form>
    </div>
  );
};

export default LoginCliente;