import { createContext, useState, useContext, useEffect } from "react";
import Cookies from "js-cookie";
import { loginRequest, verifyToken, loginEmployee } from "../api/auth";
import { useNavigate } from "react-router";

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [loading, setLoading] = useState(true);

  const iniciar_sesion = async (formData) => {
    try {
      const res = await loginRequest(formData);
      setUser(res.data);
      setIsAuthenticated(true);
    } catch (err) {
      console.log(err);
    }
  };

  const iniciarSesionEmpleado = async (formData) => {
    try {
      const res = await loginEmployee(formData);
      setUser(res.data);
      setIsAuthenticated(true);
    } catch (err) {
      console.log(err);
    }
  }

  const logout = () => {
    Cookies.remove("token");
    setUser(null);
    setIsAuthenticated(false);
  };

  useEffect(() => {
    const checkLogin = async () => {
      const cookies = Cookies.get();
      if (!cookies.token) {
        setIsAuthenticated(false);
        setLoading(false);
        return setUser(null);
      }

      try {
        const res = await verifyToken(cookies.token);
        if (!res.data) {
          setIsAuthenticated(false);
          setLoading(false);
          return;
        }
        setUser(res.data);
        setIsAuthenticated(true);
        setLoading(false);
      } catch (error) {
        setIsAuthenticated(false);
        setUser(null);
      }
    };
    checkLogin();
  }, []);

  return (
    <AuthContext.Provider
      value={{
        user,
        iniciar_sesion,
        isAuthenticated,
        logout,
        loading,
        iniciarSesionEmpleado
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export default AuthContext;
