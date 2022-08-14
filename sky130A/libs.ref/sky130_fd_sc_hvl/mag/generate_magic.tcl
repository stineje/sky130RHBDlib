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
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/gds/sky130_fd_sc_hvl.gds
puts stdout "Annotating cells from LEF"
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_symmetric_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_simple_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_32.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__diode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__schmittbuf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_lh_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xnor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probec_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_hl_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__conb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probe_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor3_1.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/cdl/sky130_fd_sc_hvl.cdl}
puts stdout "Writing all magic database files"
writeall force
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_symmetric_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22ai_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_simple_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_32.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22o_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__diode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__schmittbuf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21a_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux4_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_lh_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvn_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlclkp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or3_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfstp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xnor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probec_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_hl_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22oi_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfsbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg_3.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_16.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlxtp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_4.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__conb_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxbp_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probe_p_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor2_1.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor3_1.lef
if {[cellname list exists sky130_fd_sc_hvl__lsbuflv2hv_symmetric_1] != 0} {
   load sky130_fd_sc_hvl__lsbuflv2hv_symmetric_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_symmetric_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon_1] != 0} {
   load sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_isosrchvaon_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfxtp_1] != 0} {
   load sky130_fd_sc_hvl__sdfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfxtp_1] != 0} {
   load sky130_fd_sc_hvl__dfxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__nand3_1] != 0} {
   load sky130_fd_sc_hvl__nand3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfxbp_1] != 0} {
   load sky130_fd_sc_hvl__sdfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__o21ai_1] != 0} {
   load sky130_fd_sc_hvl__o21ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__and2_1] != 0} {
   load sky130_fd_sc_hvl__and2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdlclkp_1] != 0} {
   load sky130_fd_sc_hvl__sdlclkp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlclkp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfstp_1] != 0} {
   load sky130_fd_sc_hvl__dfstp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfstp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbufhv2lv_1] != 0} {
   load sky130_fd_sc_hvl__lsbufhv2lv_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__inv_2] != 0} {
   load sky130_fd_sc_hvl__inv_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__einvp_1] != 0} {
   load sky130_fd_sc_hvl__einvp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__decap_4] != 0} {
   load sky130_fd_sc_hvl__decap_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__a21o_1] != 0} {
   load sky130_fd_sc_hvl__a21o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_4] != 0} {
   load sky130_fd_sc_hvl__buf_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__inv_8] != 0} {
   load sky130_fd_sc_hvl__inv_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__inv_16] != 0} {
   load sky130_fd_sc_hvl__inv_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__inv_1] != 0} {
   load sky130_fd_sc_hvl__inv_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfsbp_1] != 0} {
   load sky130_fd_sc_hvl__dfsbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfsbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__o22a_1] != 0} {
   load sky130_fd_sc_hvl__o22a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__decap_8] != 0} {
   load sky130_fd_sc_hvl__decap_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__decap_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__xor2_1] != 0} {
   load sky130_fd_sc_hvl__xor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_8] != 0} {
   load sky130_fd_sc_hvl__buf_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dlrtp_1] != 0} {
   load sky130_fd_sc_hvl__dlrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfrtp_1] != 0} {
   load sky130_fd_sc_hvl__sdfrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__fill_2] != 0} {
   load sky130_fd_sc_hvl__fill_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__o22ai_1] != 0} {
   load sky130_fd_sc_hvl__o22ai_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o22ai_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbufhv2lv_simple_1] != 0} {
   load sky130_fd_sc_hvl__lsbufhv2lv_simple_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2lv_simple_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__fill_1] != 0} {
   load sky130_fd_sc_hvl__fill_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_32] != 0} {
   load sky130_fd_sc_hvl__buf_32
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_32 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_2] != 0} {
   load sky130_fd_sc_hvl__buf_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__a22o_1] != 0} {
   load sky130_fd_sc_hvl__a22o_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22o_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__diode_2] != 0} {
   load sky130_fd_sc_hvl__diode_2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__diode_2 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdlxtp_1] != 0} {
   load sky130_fd_sc_hvl__sdlxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdlxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__schmittbuf_1] != 0} {
   load sky130_fd_sc_hvl__schmittbuf_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__schmittbuf_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__o21a_1] != 0} {
   load sky130_fd_sc_hvl__o21a_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__o21a_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__mux4_1] != 0} {
   load sky130_fd_sc_hvl__mux4_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux4_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__mux2_1] != 0} {
   load sky130_fd_sc_hvl__mux2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__mux2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__fill_8] != 0} {
   load sky130_fd_sc_hvl__fill_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__and3_1] != 0} {
   load sky130_fd_sc_hvl__and3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__and3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbufhv2hv_lh_1] != 0} {
   load sky130_fd_sc_hvl__lsbufhv2hv_lh_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_lh_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfrtp_1] != 0} {
   load sky130_fd_sc_hvl__dfrtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__einvn_1] != 0} {
   load sky130_fd_sc_hvl__einvn_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__einvn_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dlclkp_1] != 0} {
   load sky130_fd_sc_hvl__dlclkp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlclkp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_1] != 0} {
   load sky130_fd_sc_hvl__buf_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbuflv2hv_1] != 0} {
   load sky130_fd_sc_hvl__lsbuflv2hv_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__or3_1] != 0} {
   load sky130_fd_sc_hvl__or3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or3_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfrbp_1] != 0} {
   load sky130_fd_sc_hvl__sdfrbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfrbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__a21oi_1] != 0} {
   load sky130_fd_sc_hvl__a21oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a21oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfstp_1] != 0} {
   load sky130_fd_sc_hvl__sdfstp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfstp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfrbp_1] != 0} {
   load sky130_fd_sc_hvl__dfrbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfrbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__xnor2_1] != 0} {
   load sky130_fd_sc_hvl__xnor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__xnor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__fill_4] != 0} {
   load sky130_fd_sc_hvl__fill_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__fill_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__or2_1] != 0} {
   load sky130_fd_sc_hvl__or2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__or2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__probec_p_8] != 0} {
   load sky130_fd_sc_hvl__probec_p_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probec_p_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbufhv2hv_hl_1] != 0} {
   load sky130_fd_sc_hvl__lsbufhv2hv_hl_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbufhv2hv_hl_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__a22oi_1] != 0} {
   load sky130_fd_sc_hvl__a22oi_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__a22oi_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__nand2_1] != 0} {
   load sky130_fd_sc_hvl__nand2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nand2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__sdfsbp_1] != 0} {
   load sky130_fd_sc_hvl__sdfsbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__sdfsbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg_3] != 0} {
   load sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg_3
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__lsbuflv2hv_clkiso_hlkg_3 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__buf_16] != 0} {
   load sky130_fd_sc_hvl__buf_16
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__buf_16 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dlxtp_1] != 0} {
   load sky130_fd_sc_hvl__dlxtp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dlxtp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__inv_4] != 0} {
   load sky130_fd_sc_hvl__inv_4
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__inv_4 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__conb_1] != 0} {
   load sky130_fd_sc_hvl__conb_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__conb_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__dfxbp_1] != 0} {
   load sky130_fd_sc_hvl__dfxbp_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__dfxbp_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__probe_p_8] != 0} {
   load sky130_fd_sc_hvl__probe_p_8
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__probe_p_8 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__nor2_1] != 0} {
   load sky130_fd_sc_hvl__nor2_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor2_1 -toplayer
}
if {[cellname list exists sky130_fd_sc_hvl__nor3_1] != 0} {
   load sky130_fd_sc_hvl__nor3_1
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl__nor3_1 -toplayer
}
puts stdout "Done."
quit -noprompt
