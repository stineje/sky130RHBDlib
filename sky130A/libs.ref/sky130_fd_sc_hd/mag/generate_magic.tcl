#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .gds    
#--------------------------------------------
crashbackups stop
drc off
locking off
gds datestamp 1645210163
gds readonly true
gds drccheck false
gds flatten true
gds rescale false
tech unlock *
# Set the GDS input style to sky130(vendor).  This treats labels on the
# TXT purpose (5) as pins, which is unfortunately done in a lot of the
# vendor GDS files.
cif istyle sky130(vendor)
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds
puts stdout "Annotating cells from LEF"
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__diode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcin_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcon_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probec_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s4s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1p_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s2s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0p_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrckapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s6s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__conb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd1_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fah_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_bleeder_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fakediode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probe_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvpwrvgnd_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__macro_sparecell.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__decap_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1n_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputisolatch_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0n_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a222oi_1.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/cdl/sky130_fd_sc_hd.cdl}
puts stdout "Writing all magic database files"
writeall force
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__diode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcin_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcon_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probec_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s4s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1p_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s2s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0p_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrckapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s6s_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__conb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd1_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fah_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_bleeder_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fakediode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probe_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvpwrvgnd_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__macro_sparecell.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__decap_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1n_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputisolatch_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_6.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_0.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0n_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a222oi_1.lef
if {[cellname list exists sky130_fd_sc_hd__xor2_2] != 0} {
   load sky130_fd_sc_hd__xor2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux4_4] != 0} {
   load sky130_fd_sc_hd__mux4_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ha_2] != 0} {
   load sky130_fd_sc_hd__ha_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor2_2] != 0} {
   load sky130_fd_sc_hd__xnor2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311ai_4] != 0} {
   load sky130_fd_sc_hd__o311ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtn_2] != 0} {
   load sky130_fd_sc_hd__dlrtn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_2 -toplayer
}
if {[cellname list exists sky130_ef_sc_hd__fill_12] != 0} {
   load sky130_ef_sc_hd__fill_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3b_1] != 0} {
   load sky130_fd_sc_hd__or3b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrbn_1] != 0} {
   load sky130_fd_sc_hd__dlrbn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_1] != 0} {
   load sky130_fd_sc_hd__buf_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21boi_4] != 0} {
   load sky130_fd_sc_hd__a21boi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdlclkp_2] != 0} {
   load sky130_fd_sc_hd__sdlclkp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4b_2] != 0} {
   load sky130_fd_sc_hd__nand4b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31ai_2] != 0} {
   load sky130_fd_sc_hd__o31ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4bb_2] != 0} {
   load sky130_fd_sc_hd__and4bb_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2_4] != 0} {
   load sky130_fd_sc_hd__nor2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__bufbuf_16] != 0} {
   load sky130_fd_sc_hd__bufbuf_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrc_8] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrc_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21bo_4] != 0} {
   load sky130_fd_sc_hd__a21bo_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2b_1] != 0} {
   load sky130_fd_sc_hd__or2b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221o_1] != 0} {
   load sky130_fd_sc_hd__a221o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4b_4] != 0} {
   load sky130_fd_sc_hd__nor4b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111oi_2] != 0} {
   load sky130_fd_sc_hd__a2111oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22oi_1] != 0} {
   load sky130_fd_sc_hd__a22oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32oi_2] != 0} {
   load sky130_fd_sc_hd__a32oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrc_16] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrc_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41a_1] != 0} {
   load sky130_fd_sc_hd__o41a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fill_4] != 0} {
   load sky130_fd_sc_hd__fill_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrtn_1] != 0} {
   load sky130_fd_sc_hd__dfrtn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__diode_2] != 0} {
   load sky130_fd_sc_hd__diode_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__diode_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_8] != 0} {
   load sky130_fd_sc_hd__inv_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfxtp_1] != 0} {
   load sky130_fd_sc_hd__dfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32o_2] != 0} {
   load sky130_fd_sc_hd__a32o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4_4] != 0} {
   load sky130_fd_sc_hd__nor4_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211ai_1] != 0} {
   load sky130_fd_sc_hd__o211ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkbufkapwr_4] != 0} {
   load sky130_fd_sc_hd__lpflow_clkbufkapwr_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux4_1] != 0} {
   load sky130_fd_sc_hd__mux4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211ai_4] != 0} {
   load sky130_fd_sc_hd__o211ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21bo_1] != 0} {
   load sky130_fd_sc_hd__a21bo_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ha_4] != 0} {
   load sky130_fd_sc_hd__ha_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2b_2] != 0} {
   load sky130_fd_sc_hd__and2b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvn_8] != 0} {
   load sky130_fd_sc_hd__einvn_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvn_1] != 0} {
   load sky130_fd_sc_hd__einvn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41o_4] != 0} {
   load sky130_fd_sc_hd__a41o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311ai_1] != 0} {
   load sky130_fd_sc_hd__o311ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2b_1] != 0} {
   load sky130_fd_sc_hd__and2b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21boi_1] != 0} {
   load sky130_fd_sc_hd__a21boi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ai_0] != 0} {
   load sky130_fd_sc_hd__o21ai_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fahcin_1] != 0} {
   load sky130_fd_sc_hd__fahcin_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcin_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fahcon_1] != 0} {
   load sky130_fd_sc_hd__fahcon_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fahcon_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111o_4] != 0} {
   load sky130_fd_sc_hd__a2111o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__edfxtp_1] != 0} {
   load sky130_fd_sc_hd__edfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3_1] != 0} {
   load sky130_fd_sc_hd__or3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrbp_1] != 0} {
   load sky130_fd_sc_hd__dfrbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2o_1] != 0} {
   load sky130_fd_sc_hd__a2bb2o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrtp_2] != 0} {
   load sky130_fd_sc_hd__dfrtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211a_2] != 0} {
   load sky130_fd_sc_hd__o211a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311oi_4] != 0} {
   load sky130_fd_sc_hd__a311oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41o_2] != 0} {
   load sky130_fd_sc_hd__a41o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311o_4] != 0} {
   load sky130_fd_sc_hd__a311o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__probec_p_8] != 0} {
   load sky130_fd_sc_hd__probec_p_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probec_p_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlymetal6s4s_1] != 0} {
   load sky130_fd_sc_hd__dlymetal6s4s_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s4s_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211oi_2] != 0} {
   load sky130_fd_sc_hd__a211oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_6] != 0} {
   load sky130_fd_sc_hd__inv_6
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_6 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_4] != 0} {
   load sky130_fd_sc_hd__buf_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_16] != 0} {
   load sky130_fd_sc_hd__buf_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2oi_4] != 0} {
   load sky130_fd_sc_hd__a2bb2oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2i_2] != 0} {
   load sky130_fd_sc_hd__mux2i_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfbbn_1] != 0} {
   load sky130_fd_sc_hd__dfbbn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4bb_4] != 0} {
   load sky130_fd_sc_hd__and4bb_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2_4] != 0} {
   load sky130_fd_sc_hd__nand2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_inputiso1p_1] != 0} {
   load sky130_fd_sc_hd__lpflow_inputiso1p_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1p_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fill_2] != 0} {
   load sky130_fd_sc_hd__fill_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4b_1] != 0} {
   load sky130_fd_sc_hd__nand4b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfsbp_1] != 0} {
   load sky130_fd_sc_hd__dfsbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinv_4] != 0} {
   load sky130_fd_sc_hd__clkinv_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlygate4sd2_1] != 0} {
   load sky130_fd_sc_hd__dlygate4sd2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfbbn_1] != 0} {
   load sky130_fd_sc_hd__sdfbbn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21boi_0] != 0} {
   load sky130_fd_sc_hd__a21boi_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4_1] != 0} {
   load sky130_fd_sc_hd__and4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3_2] != 0} {
   load sky130_fd_sc_hd__nand3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_decapkapwr_4] != 0} {
   load sky130_fd_sc_hd__lpflow_decapkapwr_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41oi_2] != 0} {
   load sky130_fd_sc_hd__a41oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlymetal6s2s_1] != 0} {
   load sky130_fd_sc_hd__dlymetal6s2s_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s2s_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__tapvgnd2_1] != 0} {
   load sky130_fd_sc_hd__tapvgnd2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31oi_1] != 0} {
   load sky130_fd_sc_hd__a31oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__maj3_1] != 0} {
   load sky130_fd_sc_hd__maj3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21o_4] != 0} {
   load sky130_fd_sc_hd__a21o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3_1] != 0} {
   load sky130_fd_sc_hd__and3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2_8] != 0} {
   load sky130_fd_sc_hd__mux2_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fa_4] != 0} {
   load sky130_fd_sc_hd__fa_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31a_2] != 0} {
   load sky130_fd_sc_hd__o31a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrtp_1] != 0} {
   load sky130_fd_sc_hd__dfrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31o_1] != 0} {
   load sky130_fd_sc_hd__a31o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkbufkapwr_8] != 0} {
   load sky130_fd_sc_hd__lpflow_clkbufkapwr_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4_1] != 0} {
   load sky130_fd_sc_hd__or4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3b_1] != 0} {
   load sky130_fd_sc_hd__nor3b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4b_1] != 0} {
   load sky130_fd_sc_hd__or4b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22o_1] != 0} {
   load sky130_fd_sc_hd__a22o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4_4] != 0} {
   load sky130_fd_sc_hd__nand4_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor3_1] != 0} {
   load sky130_fd_sc_hd__xnor3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311ai_0] != 0} {
   load sky130_fd_sc_hd__o311ai_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221oi_4] != 0} {
   load sky130_fd_sc_hd__a221oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_decapkapwr_8] != 0} {
   load sky130_fd_sc_hd__lpflow_decapkapwr_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2b_2] != 0} {
   load sky130_fd_sc_hd__nor2b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2a_2] != 0} {
   load sky130_fd_sc_hd__o2bb2a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_2 -toplayer
}
if {[cellname list exists sky130_ef_sc_hd__fill_8] != 0} {
   load sky130_ef_sc_hd__fill_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311o_1] != 0} {
   load sky130_fd_sc_hd__a311o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3b_2] != 0} {
   load sky130_fd_sc_hd__and3b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111oi_0] != 0} {
   load sky130_fd_sc_hd__a2111oi_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4b_1] != 0} {
   load sky130_fd_sc_hd__nor4b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22o_2] != 0} {
   load sky130_fd_sc_hd__a22o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4_4] != 0} {
   load sky130_fd_sc_hd__or4_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111o_1] != 0} {
   load sky130_fd_sc_hd__a2111o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3_2] != 0} {
   load sky130_fd_sc_hd__nor3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvp_8] != 0} {
   load sky130_fd_sc_hd__einvp_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4b_4] != 0} {
   load sky130_fd_sc_hd__or4b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32a_1] != 0} {
   load sky130_fd_sc_hd__o32a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfbbp_1] != 0} {
   load sky130_fd_sc_hd__sdfbbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxtn_1] != 0} {
   load sky130_fd_sc_hd__dlxtn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_inputiso0p_1] != 0} {
   load sky130_fd_sc_hd__lpflow_inputiso0p_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0p_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221ai_4] != 0} {
   load sky130_fd_sc_hd__o221ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor2_1] != 0} {
   load sky130_fd_sc_hd__xnor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor3_4] != 0} {
   load sky130_fd_sc_hd__xnor3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fa_1] != 0} {
   load sky130_fd_sc_hd__fa_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21bai_2] != 0} {
   load sky130_fd_sc_hd__o21bai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3_4] != 0} {
   load sky130_fd_sc_hd__nor3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkbuf_4] != 0} {
   load sky130_fd_sc_hd__clkbuf_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtn_4] != 0} {
   load sky130_fd_sc_hd__dlrtn_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkinvkapwr_4] != 0} {
   load sky130_fd_sc_hd__lpflow_clkinvkapwr_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxbn_1] != 0} {
   load sky130_fd_sc_hd__dlxbn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfsbp_2] != 0} {
   load sky130_fd_sc_hd__sdfsbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4b_2] != 0} {
   load sky130_fd_sc_hd__or4b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sedfxbp_2] != 0} {
   load sky130_fd_sc_hd__sedfxbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4_1] != 0} {
   load sky130_fd_sc_hd__nor4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fill_1] != 0} {
   load sky130_fd_sc_hd__fill_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrc_4] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrc_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfstp_1] != 0} {
   load sky130_fd_sc_hd__sdfstp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221a_1] != 0} {
   load sky130_fd_sc_hd__o221a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sedfxtp_4] != 0} {
   load sky130_fd_sc_hd__sedfxtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_decapkapwr_3] != 0} {
   load sky130_fd_sc_hd__lpflow_decapkapwr_3
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_3 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2_2] != 0} {
   load sky130_fd_sc_hd__nand2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31o_4] != 0} {
   load sky130_fd_sc_hd__a31o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ha_1] != 0} {
   load sky130_fd_sc_hd__ha_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ha_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32a_4] != 0} {
   load sky130_fd_sc_hd__o32a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2_2] != 0} {
   load sky130_fd_sc_hd__mux2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfxbp_2] != 0} {
   load sky130_fd_sc_hd__dfxbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221a_2] != 0} {
   load sky130_fd_sc_hd__o221a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__edfxbp_1] != 0} {
   load sky130_fd_sc_hd__edfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__edfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22a_4] != 0} {
   load sky130_fd_sc_hd__o22a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfbbn_2] != 0} {
   load sky130_fd_sc_hd__dfbbn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlygate4sd3_1] != 0} {
   load sky130_fd_sc_hd__dlygate4sd3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2i_4] != 0} {
   load sky130_fd_sc_hd__mux2i_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrbp_2] != 0} {
   load sky130_fd_sc_hd__dfrbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_decapkapwr_12] != 0} {
   load sky130_fd_sc_hd__lpflow_decapkapwr_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211a_1] != 0} {
   load sky130_fd_sc_hd__o211a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2_1] != 0} {
   load sky130_fd_sc_hd__and2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor3_2] != 0} {
   load sky130_fd_sc_hd__xnor3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__bufbuf_8] != 0} {
   load sky130_fd_sc_hd__bufbuf_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufbuf_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111a_2] != 0} {
   load sky130_fd_sc_hd__o2111a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4bb_1] != 0} {
   load sky130_fd_sc_hd__nor4bb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22ai_4] != 0} {
   load sky130_fd_sc_hd__o22ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32oi_1] != 0} {
   load sky130_fd_sc_hd__a32oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3b_2] != 0} {
   load sky130_fd_sc_hd__nand3b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrckapwr_16] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrckapwr_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrckapwr_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtp_2] != 0} {
   load sky130_fd_sc_hd__dlrtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtp_1] != 0} {
   load sky130_fd_sc_hd__dlrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s25_1] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s25_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkbuf_8] != 0} {
   load sky130_fd_sc_hd__clkbuf_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3_4] != 0} {
   load sky130_fd_sc_hd__and3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2b_4] != 0} {
   load sky130_fd_sc_hd__nor2b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4_2] != 0} {
   load sky130_fd_sc_hd__or4_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111oi_4] != 0} {
   load sky130_fd_sc_hd__a2111oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2_0] != 0} {
   load sky130_fd_sc_hd__and2_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2_1] != 0} {
   load sky130_fd_sc_hd__nor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__decap_12] != 0} {
   load sky130_fd_sc_hd__decap_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22a_1] != 0} {
   load sky130_fd_sc_hd__o22a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_12] != 0} {
   load sky130_fd_sc_hd__inv_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ba_4] != 0} {
   load sky130_fd_sc_hd__o21ba_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4_2] != 0} {
   load sky130_fd_sc_hd__and4_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_2] != 0} {
   load sky130_fd_sc_hd__inv_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4b_4] != 0} {
   load sky130_fd_sc_hd__and4b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkbufkapwr_16] != 0} {
   load sky130_fd_sc_hd__lpflow_clkbufkapwr_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux4_2] != 0} {
   load sky130_fd_sc_hd__mux4_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux4_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21o_2] != 0} {
   load sky130_fd_sc_hd__a21o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s15_2] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s15_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4bb_4] != 0} {
   load sky130_fd_sc_hd__nand4bb_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22ai_1] != 0} {
   load sky130_fd_sc_hd__o22ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxtn_2] != 0} {
   load sky130_fd_sc_hd__dlxtn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinv_2] != 0} {
   load sky130_fd_sc_hd__clkinv_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2o_2] != 0} {
   load sky130_fd_sc_hd__a2bb2o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrbp_1] != 0} {
   load sky130_fd_sc_hd__dlrbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2b_1] != 0} {
   load sky130_fd_sc_hd__nor2b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2_4] != 0} {
   load sky130_fd_sc_hd__mux2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinv_8] != 0} {
   load sky130_fd_sc_hd__clkinv_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2a_1] != 0} {
   load sky130_fd_sc_hd__o2bb2a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3b_4] != 0} {
   load sky130_fd_sc_hd__nor3b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fa_2] != 0} {
   load sky130_fd_sc_hd__fa_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fa_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22a_2] != 0} {
   load sky130_fd_sc_hd__o22a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2oi_2] != 0} {
   load sky130_fd_sc_hd__a2bb2oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32ai_1] != 0} {
   load sky130_fd_sc_hd__o32ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2_2] != 0} {
   load sky130_fd_sc_hd__or2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3_2] != 0} {
   load sky130_fd_sc_hd__or3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211o_4] != 0} {
   load sky130_fd_sc_hd__a211o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4bb_1] != 0} {
   load sky130_fd_sc_hd__and4bb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4bb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22oi_4] != 0} {
   load sky130_fd_sc_hd__a22oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_4] != 0} {
   load sky130_fd_sc_hd__inv_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21bai_1] != 0} {
   load sky130_fd_sc_hd__o21bai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221o_4] != 0} {
   load sky130_fd_sc_hd__a221o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlymetal6s6s_1] != 0} {
   load sky130_fd_sc_hd__dlymetal6s6s_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlymetal6s6s_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111a_1] != 0} {
   load sky130_fd_sc_hd__o2111a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkinvkapwr_1] != 0} {
   load sky130_fd_sc_hd__lpflow_clkinvkapwr_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinv_1] != 0} {
   load sky130_fd_sc_hd__clkinv_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221o_2] != 0} {
   load sky130_fd_sc_hd__a221o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41ai_4] != 0} {
   load sky130_fd_sc_hd__o41ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31ai_1] != 0} {
   load sky130_fd_sc_hd__o31ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinvlp_4] != 0} {
   load sky130_fd_sc_hd__clkinvlp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41a_2] != 0} {
   load sky130_fd_sc_hd__o41a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfbbp_1] != 0} {
   load sky130_fd_sc_hd__dfbbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfbbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21oi_2] != 0} {
   load sky130_fd_sc_hd__a21oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s25_2] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s25_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s25_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrbp_2] != 0} {
   load sky130_fd_sc_hd__dlrbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211o_1] != 0} {
   load sky130_fd_sc_hd__a211o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfstp_4] != 0} {
   load sky130_fd_sc_hd__dfstp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkbuf_1] != 0} {
   load sky130_fd_sc_hd__clkbuf_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_1] != 0} {
   load sky130_fd_sc_hd__inv_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211a_4] != 0} {
   load sky130_fd_sc_hd__o211a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2b_4] != 0} {
   load sky130_fd_sc_hd__or2b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtp_4] != 0} {
   load sky130_fd_sc_hd__dlrtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrbp_1] != 0} {
   load sky130_fd_sc_hd__sdfrbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311a_4] != 0} {
   load sky130_fd_sc_hd__o311a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfstp_2] != 0} {
   load sky130_fd_sc_hd__sdfstp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__maj3_4] != 0} {
   load sky130_fd_sc_hd__maj3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311oi_1] != 0} {
   load sky130_fd_sc_hd__a311oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfxtp_2] != 0} {
   load sky130_fd_sc_hd__sdfxtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__tap_1] != 0} {
   load sky130_fd_sc_hd__tap_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xor2_1] != 0} {
   load sky130_fd_sc_hd__xor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31oi_4] != 0} {
   load sky130_fd_sc_hd__a31oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdlclkp_4] != 0} {
   load sky130_fd_sc_hd__sdlclkp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3_2] != 0} {
   load sky130_fd_sc_hd__and3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3b_1] != 0} {
   load sky130_fd_sc_hd__nand3b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3_1] != 0} {
   load sky130_fd_sc_hd__nor3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ai_2] != 0} {
   load sky130_fd_sc_hd__o21ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_8] != 0} {
   load sky130_fd_sc_hd__buf_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_2] != 0} {
   load sky130_fd_sc_hd__buf_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvn_4] != 0} {
   load sky130_fd_sc_hd__einvn_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3b_4] != 0} {
   load sky130_fd_sc_hd__or3b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31a_4] != 0} {
   load sky130_fd_sc_hd__o31a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ai_4] != 0} {
   load sky130_fd_sc_hd__o21ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s18_1] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s18_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkinvkapwr_2] != 0} {
   load sky130_fd_sc_hd__lpflow_clkinvkapwr_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfxtp_4] != 0} {
   load sky130_fd_sc_hd__sdfxtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3_1] != 0} {
   load sky130_fd_sc_hd__nand3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4b_2] != 0} {
   load sky130_fd_sc_hd__nor4b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__conb_1] != 0} {
   load sky130_fd_sc_hd__conb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__conb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__bufinv_16] != 0} {
   load sky130_fd_sc_hd__bufinv_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ba_1] != 0} {
   load sky130_fd_sc_hd__o21ba_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3b_1] != 0} {
   load sky130_fd_sc_hd__and3b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221ai_2] != 0} {
   load sky130_fd_sc_hd__o221ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2_0] != 0} {
   load sky130_fd_sc_hd__or2_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2ai_2] != 0} {
   load sky130_fd_sc_hd__o2bb2ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4bb_2] != 0} {
   load sky130_fd_sc_hd__nand4bb_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2_1] != 0} {
   load sky130_fd_sc_hd__nand2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlygate4sd1_1] != 0} {
   load sky130_fd_sc_hd__dlygate4sd1_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlygate4sd1_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fah_1] != 0} {
   load sky130_fd_sc_hd__fah_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fah_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2_4] != 0} {
   load sky130_fd_sc_hd__or2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4_4] != 0} {
   load sky130_fd_sc_hd__and4_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21o_1] != 0} {
   load sky130_fd_sc_hd__a21o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__decap_8] != 0} {
   load sky130_fd_sc_hd__decap_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s50_1] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s50_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__maj3_2] != 0} {
   load sky130_fd_sc_hd__maj3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__maj3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xor2_4] != 0} {
   load sky130_fd_sc_hd__xor2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xor3_4] != 0} {
   load sky130_fd_sc_hd__xor3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkbufkapwr_1] != 0} {
   load sky130_fd_sc_hd__lpflow_clkbufkapwr_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxtn_4] != 0} {
   load sky130_fd_sc_hd__dlxtn_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtn_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_bleeder_1] != 0} {
   load sky130_fd_sc_hd__lpflow_bleeder_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_bleeder_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor3b_2] != 0} {
   load sky130_fd_sc_hd__nor3b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor3b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31ai_4] != 0} {
   load sky130_fd_sc_hd__o31ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_6] != 0} {
   load sky130_fd_sc_hd__buf_6
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_6 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211oi_1] != 0} {
   load sky130_fd_sc_hd__a211oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311o_2] != 0} {
   load sky130_fd_sc_hd__a311o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111a_4] != 0} {
   load sky130_fd_sc_hd__o2111a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfstp_4] != 0} {
   load sky130_fd_sc_hd__sdfstp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfstp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2_4] != 0} {
   load sky130_fd_sc_hd__and2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32o_1] != 0} {
   load sky130_fd_sc_hd__a32o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrc_1] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrc_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211oi_4] != 0} {
   load sky130_fd_sc_hd__a211oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrbn_2] != 0} {
   load sky130_fd_sc_hd__dlrbn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrbn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4 -toplayer
}
if {[cellname list exists sky130_ef_sc_hd__fakediode_2] != 0} {
   load sky130_ef_sc_hd__fakediode_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fakediode_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2b_1] != 0} {
   load sky130_fd_sc_hd__nand2b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311ai_2] != 0} {
   load sky130_fd_sc_hd__o311ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sedfxbp_1] != 0} {
   load sky130_fd_sc_hd__sedfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4bb_2] != 0} {
   load sky130_fd_sc_hd__or4bb_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o211ai_2] != 0} {
   load sky130_fd_sc_hd__o211ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o211ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlrtn_1] != 0} {
   load sky130_fd_sc_hd__dlrtn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlrtn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2b_4] != 0} {
   load sky130_fd_sc_hd__and2b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31o_2] != 0} {
   load sky130_fd_sc_hd__a31o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s50_2] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s50_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s50_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvn_2] != 0} {
   load sky130_fd_sc_hd__einvn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__probe_p_8] != 0} {
   load sky130_fd_sc_hd__probe_p_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__probe_p_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ai_1] != 0} {
   load sky130_fd_sc_hd__o21ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfstp_2] != 0} {
   load sky130_fd_sc_hd__dfstp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21boi_2] != 0} {
   load sky130_fd_sc_hd__a21boi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21boi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfbbn_2] != 0} {
   load sky130_fd_sc_hd__sdfbbn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfbbn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32a_2] != 0} {
   load sky130_fd_sc_hd__o32a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and2_2] != 0} {
   load sky130_fd_sc_hd__and2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sedfxtp_1] != 0} {
   load sky130_fd_sc_hd__sedfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311a_2] != 0} {
   load sky130_fd_sc_hd__o311a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a211o_2] != 0} {
   load sky130_fd_sc_hd__a211o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a211o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__tapvpwrvgnd_1] != 0} {
   load sky130_fd_sc_hd__tapvpwrvgnd_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvpwrvgnd_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__bufinv_8] != 0} {
   load sky130_fd_sc_hd__bufinv_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__bufinv_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41o_1] != 0} {
   load sky130_fd_sc_hd__a41o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxtp_1] != 0} {
   load sky130_fd_sc_hd__dlxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s18_2] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s18_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s18_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22oi_2] != 0} {
   load sky130_fd_sc_hd__a22oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrtp_4] != 0} {
   load sky130_fd_sc_hd__sdfrtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2b_4] != 0} {
   load sky130_fd_sc_hd__nand2b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2_8] != 0} {
   load sky130_fd_sc_hd__nand2_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4b_2] != 0} {
   load sky130_fd_sc_hd__and4b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__macro_sparecell] != 0} {
   load sky130_fd_sc_hd__macro_sparecell
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__macro_sparecell -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41oi_1] != 0} {
   load sky130_fd_sc_hd__a41oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3_4] != 0} {
   load sky130_fd_sc_hd__nand3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2_1] != 0} {
   load sky130_fd_sc_hd__or2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221oi_2] != 0} {
   load sky130_fd_sc_hd__a221oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o311a_1] != 0} {
   load sky130_fd_sc_hd__o311a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o311a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2oi_1] != 0} {
   load sky130_fd_sc_hd__a2bb2oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2_8] != 0} {
   load sky130_fd_sc_hd__nor2_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__decap_6] != 0} {
   load sky130_fd_sc_hd__decap_6
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_6 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sedfxtp_2] != 0} {
   load sky130_fd_sc_hd__sedfxtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sedfxtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2a_4] != 0} {
   load sky130_fd_sc_hd__o2bb2a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41ai_1] != 0} {
   load sky130_fd_sc_hd__o41ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4_2] != 0} {
   load sky130_fd_sc_hd__nand4_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkdlybuf4s15_1] != 0} {
   load sky130_fd_sc_hd__clkdlybuf4s15_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkdlybuf4s15_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221a_4] != 0} {
   load sky130_fd_sc_hd__o221a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221a_4 -toplayer
}
if {[cellname list exists sky130_ef_sc_hd__decap_12] != 0} {
   load sky130_ef_sc_hd__decap_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__decap_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o31a_1] != 0} {
   load sky130_fd_sc_hd__o31a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o31a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21ba_2] != 0} {
   load sky130_fd_sc_hd__o21ba_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21ba_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_isobufsrc_2] != 0} {
   load sky130_fd_sc_hd__lpflow_isobufsrc_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_isobufsrc_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41ai_2] != 0} {
   load sky130_fd_sc_hd__o41ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__decap_4] != 0} {
   load sky130_fd_sc_hd__decap_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand2b_2] != 0} {
   load sky130_fd_sc_hd__nand2b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand2b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinvlp_2] != 0} {
   load sky130_fd_sc_hd__clkinvlp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinvlp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfxbp_1] != 0} {
   load sky130_fd_sc_hd__dfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkbuf_2] != 0} {
   load sky130_fd_sc_hd__clkbuf_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfxtp_1] != 0} {
   load sky130_fd_sc_hd__sdfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2bb2o_4] != 0} {
   load sky130_fd_sc_hd__a2bb2o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2bb2o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111ai_1] != 0} {
   load sky130_fd_sc_hd__o2111ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor2_2] != 0} {
   load sky130_fd_sc_hd__nor2_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor2_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a31oi_2] != 0} {
   load sky130_fd_sc_hd__a31oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a31oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21a_2] != 0} {
   load sky130_fd_sc_hd__o21a_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o22ai_2] != 0} {
   load sky130_fd_sc_hd__o22ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o22ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a221oi_1] != 0} {
   load sky130_fd_sc_hd__a221oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a221oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4bb_1] != 0} {
   load sky130_fd_sc_hd__or4bb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111ai_2] != 0} {
   load sky130_fd_sc_hd__o2111ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4bb_1] != 0} {
   load sky130_fd_sc_hd__nand4bb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4bb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlclkp_2] != 0} {
   load sky130_fd_sc_hd__dlclkp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_inputiso1n_1] != 0} {
   load sky130_fd_sc_hd__lpflow_inputiso1n_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso1n_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2] != 0} {
   load sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrtp_1] != 0} {
   load sky130_fd_sc_hd__sdfrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfrtp_4] != 0} {
   load sky130_fd_sc_hd__dfrtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfrtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_inputisolatch_1] != 0} {
   load sky130_fd_sc_hd__lpflow_inputisolatch_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputisolatch_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a311oi_2] != 0} {
   load sky130_fd_sc_hd__a311oi_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a311oi_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21oi_1] != 0} {
   load sky130_fd_sc_hd__a21oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111o_2] != 0} {
   load sky130_fd_sc_hd__a2111o_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111o_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2ai_1] != 0} {
   load sky130_fd_sc_hd__o2bb2ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32ai_4] != 0} {
   load sky130_fd_sc_hd__o32ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21bo_2] != 0} {
   load sky130_fd_sc_hd__a21bo_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21bo_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3_4] != 0} {
   load sky130_fd_sc_hd__or3_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32oi_4] != 0} {
   load sky130_fd_sc_hd__a32oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfxtp_2] != 0} {
   load sky130_fd_sc_hd__dfxtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkinv_16] != 0} {
   load sky130_fd_sc_hd__clkinv_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkinv_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a32o_4] != 0} {
   load sky130_fd_sc_hd__a32o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a32o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2i_1] != 0} {
   load sky130_fd_sc_hd__mux2i_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2i_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__tap_2] != 0} {
   load sky130_fd_sc_hd__tap_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tap_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or3b_2] != 0} {
   load sky130_fd_sc_hd__or3b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or3b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfstp_1] != 0} {
   load sky130_fd_sc_hd__dfstp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfstp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvp_2] != 0} {
   load sky130_fd_sc_hd__einvp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfxbp_2] != 0} {
   load sky130_fd_sc_hd__sdfxbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xnor2_4] != 0} {
   load sky130_fd_sc_hd__xnor2_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xnor2_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and4b_1] != 0} {
   load sky130_fd_sc_hd__and4b_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and4b_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a22o_4] != 0} {
   load sky130_fd_sc_hd__a22o_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a22o_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvp_4] != 0} {
   load sky130_fd_sc_hd__einvp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_decapkapwr_6] != 0} {
   load sky130_fd_sc_hd__lpflow_decapkapwr_6
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_decapkapwr_6 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4bb_4] != 0} {
   load sky130_fd_sc_hd__nor4bb_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvp_1] != 0} {
   load sky130_fd_sc_hd__einvp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrtn_1] != 0} {
   load sky130_fd_sc_hd__sdfrtn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a2111oi_1] != 0} {
   load sky130_fd_sc_hd__a2111oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a2111oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a21oi_4] != 0} {
   load sky130_fd_sc_hd__a21oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a21oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21a_4] != 0} {
   load sky130_fd_sc_hd__o21a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxbp_1] != 0} {
   load sky130_fd_sc_hd__dlxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlclkp_4] != 0} {
   load sky130_fd_sc_hd__dlclkp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o221ai_1] != 0} {
   load sky130_fd_sc_hd__o221ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o221ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__buf_12] != 0} {
   load sky130_fd_sc_hd__buf_12
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__buf_12 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__decap_3] != 0} {
   load sky130_fd_sc_hd__decap_3
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__decap_3 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdlclkp_1] != 0} {
   load sky130_fd_sc_hd__sdlclkp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdlclkp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfxbp_1] != 0} {
   load sky130_fd_sc_hd__sdfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ebufn_4] != 0} {
   load sky130_fd_sc_hd__ebufn_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand3b_4] != 0} {
   load sky130_fd_sc_hd__nand3b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand3b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrbp_2] != 0} {
   load sky130_fd_sc_hd__sdfrbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlxbn_2] != 0} {
   load sky130_fd_sc_hd__dlxbn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlxbn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a41oi_4] != 0} {
   load sky130_fd_sc_hd__a41oi_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a41oi_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21a_1] != 0} {
   load sky130_fd_sc_hd__o21a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or2b_2] != 0} {
   load sky130_fd_sc_hd__or2b_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or2b_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4_1] != 0} {
   load sky130_fd_sc_hd__nand4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ebufn_1] != 0} {
   load sky130_fd_sc_hd__ebufn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__or4bb_4] != 0} {
   load sky130_fd_sc_hd__or4bb_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__or4bb_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfsbp_1] != 0} {
   load sky130_fd_sc_hd__sdfsbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfsbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2bb2ai_4] != 0} {
   load sky130_fd_sc_hd__o2bb2ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2bb2ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ebufn_2] != 0} {
   load sky130_fd_sc_hd__ebufn_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xor3_2] != 0} {
   load sky130_fd_sc_hd__xor3_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfxtp_4] != 0} {
   load sky130_fd_sc_hd__dfxtp_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfxtp_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4_2] != 0} {
   load sky130_fd_sc_hd__nor4_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__tapvgnd_1] != 0} {
   load sky130_fd_sc_hd__tapvgnd_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__tapvgnd_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nand4b_4] != 0} {
   load sky130_fd_sc_hd__nand4b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nand4b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dfsbp_2] != 0} {
   load sky130_fd_sc_hd__dfsbp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dfsbp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o21bai_4] != 0} {
   load sky130_fd_sc_hd__o21bai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o21bai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__dlclkp_1] != 0} {
   load sky130_fd_sc_hd__dlclkp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__dlclkp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__clkbuf_16] != 0} {
   load sky130_fd_sc_hd__clkbuf_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__clkbuf_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__ebufn_8] != 0} {
   load sky130_fd_sc_hd__ebufn_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__ebufn_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__sdfrtp_2] != 0} {
   load sky130_fd_sc_hd__sdfrtp_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__sdfrtp_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__einvn_0] != 0} {
   load sky130_fd_sc_hd__einvn_0
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__einvn_0 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o41a_4] != 0} {
   load sky130_fd_sc_hd__o41a_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o41a_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__and3b_4] != 0} {
   load sky130_fd_sc_hd__and3b_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__and3b_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__nor4bb_2] != 0} {
   load sky130_fd_sc_hd__nor4bb_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__nor4bb_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_inputiso0n_1] != 0} {
   load sky130_fd_sc_hd__lpflow_inputiso0n_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_inputiso0n_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkinvkapwr_8] != 0} {
   load sky130_fd_sc_hd__lpflow_clkinvkapwr_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkbufkapwr_2] != 0} {
   load sky130_fd_sc_hd__lpflow_clkbufkapwr_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkbufkapwr_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o2111ai_4] != 0} {
   load sky130_fd_sc_hd__o2111ai_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o2111ai_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__xor3_1] != 0} {
   load sky130_fd_sc_hd__xor3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__xor3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__mux2_1] != 0} {
   load sky130_fd_sc_hd__mux2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__mux2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__inv_16] != 0} {
   load sky130_fd_sc_hd__inv_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__inv_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__o32ai_2] != 0} {
   load sky130_fd_sc_hd__o32ai_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__o32ai_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__fill_8] != 0} {
   load sky130_fd_sc_hd__fill_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__fill_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__lpflow_clkinvkapwr_16] != 0} {
   load sky130_fd_sc_hd__lpflow_clkinvkapwr_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__lpflow_clkinvkapwr_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hd__a222oi_1] != 0} {
   load sky130_fd_sc_hd__a222oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd__a222oi_1 -toplayer
}
puts stdout "Done."
quit -noprompt
