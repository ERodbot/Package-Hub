import { createContext, useState, useContext, useEffect } from "react";


const CarritoContext = createContext();

export const useCarrito = () => {
    const context = useContext(CarritoContext);
    if (!context) {
        throw new Error("useCarrito must be used within an CarritoProvider");
    }
    return context;
    }

export const CarritoProvider = ({ children }) => {
    const [products, setProducts] = useState([]);
    const [total, setTotal] = useState(0);
    const [subtotal, setSubtotal] = useState(0);
    const [envio, setEnvio] = useState(0);

    useEffect(() => {
        console.log(products);
        console.log(envio);
        actualizarTotal();
    }, [products, envio]);

    const recibirEnvio = (envio) => {
        setEnvio(envio);
    }

    const agregarProducto = (product) => {
        console.log(product)
        const existingProduct = products.find((p) => p.name === product.name);

        if (existingProduct) {
            const updatedProducts = products.map((p) =>
            p.name === product.name
                ? { ...p, unitsPurchased: product.unitsPurchased }
                : p
            );
            setProducts(updatedProducts);
        } else {
            setProducts([...products, product]);
        }
        setSubtotal(subtotal + product.price * product.unitsPurchased);
        alert("Producto agregado al carrito");
    };
    // setSubtotal={setSubtotal}
    // setTotal={setTotal}
    

    const deleteElement = (productName) => {
        // Find the product with the given name
        const selectedProduct = products.find(
            (product) => product.name === productName
        );
    
        if (selectedProduct) {
            const updatedProducts = products.map((product) =>
            product.name === productName
                ? {
                    ...product,
                    unitsPurchased: Math.max(product.unitsPurchased - 1, 0),
                }
                : product
            );
    
          // Filter out products with quantity 0
            const filteredProducts = updatedProducts.filter(
            (product) => product.unitsPurchased > 0
            );
    
          // Calculate the total price based on the updated products
            const total = filteredProducts.reduce(
            (acc, product) => acc + product.price * product.unitsPurchased,
            0
            );
    
          // Update the state with the updated products and total price
            setProducts(filteredProducts);
            setTotal(total);
        }
    };

    const actualizarTotal = () => {
        const total = products.reduce(
            (acc, product) => acc + product.price * product.unitsPurchased,
            0
        );
        setTotal(total + envio);
    };

    return (
        <CarritoContext.Provider value={{ 
        products, 
        total, 
        agregarProducto, 
        deleteElement,  
        setSubtotal, 
        setTotal,
        total,
        subtotal,
        recibirEnvio
        }}>
            {children}
        </CarritoContext.Provider>
    );
}