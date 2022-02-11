
# SOC
El proyecto analisado a lo largo de este documento tiene como proposito principal la aplicación en practica del desarrollo de un System on Chip (Soc) el cual consistiria en integrar diversos modulos  entre ellos camara,sensor de temperatura,bluetooh,radad,servomotores entre otros. para cumplir con este proposito se hizo uso de la herramienta litex en donde se logró agrupar cada modulo para crar hadware e implementarlo en la FPGA.

# Mapas de memoria
A continuación se ilustra el mapa general del proyecto con cada periferico a implementar.

![Robot](https://github.com/unal-edigital2-labs/wp08-2021-2-gr07/blob/main/Imagenes%20github/MP_SOC.png "Robot cartógrafo")

# Codigo implementado

Finalmente se presenta el codigo generado durante la implementación de los perifericos a la estructura general del proyecto.
```
class BaseSoC(SoCCore):
	def __init__(self):
		platform = tarjeta.Platform()
		
		## add source verilog

		
		platform.add_source("module/verilog/divFreq.v")
		platform.add_source("module/verilog/ultraSound.v")
		platform.add_source("module/verilog/PWMUS.v")
		platform.add_source("module/verilog/infraRed.v")
		platform.add_source("module/verilog/wheels.v")
		platform.add_source("module/verilog/DHT11.v")
		
		# SoC with CPU
		SoCCore.__init__(self, platform,
 			cpu_type="picorv32",
#			cpu_type="vexriscv",
			clk_freq=100e6,
			integrated_rom_size=0x10000,
			integrated_main_ram_size=16*1024)

		# Clock Reset Generation
		self.submodules.crg = CRG(platform.request("clk"), ~platform.request("cpu_reset"))

		# Leds
		SoCCore.add_csr(self,"leds")
		user_leds = Cat(*[platform.request("led", i) for i in range(10)])
		self.submodules.leds = gpio.GPIOOut(user_leds)
		
		# Switchs
		SoCCore.add_csr(self,"switchs")
		user_switchs = Cat(*[platform.request("sw", i) for i in range(8)])
		self.submodules.switchs = gpio.GPIOIn(user_switchs)
		
		# Buttons
		SoCCore.add_csr(self,"buttons")
		user_buttons = Cat(*[platform.request("btn%c" %c) for c in ['c','r','l']])
		self.submodules.buttons = gpio.GPIOIn(user_buttons)
		
		# 7segments Display
		SoCCore.add_csr(self,"display")
		display_segments = Cat(*[platform.request("display_segment", i) for i in range(8)])
		display_digits = Cat(*[platform.request("display_digit", i) for i in range(8)])
		self.submodules.display = sevensegment.SevenSegment(display_segments,display_digits)

		# RGB leds
		SoCCore.add_csr(self,"ledRGB_1")
		self.submodules.ledRGB_1 = rgbled.RGBLed(platform.request("ledRGB",1))
		
		SoCCore.add_csr(self,"ledRGB_2")
		self.submodules.ledRGB_2 = rgbled.RGBLed(platform.request("ledRGB",2))
		
				
		# VGA
		SoCCore.add_csr(self,"vga_cntrl")
		vga_red = Cat(*[platform.request("vga_red", i) for i in range(4)])
		vga_green = Cat(*[platform.request("vga_green", i) for i in range(4)])
		vga_blue = Cat(*[platform.request("vga_blue", i) for i in range(4)])
		self.submodules.vga_cntrl = vgacontroller.VGAcontroller(platform.request("hsync"),platform.request("vsync"), vga_red, vga_green, vga_blue)
	


		#ultraSound
		SoCCore.add_csr(self,"ultraSound_cntrl")
		self.submodules.ultraSound_cntrl = ultraSound.US(platform.request("echo"), 	platform.request("trig"))
		
		#Dht11
		SoCCore.add_csr(self,"DHT11_cntrl")
		self.submodules.DHT11_cntrl = DHT11.DHT11(platform.request("Inicio"), 	platform.request("Data"))
		
		#PWMUS
		SoCCore.add_csr(self,"PWMUS_cntrl")
		self.submodules.PWMUS_cntrl = PWMUS.servoUS(platform.request("servo"))

		#infraRed
		SoCCore.add_csr(self,"IR_cntrl")	
		self.submodules.IR_cntrl = infraRed.infra(platform.request("iR"), platform.request("iRC"), platform.request("iC"), platform.request("iLC"), platform.request("iL"))

		#Wheels
		SoCCore.add_csr(self,"wheels_cntrl")
		right = Cat(*[platform.request("right", i) for i in range(2)])
		left = Cat(*[platform.request("left", i) for i in range(2)])
		self.submodules.wheels_cntrl = wheels.wheels(right, left)

		#UART BLUETHOOT
		from litex.soc.cores import uart
		self.submodules.uart1_phy = uart.UARTPHY(
			pads     = platform.request("uart1"),
			clk_freq = self.sys_clk_freq,
			baudrate = 9600)
		self.submodules.uart1 = ResetInserter()(uart.UART(self.uart1_phy,
			tx_fifo_depth = 16,
			rx_fifo_depth = 16))
		self.csr.add("uart1_phy", use_loc_if_exists=True)
		self.csr.add("uart1", use_loc_if_exists=True)
		if hasattr(self.cpu, "interrupt"):
			self.irq.add("uart1", use_loc_if_exists=True)
		else:
			self.add_constant("UART_POLLING")
 ```
 

