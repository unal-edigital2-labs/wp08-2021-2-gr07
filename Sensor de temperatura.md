
# Sensor de temperatura
## SHT31
Para este proyecto se ha elegido añadir un nuevo periferico,el cual consiste en un sensor de temperatura,un complemento ideal para la tipologia 
de este proyecto,este será conectado por I2C al bus Wish.

![sht31](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/MP_Sensor_Temperatura "Sensor temperatura")

##L298N
Se eligió porque está diseñado para el movimoento de carros y es sencillo de programar e implementar gracias a su distibución de valores de registro y su mapa de memoria sencillo, además tiene un puente H específicamente para aplicaciones que implican avanzar, retroceder o dar un giro de manera eficiente.

![L298N](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/L298N.png "L298N")

En las salidas A y B se conectan los dos motores, los cuales funcionaran con el voltaje de la fuente Vin que se conecte. P ara el control digital se debe tener una tierra común entre la FPGA y la fuente y enviar un uno o cero lógicos en las entradas IN1 a IN4, por lo que la entrada digital será de 4 Bits. Estos bits se programan en Verilog como un registro igualado a la salida.

## Mapas de memoria
Se ocuparon 4 bits para el movimiento de los motores, a continuación se muestra el cómo:

![Mapa de memoria del motor](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_motor.png "Mapa de memoria del motor")

## Test de prueba
Se usó el siguiente código en el lenguaje C con el fin de probar el funcionamiento del motor:

