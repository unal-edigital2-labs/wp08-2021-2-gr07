
# Sensor de temperatura
## DHT11
Para este proyecto se ha elegido añadir un nuevo periferico,el cual consiste en un sensor de temperatura,un complemento ideal para la tipologia 
de este proyecto,este será conectado por I2C al bus Wish.




![S_temperatura](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/DHT11.png "S_temperatura")

# Mapa de memoria

![Mapa_DHT11](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/Mapa_DHT11.png "Mapa_DHT11")

# Codigo python para la implementación

```

class DHT11(Module, AutoCSR):
	def __init__(self, Data, Inicio):
		self.clk = ClockSignal()
		self.init = CSRStorage(1)
		self.Data = Data
		self.Inicio = Inicio
		self.temp = CSRStatus(8)
		self.done = CSRStatus(1)
		self.specials += Instance("DHT11", i_clk = self.clk, i_Data = self.Data, o_Inicio = self.Inicio, o_temp = self.temp.status)

```
# Codigo verilog
```

`timescale 1ns / 1ps


module DHT11(input clk,input init,input Data,output reg Inicio,output reg [7:0] temp,output reg done);  

reg [7:0] part0;
reg [7:0] part1;
reg [13:0] counter;
reg [13:0] count;
reg [7:0] hum;
reg [23:0] periodo;
wire newCLK;

divFreq freq1(clk, newCLK, 2_777_777);



always @(posedge newCLK)begin // clk1k es de 9 Hz, esto para leer datos entre intermedios de envios ya que cada envio se programo para 125 ms, asi no haya cruce en limites
if (init) begin
if (count>16) begin // Con entrada de 8 bits en un segundo de arduino, se garantiza la lectura sin cruces
	count=0;
	Inicio<=0; // Cierra inicio de envio de datos del arduino
	end

	if(count == 1 && Inicio == 1)begin // Se garantiza cuando se inicia envio datos se reciba cada 111 ms una lectura de bit
	part0[1]=Data;
	end
	
	if(count == 2 && Inicio == 1)begin
	part0[2]=Data;
	end
	
	if(count == 3 && Inicio == 1)begin
	part0[3]=Data;
	end
	
	if(count == 4 && Inicio == 1)begin
	part0[4]=Data;
	end
	
	if(count == 5 && Inicio == 1)begin
	part0[5]=Data;
	end
	
	if(count == 6 && Inicio == 1)begin
	part0[6]=Data;
	end
	
	if(count ==	7 && Inicio == 1)begin
	part0[7]=Data;
	end
	
	if(count == 8 && Inicio == 1)begin // Se garantiza cuando se inicia envio datos se reciba cada 111 ms una lectura de bit
	part1[0]=Data;
	end
	
	if(count == 9 && Inicio == 1)begin
	part1[1]=Data;
	end
	
	if(count == 10 && Inicio == 1)begin
	part1[2]=Data;
	end
	
	if(count == 11 && Inicio == 1)begin
	part1[3]=Data;
	end
	
	if(count == 12 && Inicio == 1)begin
	part1[4]=Data;
	end
	
	if(count == 13 && Inicio == 1)begin
	part1[5]=Data;
	end
	
	if(count ==	14 && Inicio == 1)begin
	part1[6]=Data;
	end
	
	if(count ==	14 && Inicio == 1)begin
	part1[7]=Data;
	end
	
	count=count+1;

	
	if (periodo > 80) begin // Tiempo de espera entre envios de 5 segundos para permitir descargue completo de valores
	Inicio<=1;
	periodo=0;
	count=0;
	done=1;
	part0[0]=0;
	temp={part0[0],part0[1],part0[2],part0[3],part0[4],part0[5],part0[6],part0[7]}; // Se guardan los 8 bits en un arreglo
	end
	
	periodo=periodo+1;
	
	end
end
	
endmodule




```



# Test de prueba
