#	Radar

Localizador de obstáculos y mapeo
Capaz de encontrar barreras y crear un mapa haciendo uso del servomotor y el ultrasonido, posterior a esto envía los datos por el BUS a su debido procesamiento.

##	Mapa de memoria
![Mapa de memoria radar](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_radar.png "Mapa de memoria radar")

##	Caja negra

![Caja negra radar](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Caja%20negra%20radar.png "Caja negra radar")

##	Ultra Sonido
Se usó un ultrasonido de referencia HC-SR04 con el fin de que el robot cartógrafo sea capaz de identificar obstaculos alrededor de si mismo, de esta manera los datos estarán disponibles para su posterior procesamiento.

![Ultra Sonido](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/sensor-ultrasonido-hc-sr04.jpg "Ultra sonido")

###	Diagrama de tiempo
El HC-SR04 requiere de un pulso TRIGGER y uno ECHO para funcionar correctamente, como se muestra a continuación:

![Diagrama de tiempo HC-SR04](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Diagrama-tempo-hc-sr04.png "Diagrama de tiempo HC-SR04")

###	Caja negra

![Caja negra ultrasonido](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_%20ultrasonido.png "Caja negra ultrasonido")

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

##	Servomotor
Es el encargado de permitir el giro del Ultra sonido, es decir hace las veces de cuello, si hacemos la analogía con la anatomía humana, es importante programarlo correctamente para un buen reconocimiento del entorno al momento de la prueba, usamos la referencia SG90S pues se adaptaba bien a las necesidades de los ángulos a escanear en el proyecto.

![Servomotor SG90S](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Servomotor%20SG90S.jpg "Servomotor SG90S")

###	Caja negra

![Caja negra SG90S](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Caja%20negra%20SG90S.png "Caja negra SG90S")

###	Test
```
static void pwm_test(void)
{  
        printf("Test del pwm... se interrumpe con el botton 1\n");
        while(!(buttons_in_read()&1)) {
        //pwm_cntrl_orden_write(4);
	//delay_ms(3000);
	pwm_cntrl_orden_write(5);
	delay_ms(3000);
	pwm_cntrl_orden_write(4);
	delay_ms(3000);
	pwm_cntrl_orden_write(6);
	delay_ms(3000);
	pwm_cntrl_orden_write(4);
	delay_ms(3000);
	
	}
}
```
###	Código
```
`timescale 1ns / 1ps
module PWMUS(clk, servo, pos);
input clk;
input [1:0]pos;
output reg servo;

reg [20:0]contador = 0;

always@(posedge clk)begin
	contador = contador + 1;
	if(contador =='d1_000_000) begin
	   contador = 0;
	end
	
	case(pos)
        2'b00:  servo = (contador < 'd50_000) ? 1:0;
        
        2'b01:  servo = (contador < 'd150_000) ? 1:0;
        
        2'b10:  servo = (contador < 'd250_000) ? 1:0;
        
        default:servo = (contador < 'd50_000) ? 1:0;
    endcase

end
endmodule
```
