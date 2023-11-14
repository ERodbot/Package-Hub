import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "./contexts/auth";

export const ProtectedRoute = () => {
  const { isAuthenticated, loading} = useAuth();

  if(loading) return <h1></h1>;
  if (!isAuthenticated) return <Navigate to="/inicioSesionCliente" replace />;
  return <Outlet />;
};
