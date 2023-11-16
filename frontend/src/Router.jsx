import { createBrowserRouter } from "react-router-dom";
import App from "./App";

import MainPage from "./Pages/User/Main/MainPage";
import Products from "./Compoments/Products/Products";
import LoginC from "./Pages/User/LoginSignUpC/LoginCliente.jsx";
import SignC from "./Pages/User/LoginSignUpC/SignUpCliente.jsx";
import Clothes from "./Pages/User/Clothes/Clothes";
import Receipt from "./Pages/User/Receipt/Receipt";
import BuyingPage from "./Pages/User/BuyingPage/BuyingPage";
import Ordenes from "./Pages/Facturacion/Ordenes.jsx";
import OrdenesEmpleado from "./Pages/Facturacion/OrdenEmpleado.jsx";
import Profile from "./Pages/User/Profile/ProfileC.jsx";
import ShoppingCart from "./Pages/User/ShoppingCart/ShoppingCart.jsx";
import ProductDetails from "./Pages/User/ProductDetails/ProductDetails.jsx";
import SalesFormReportConsult from "./Pages/Admin/SalesInfoRequest/SalesInfoRequest.jsx";
import Drinks from "./Pages/User/Drinks/Drinks.jsx";
import Skate from "./Pages/User/Skate/Skate.jsx";
import Snacks from "./Pages/User/Snacks/Snacks.jsx";
import LayoutConsulta from "./Pages/Admin/Consultas/layoutConsulta.jsx";
import SignE from "./Pages/Admin/LoginSignUpE/SignUpEmpleado.jsx";
import LoginE from "./Pages/Admin/LoginSignUpE/LoginEmpleado.jsx";
import CustomService from "./Pages/User/CustomerService/CustomService.jsx";
import Complaints from "./Pages/Admin/CustomerService/AnswerComplaints.jsx";
import Busqueda from "./Pages/User/FiltroBusqueda/busqueda.jsx";
import BusquedaEmpleado from "./Pages/Admin/FindEmployee/FindEmployee.jsx";
import Planilla from "./Pages/Admin/Planilla/planilla.jsx";
import PerformanceReport from "./Pages/Admin/Performance/performance.jsx";

import { AuthProvider } from "./contexts/auth.jsx";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import { ProtectedRoute } from "./ProtectedRoute.jsx";


function Router() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/registroCliente" element={<SignC />}></Route>
          <Route path="/inicioSesionCliente" element={<LoginC />}></Route>
          <Route path="/inicioSesionEmpleado" element={<LoginE />}></Route>
          <Route path="/registroEmpleado" element={<SignE />}></Route>
          <Route path="/productDetail" element={<ProductDetails />}></Route>
          <Route path="/Busqueda" element={<Busqueda />}></Route>
          <Route path="/snacks" element={<Snacks />}></Route>
          <Route path="/answerComplaints" element={<Complaints />}></Route>
          <Route path="/BusquedaEmployee" element={<BusquedaEmpleado />}></Route>
          <Route path="/ordenesEmpleado" element={<OrdenesEmpleado />}></Route>
          <Route path="/ordenesCliente" element={<Ordenes />}></Route>
          <Route path="/ordenesCliente" element={<Ordenes />}></Route>
          <Route path="/planillaEmployee" element={<Planilla />}></Route>
          <Route path="/performance" element={<PerformanceReport />}></Route>
          <Route path="/Consulta" element={<LayoutConsulta />}></Route>

          <Route element={<ProtectedRoute />}>
            <Route path="/main" element={<MainPage />}> </Route>
            <Route path="/Receipt" element={<Receipt />}></Route>
            <Route path="/ordenesCliente" element={<Ordenes />}></Route>
            <Route path="/ordenesEmpleado" element={<OrdenesEmpleado />}></Route>
            <Route path="/profileCliente" element={<Profile />}></Route>
            <Route path="/clothes" element={<Clothes />}></Route>
            <Route path="/snacks" element={<Snacks />}></Route>
            <Route path="/drinks" element={<Drinks />}></Route>
            <Route path="/skate" element={<Skate />}></Route>
            <Route path="/Buying" element={<BuyingPage />}></Route>
            <Route path="/shoppingCart" element={<ShoppingCart />}></Route>
            <Route path="/SalesReport" element={<SalesFormReportConsult />}></Route>
            <Route path="/CustomService" element={<CustomService />}></Route>
            
          </Route>
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  );
}

export default Router;
