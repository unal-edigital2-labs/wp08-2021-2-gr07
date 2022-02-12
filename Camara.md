
# Camara
Para la implementación de la camara se hará uso de una camara de referencia OV7670,es un modulo pequeño de dimensiones 640x480 para formatos VGA,se espera que este modulo pueda enviar enviar la información captada sin hacer uso de una memoria.

![Robot](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/stm32.png "Robot cartógrafo")

# Mapas de memoria
El mapa de memoria posible dado si se hubiera implementado se ilustra a continuación

![OV7670](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_Camara.png "OV7670")
# Codigo implementado
```
assign dataR = data[7:5];
assign dataG = data[4:2];
assign dataB = {data[2:0],1'b0};

always @(posedge clk)begin
		if(init && !init_old)begin
			start <= 1;
			done <= 0;
			sumaR <= 0;
			sumaG <= 0;
			sumaB <= 0;
		end
	if(start)begin
		if(count >= 19200)begin
			start <= 0;
			count <= 0;
			addr <= 15'h7fff;
			done <= 1;
			if((sumaR > sumaG) && (sumaR > sumaB))begin
				res = 3'b100;
			end else begin
				if((sumaG > sumaR) && (sumaG > sumaB))begin
				res = 3'b010;
				end else begin
					if((sumaB > sumaR) && (sumaB > sumaG))begin
						res = 3'b001;
					end else begin
						res =3'b111; //No hay ninguno mayor
					end
				end
			end
		end else begin
			addr <= addr+1;
			count <= count+1;
			sumaR <= #1 sumaR+dataR;
			sumaG <= #1 sumaG+dataG;
			sumaB <= #1 sumaB+dataB;
			done <= 0;
		end
	end 
	init_old = init;
end
 ```

# Observaciones generales
Se realizó la implementación de la camara con diversos codigos de los repositorios de grupos anteriores a este se le modificó de acuerdo a criterior personales sin embargo,no fue posible hacer funcionar este componente, se cree que es debido a daños fisicos del componente, a causa del corto tiempo disponible no fue una una opción pedir un reemplazo, pues este módulo fue ordenado por mercadolibre y una devolución para este caso tomaba más tiempo del que contabamos para la presentación del proyecto en cuestión.
