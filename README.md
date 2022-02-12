# Robot cartografo
##  Integrantes
* Daniel Alejandro Gaspar
* Juan Jose Herera Rodriguez
* Javier Leonardo Rodriguez Sandoval


##  Introducción

En el presente repositorio se encuentra la documentación del proyecto propuesto en la asignatura Electrónica Digital II, 2021-2, grupo 7. Se trata de un robot controlado mediante una FPGA (Nexys A7) el cual sigue un camino y se detiene periódicamente para inspeccionar los obtaculos que se encuentran su alrededor, después el robot analiza los datos y toma la decisión que se necesita para el movimiento, mapeando así la información de la pista de obstaculos.

![Robot](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/WhatsApp%20Image%202022-01-27%20at%2011.39.49%20AM.jpeg "Robot cartógrafo")

Queremos aclarar que la sección del SoC se encuentra más abajo en "módulos", allí está explicado su funcionamiento y su respectivo mapa de memoria y caja negra, así mismo se podrá encontrar esta informacion para otros módulos en la misma sección.

## Materiales 

Los materiales necesarios para la elaboración del robot cartografo  son:
* FPGA Nexys A7
* 1 Modulo camara OV767
* 1 Sensor de temperatura DTH11
* 1 Ultrasonido HC-SR04
* 1 Puente HL298N
* 1 Bluetooth HC-05
* 5 sensores infrarrojos
* 1 puente H L298N
* 1 mini Protoboard
* 2 Motorreductores con ruedas
* 1 Servomotor
* Protoboard


##  Modulos del proyecto

Para la elaboración de este proyecto fué necesaria la integración de distintos modulos o perifericos,a continuación se presenta una lista con todos ellos,en donde se analisará su utilidad,estructura,mapas de memoria y observaciones generales de cada periferico.

* [SOC](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/SOC.md "título del enlace aquí")
* [Sensor de temperatura](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Sensor%20de%20temperatura.md "título del enlace aquí")
* [Radar](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Radar.md "título del enlace aquí")
* [Modulo de camara](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Camara.md "aquí")
* [Motores](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Ruedas.md "Notores")
* [Otros modulos](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Otros%20modulos.md "título del enlace aquí")
## Evidencias de implementación
Finalmente luego de realizar una retroalimentación de lo realizado a lo largo del proyecto,se presenta un video con el tester de cada modulo utilizado.
 [Funcionamiento del robot](https://www.youtube.com/watch?v=a3cBYZyUI-o&ab_channel=DanielGaspar "Funcionamiento del robot")
