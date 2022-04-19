/*
    Consigna:
    
    Input de una cadena
    Se lee de a 1 carácter
    La salida es:
        - Si es una letra mayúscula, se imprime la letra en minúscula
        - Si es una letra minúscula, se imprime la letra en mayúscula
        - Si es un dígito decimal, no copiarlo a la salida
        - Todos los demás caracteres se copian sin modificar

    Comentarios adicionales:
        - Se lee el texto usando getchar
        - Se recomienda el uso de funciones pertenecientes a ctype.h
        - Debe compilar en el estándar C11 o C17
        - NO debe usar funciones propias de un SO en particular
*/

#include <stdio.h>
#include <ctype.h>

int main(void)
{
    char cadena;
    printf("\nEnter a string \n");
    while ((cadena = getchar()) != '\n')
    {
        if (isalpha(cadena))
        {
            if (isupper(cadena))
            {
                putchar(tolower(cadena));
            }
            if (islower(cadena))
            {
                putchar(toupper(cadena));
            }
        } else if(!isalnum(cadena)){
            putchar(cadena);
        }
    }
}