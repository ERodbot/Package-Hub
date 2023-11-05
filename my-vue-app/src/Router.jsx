import { createBrowserRouter } from "react-router-dom";
import App from "./App";
import NavbarPage from "./Compoments/Navbar/Navbar.jsx";
import MainPage from "./Pages/User/Main/MainPage";
import Products from "./Compoments/Products/Products";
import LoginC from "./Pages/User/LoginSignUpC/LoginCliente.jsx";
import SignC from "./Pages/User/LoginSignUpC/SignUpCliente.jsx";
import Clothes from "./Pages/User/Clothes/Clothes";
import Receipt from "./Pages/User/Receipt/Receipt";
import BuyingPage from "./Pages/User/BuyingPage/BuyingPage";
import Ordenes from "./Pages/Facturacion/Ordenes.jsx";
import Profile from "./Pages/User/Profile/ProfileC.jsx";
import Busqueda from "./Pages/User/FiltroBusqueda/busqueda.jsx";


const Router = createBrowserRouter([
  {
    path: "/navbar",
    element: <NavbarPage />,
  },
  {
    path: "/main",
    element: <MainPage />,
  },
  {
    path: "/clothes",
    element: <Clothes />,
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
    path: "/Receipt",
    element: <Receipt />,
  },
  {
    path: "/Buying",
    element: <BuyingPage />,
  },

  {
    path: "/ordenesCliente",
    element: <Ordenes />,
  },
  {
    path: "/profileCliente",
    element: <Profile />,
  },
  {
    path: "/busqueda",
    element: <Busqueda />,
  },
]);

export default Router;
