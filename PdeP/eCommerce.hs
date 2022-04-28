{-
    Prefiero utilizar Data en lugar de tuplas para practicar su funcionamiento.
    El dato creado va a constar de 2 elementos (nombreProducto y precio).
    La cantidad, el descuento y el costo de envio serán datos agregados por teclado, intentando simular lo mejor posible una compra.
    
    Alumno: Federico Vicente Cano
    Curso:  K2001
-}

data Producto = UnProducto {
    nombreProducto :: String,
    precio :: Float
} deriving (Show, Eq)

silla   :: Producto
silla   = UnProducto "Silla" 653.99

luz     :: Producto
luz     = UnProducto "Luz" 10.00

mesaL   :: Producto
mesaL   = UnProducto "Mesa Luxury Z" 789.99

sillon  :: Producto
sillon  = UnProducto "Super sillon de plumas sinteticas" 366.52


-- Funciones adicionales
calcularDescuento       :: Producto -> Float -> Float
calcularDescuento unProducto descuento = (descuento * precio unProducto) / 100

calculoPrecioYCantidad  :: Float -> Producto -> Producto
calculoPrecioYCantidad cantidad unProducto = unProducto {precio = precio unProducto * cantidad}

contieneX               :: Producto -> Bool
contieneX unProducto = (elem 'x' . nombreProducto $ unProducto) || (elem 'X' . nombreProducto $ unProducto)

contieneZ               :: Producto -> Bool
contieneZ unProducto = (elem 'z' . nombreProducto $ unProducto) || (elem 'Z' . nombreProducto $ unProducto)

-- Funciones pedidas

aplicarDescuento        :: Producto -> Float -> Producto
aplicarDescuento unProducto descuento = unProducto {precio = precio unProducto - calcularDescuento unProducto descuento}
--aplicarDescuento unProducto descuento = unProducto {precio = precio unProducto - calcularDescuento unProducto $ descuento}

aplicarCostoDeEnvio     :: Producto -> Float -> Producto
aplicarCostoDeEnvio unProducto costoEnvio = unProducto {precio = precio unProducto + costoEnvio}

precioTotal             :: Producto -> Float -> Float -> Float -> Producto
precioTotal unProducto cantidad descuento costoEnvio = unProducto {precio = precio . flip aplicarCostoDeEnvio costoEnvio . (calculoPrecioYCantidad cantidad) . aplicarDescuento unProducto $ descuento}

entregaSencilla         :: String -> Bool
entregaSencilla unDia = even . length $ unDia

descodiciarProducto     :: Producto -> Producto
descodiciarProducto unProducto = unProducto {nombreProducto = (take 10) . nombreProducto $ unProducto}

versionBarata           :: Producto -> Producto
versionBarata unProducto = unProducto {nombreProducto = reverse . nombreProducto . descodiciarProducto $ unProducto}

productoXL              :: Producto -> Producto
productoXL unProducto = unProducto {nombreProducto = nombreProducto unProducto ++ " XL"}

productoDeLujo          :: Producto -> Bool
productoDeLujo unProducto = contieneX unProducto && contieneZ unProducto

productoCodiciado       :: Producto -> Bool
productoCodiciado unProducto = length (nombreProducto unProducto) > 10

productoCorriente       :: Producto -> Bool
productoCorriente unProducto = flip elem "AEIOUaeiou" . head . nombreProducto $ unProducto

productoDeElite         :: Producto -> Bool
productoDeElite unProducto = productoDeLujo unProducto && productoCodiciado unProducto && not (productoCorriente unProducto)