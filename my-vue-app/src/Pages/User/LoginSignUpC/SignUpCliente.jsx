import React from "react";
import './LoginSignUp.css';

const SignUpCliente = () => {
  return (
    <div className="formulario">
      <p className="title">Registro de Cliente</p>
      
      <form id="loginEstudianteForm" method="post">
        <div className="inputT1 usernameC">
          <input
            id="usernameC"
            type="text"
            placeholder="Username"
            required
          />
        </div>

        <div className="inputT1 correo">
          <input
            id="correoC"
            type="correo"
            placeholder="Correo"
            required
          />
        </div>

        <div className="inputT1 telefono">
          <input
            id="telefonoC"
            type="telefono"
            placeholder="Telefono"
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
      <div>
      <img
        src="trevol_skate.jpg"
        alt="Logo del packageHub"/>
      </div>
    </div>
  );
};

export default SignUpCliente;