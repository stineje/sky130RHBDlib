import pya

cells = ['OR2X1.gds','and2x1_pcell.gds','voter3x1_pcell.gds','HA.gds','TMRDFFQX1.gds','NOR2X1.gds','aoi3x1_pcell.gds','nand3x1_pcell.gds','DFFSNRNQNX1.gds','TMRDFFQNX1.gds','aoai4x1_pcell.gds','NAND3X1.gds','XOR2X1.gds','li1_M1_contact.gds','DLATCH.gds','AOI3X1.gds','DFFSNRNQX1.gds','FA.gds','TMRDFFSNRNQNX1.gds','TMRDFFSNQX1.gds','mux2x1_pcell.gds','dffrnx1_pcell.gds','dffx1_pcell.gds','nmos_side_left.gds','DFFSNRNX1.gds','nor2x1_pcell.gds','BUFX1.gds','bufx1.gds','nmos_top_trim1.gds','TMRDFFRNQX1.gds','TMRDFFRNQNX1.gds','pmos2_1.gds','nmos_top_trim2.gds','FILL1.gds','ao3x1_pcell.gds','INVX1.gds','dffsnrnx1_pcell.gds','nmos_bottom.gds','votern3x1_pcell.gds','DLATCHN.gds','DFFSNX1.gds','AOA4X1.gds','MUX2X1.gds','nmos_top.gds','xor2X1_pcell.gds','dffsnx1_pcell.gds','DFFSNQNX1.gds','TMRDFFSNRNQX1.gds','TIEHI.gds','pmos2.gds','nor3x1_pcell.gds','DFFRNQX1.gds','invx1_pcell.gds','and3x1_pcell.gds','DFFRNX1.gds','or2x1_pcell.gds','xnor2x1_pcell.gds','inv.gds','DFFRNQNX1.gds','XNOR2X1.gds','or3x1_pcell.gds','DFFX1.gds','VOTER3X1.gds','nand2x1_pcell.gds','DFFQX1.gds','TMRDFFSNQNX1.gds','poly_li1_contact.gds','TIELO.gds','AND3X1.gds','aoa4x1_pcell.gds','AND2X1.gds','OR3X1.gds','DFFQNX1.gds','DFFSNQX1.gds','nmos_side_right.gds','AOAI4X1.gds','VOTERN3X1.gds','NAND2X1.gds','NOR3X1.gds','diff_ring_side.gds']

layout = pya.Layout()
lmap = layout.read("AO3X1.gds")
TOP = layout.top_cell()
load_options = pya.LoadLayoutOptions()
load_options.text_enabled = True
load_options.set_layer_map(lmap, True)

for cell in cells:
	layout.read(f"{cell}", load_options)

layout.write("merged.gds")
