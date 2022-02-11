# Motor
Este periférico es el encargado de darle movimiento al robot, gracias a los motores que tiene cada rueda logra tener la fuerza suficiente para girar y desplazarse.

![Ruedas](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Ruedas1.jpeg "Ruedas")

## L298N
Se eligió porque está diseñado para el movimoento de carros y es sencillo de programar e implementar gracias a su distibución de valores de registro y su mapa de memoria sencillo, además tiene un puente H específicamente para aplicaciones que implican avanzar, retroceder o dar un giro de manera eficiente.

![L298N](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/L298N.png "L298N")

En las salidas A y B se conectan los dos motores, los cuales funcionaran con el voltaje de la fuente Vin que se conecte. P ara el control digital se debe tener una tierra común entre la FPGA y la fuente y enviar un uno o cero lógicos en las entradas IN1 a IN4, por lo que la entrada digital será de 4 Bits. Estos bits se programan en Verilog como un registro igualado a la salida.

## Mapas de memoria
Se ocuparon 4 bits para el movimiento de los motores, a continuación se muestra el cómo:

![Mapa de memoria del motor](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_motor.png "Mapa de memoria del motor")

## Test de prueba
Se usó el siguiente código en el lenguaje C con el fin de probar el funcionamiento del motor:
```
static void motor_test(void)
{
    printf("Test del motor... se interrumpe con el botton 1\n");
        while(!(buttons_in_read()&1)) {
	motor_entrada_write(10); // 1 derecha adelante
	delay_ms(790);
	motor_entrada_write(0); //2 izquierda adelante
	delay_ms(700);
	motor_entrada_write(5); // 4 izquierda atras
	delay_ms(810);
	motor_entrada_write(0); //8 derecha atras
	delay_ms(500);
	
	}
}
```

## Codigo e implementación
Una vez finalizada la prueba y comprobado el buen funcionamiento del módulo se usó el siguiente código en el lenguaje python para asignar los movimientos al motor:
```
`timescale 1ns / 1ps

module wheels(input clk,
            input [2:0]state,
            output reg [1:0]right,
            output reg [1:0]left);
    
always@(posedge clk)begin	
	case(state)
        // Recto
        3'b000:  begin
                    right[0] = 1;
                    right[1] = 0;
                    left[0]  = 1;
                    left[1]  = 0;
                end

        //Derecha
        3'b001:  begin
                    right[0] = 0;
                    right[1] = 0;
                    left[0]  = 1;
                    left[1]  = 0;
                end
        //Izquierda
        3'b010:  begin
                    right[0] = 1;
                    right[1] = 0;
                    left[0]  = 0;
                    left[1]  = 0;
                end
        // Quieto
        3'b011:  begin
                    right[1] = 0;
                    right[0] = 0;
                    left[1]  = 0;
                    left[0]  = 0;
                end

        // Giro 180
        3'b100:  begin
                    right[0] = 0;
                    right[1] = 1;
                    left[0]  = 1;
                    left[1]  = 0;
                end
        // Retroceder
   	    3'b101:  begin
                    right[1] = 1;
                    right[0] = 0;
                    left[1]  = 1;
                    left[0]  = 0;
                end
	endcase
end
endmodule
```
