
** Library name: s8atcrf_pfk1
** Cell name: S8_test_coil3
** View name: schematic
.subckt xind_5_220 a b ct sub
    R31 net27 b r=1e-2
    R26 a net23 r=1e-2
    C2 net27 net31 c=223.7e-15
    C24 net35 net27 c=205e-15
    C25 net23 net37 c=223.7e-15
    R5 sub net31 r=5.358e3
    R4 net41 net27 r=2.059
    R13 net23 net35 r=9.064
    R10 sub net37 r=5.358e3
    R9 net23 net39 r=2.059
    L1 net39 ct l=4.96e-9
    L3 ct net41 l=4.96e-9
.ends xind_5_220
** End of subcircuit definition.

** Library name: s8atcrf_pfk1
** Cell name: S8_test_coil2
** View name: schematic
.subckt xind_5_125 a b ct sub
    R31 net27 b r=1e-2
    R26 a net23 r=1e-2
    C24 net35 net27 c=103.1e-15
    C25 net23 net37 c=357e-15
    C1 net27 net31 c=357e-15
    R3 sub net31 r=3.67e3
    R2 net41 net27 r=1.7645
    R13 net23 net35 r=9.312
    R10 sub net37 r=3.67e3
    R9 net23 net39 r=1.7645
    L1 net39 ct l=2.895e-9
    L2 ct net41 l=2.895e-9
.ends xind_5_125
** End of subcircuit definition.

** Library name: s8atcrf_pfk1
** Cell name: S8_test_coil1
** View name: schematic
.subckt xind_3_90 a b ct sub
    R31 net27 b r=1e-2
    R26 a net23 r=1e-2
    C24 net35 net27 c=8.337e-15
    C25 net23 net37 c=53.8e-15
    C0 net27 net31 c=53.8e-15
    R1 sub net31 r=21.56
    R13 net23 net35 r=50.11
    R10 sub net37 r=21.56
    R0 net41 net27 r=1.019
    R9 net23 net39 r=1.019
    L0 ct net41 l=760.5e-12
    L1 net39 ct l=760.5e-12
.ends xind_3_90
** End of subcircuit definition.

