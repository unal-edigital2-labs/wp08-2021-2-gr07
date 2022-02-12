from migen import *
from migen.genlib.cdc import MultiReg
from litex.soc.interconnect.csr import *
from litex.soc.interconnect.csr_eventmanager import *

class DHT11(Module, AutoCSR):
	def __init__(self, Data, Inicio):
		self.clk = ClockSignal()
		self.init = CSRStorage(1)
		self.Data = Data
		self.Inicio = Inicio
		self.temp = CSRStatus(8)
		self.done = CSRStatus(1)
		self.specials += Instance("DHT11", i_clk = self.clk, i_Data = self.Data, o_Inicio = self.Inicio, o_temp = self.temp.status)
