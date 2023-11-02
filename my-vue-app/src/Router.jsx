import { createBrowserRouter } from "react-router-dom";
import App from "./App";
import NavbarPage from "./Compoments/Navbar/Navbar.jsx";
import MainPage from "./Pages/User/Main/MainPage";
import Products from "./Pages/User/Products/Products";

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
    path: "/main",
    element: <MainPage />,
  },
  {
    path: "/products",
    element: <Products />,
  },
]);

export default Router;
