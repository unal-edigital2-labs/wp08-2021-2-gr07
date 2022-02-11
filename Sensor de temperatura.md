
# Sensor de temperatura
## DHT11
Para este proyecto se ha elegido añadir un nuevo periferico,el cual consiste en un sensor de temperatura,un complemento ideal para la tipologia 
de este proyecto,este será conectado por I2C al bus Wish.




![S_temperatura](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/DHT11.png "S_temperatura")

# Mapas de memoria


![Robot](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/MP_Sensor_Temperatura.png "Robot cartógrafo")

# Codigo e implementación

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

# Test de prueba
