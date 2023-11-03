import { createBrowserRouter } from "react-router-dom";
import App from "./App";
import NavbarPage from "./Compoments/Navbar/Navbar.jsx";
import LoginC from "./Pages/User/LoginSignUpC/LoginCliente.jsx";
import SignC from "./Pages/User/LoginSignUpC/SignUpCliente.jsx";
import Ordenes from "./Pages/Facturacion/Ordenes.jsx";
import Profile from "./Pages/User/Profile/ProfileC.jsx"

const Router = createBrowserRouter([
  {
    path: "/",
    element: <App />, 
  },
  {
    path: "/navbar",
    element: <NavbarPage />,
  },
  {
    path: "/inicioSesionCliente",
    element: <LoginC />,
  },

  {
    path: "/registroCliente",
    element: <SignC />,
  },

  {
    path: "/ordenesCliente",
    element: <Ordenes />,
  },
  {
    path: "/profileCliente",
    element: <Profile />,
  },


]);

export default Router;
