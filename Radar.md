#	Radar

Localizador de obstáculos y mapeo
Capaz de encontrar barreras y crear un mapa haciendo uso del servomotor y el ultrasonido, posterior a esto envía los datos por el BUS a su debido procesamiento.

##	Mapa de memoria
![Mapa de memoria radar](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_radar.png "Mapa de memoria radar")¡

##	Caja negra

!Caja negra radar](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_radar.png "Caja negra radar")¡

##	Ultra Sonido
###Modelo
Se usó un ultrasonido de referencia HC-SR04 con el fin de que el robot cartógrafo sea capaz de identificar obstaculos alrededor de si mismo, de esta manera los datos estarán disponibles para su posterior procesamiento.

![Ultra Sonido](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/sensor-ultrasonido-hc-sr04.jpg "Ultra sonido")¡

###	Diagrama de tiempo
El HC-SR04 requiere de un pulso TRIGGER y uno ECHO para funcionar correctamente, como se muestra a continuación:

![Diagrama de tiempo HC-SR04](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Diagrama-tempo-hc-sr04.png "Diagrama de tiempo HC-SR04")¡

###	Test
```
static int test_us(void){

        int d;
        
		ultrasonido_orden_write(1);
		bool done = false;
		while(!done){
			done = ultrasonido_done_read();
		}
		d=ultrasonido_d_read();
		ultrasonido_orden_write(0);
		return d;
```
###	Código
```
`timescale 1ns / 1ps
module ultraSound(  input clk, 
                    input init, 
                    input echo,
                    output reg trig,
                    output reg [8:0] distance,
                    output reg done);

reg [14:0]counter = 0;
reg echoStart = 0;
reg [1:0]status = 0;
wire newCLK;

// Clock de 1MHz para que el periodo sea de 1 us.
divFreq freq1(clk, newCLK, 'd50);

parameter Start = 0, Pulse = 'd1, Echo = 'd2;
always @ (posedge newCLK)begin

    case(status)
        Start:  begin
                    // Cuando init es 1, se colocan los registros en 0.
                    if(init) begin
                        done = 0;
                        counter = 0;
                        distance = 0;
                        status = Pulse;
                    end
                end
        Pulse:  begin
                    // Trig se pone en 1 por 11 us, luego se coloca en 0.
                    trig = 1'b1;
                    counter = counter + 1'b1;
                        if(counter == 'd11)begin
                            trig = 0;
                            counter = 0;
                            status = Echo;
                        end
                end
        Echo:   begin
                    // Se espera a que echo sea 1, luego se contabiliza el tiempo hasta que echo sea 0.
                      if(echo)begin
                        echoStart = 1;
                        counter = counter + 1'b1;
                      end
                      if(echo == 0 && echoStart == 1)begin
                        
                        // Si el contador es 0, se vuelve al estado anterior hasta que el resultado sea diferente a 0.
                        if(counter == 0) status = Pulse;
                        else begin
                            // Se divide el contador entre 58 para encontrar la distancia
                            distance = counter/'d58;
                            status = Start;
                            done = 1;
                        end
                      end
                end
    endcase 
end

endmodule
```
