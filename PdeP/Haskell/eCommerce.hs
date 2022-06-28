{-
    Prefiero utilizar Data en lugar de tuplas para practicar su funcionamiento.
    El dato creado va a constar de 2 elementos (nombreProducto y precio).
    La cantidad, el descuento y el costo de envio serán datos agregados por teclado, intentando simular lo mejor posible una compra.
    
    Alumno: Federico Vicente Cano
    Curso:  K2001
-}

import Data.Char

data Producto = UnProducto {
    nombreProducto :: String,
    precio :: Float
} deriving (Show)

-- Agrego unos productos para probar el funcionamiento de todas las funciones
silla   :: Producto
silla   = UnProducto "Silla" 653.99

luz     :: Producto
luz     = UnProducto "Luz" 10.00

mesaL   :: Producto
mesaL   = UnProducto "Mesa Luxury Z" 789.99

sillon  :: Producto
sillon  = UnProducto "Super sillon de plumas sinteticas" 366.52

-- Uso type alias para etiquetar tipos de datos que se van a usar en las funciones, de modo que al leerlas sean más fáciles de entender.
type Descuento = Float
type Cantidad = Int
type CostoEnvio = Int

-- Funciones adicionales
    {-  Intenté derivar todas las funciones en subfunciones para una mayor expresividad, ocultando detalle algorítmico. Con algunas pude hacerlo, pero con otras 
        llegaba al punto en el que terminaba realizando funciones con el mismo detalle algorítmico que las principales, terminando con el doble de funciones y
        un detalle algorítmico casi equivalente. -}

calcularDescuento       :: Producto -> Descuento -> Float
calcularDescuento unProducto descuento = (descuento * precio unProducto) / 100

calculoPrecioYCantidad  :: Cantidad -> Producto -> Producto
calculoPrecioYCantidad cantidad unProducto = unProducto {precio = precio unProducto * fromIntegral cantidad}

contieneLetra           :: Char -> Producto -> Bool
contieneLetra unaLetra unProducto = (elem . toLower $ unaLetra) . map toLower . nombreProducto $ unProducto

-- Funciones pedidas

aplicarDescuento        :: Producto -> Descuento -> Producto
aplicarDescuento unProducto descuento = unProducto {precio = precio unProducto - calcularDescuento unProducto descuento}

aplicarCostoDeEnvio     :: CostoEnvio -> Producto -> Producto
aplicarCostoDeEnvio costoEnvio unProducto = unProducto {precio = precio unProducto + fromIntegral costoEnvio}

precioTotal             :: Producto -> Cantidad -> Descuento -> CostoEnvio -> Producto
precioTotal unProducto cantidad descuento costoEnvio = unProducto {precio = precio . aplicarCostoDeEnvio costoEnvio . (calculoPrecioYCantidad cantidad) . aplicarDescuento unProducto $ descuento}

entregaSencilla         :: String -> Bool
entregaSencilla unDia = even . length $ unDia

descodiciarProducto     :: Producto -> Producto
descodiciarProducto unProducto = unProducto {nombreProducto = (take 10) . nombreProducto $ unProducto}

versionBarata           :: Producto -> Producto
versionBarata unProducto = unProducto {nombreProducto = reverse . nombreProducto . descodiciarProducto $ unProducto}

productoXL              :: Producto -> Producto
productoXL unProducto = unProducto {nombreProducto = nombreProducto unProducto ++ " XL"}

productoDeLujo          :: Producto -> Bool
productoDeLujo unProducto = contieneLetra 'x' unProducto && contieneLetra 'z' unProducto

productoCodiciado       :: Producto -> Bool
productoCodiciado unProducto = length (nombreProducto unProducto) > 10

productoCorriente       :: Producto -> Bool
productoCorriente unProducto = flip elem "AEIOUaeiou" . head . nombreProducto $ unProducto

productoDeElite         :: Producto -> Bool
productoDeElite unProducto = productoDeLujo unProducto && productoCodiciado unProducto && not (productoCorriente unProducto)