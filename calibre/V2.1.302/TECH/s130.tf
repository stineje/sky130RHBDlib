; Technology File technology_library S130
; 03/20/20 - removed short purpose
; 05/5/20  - added fill purposes
; 05/25/20 - made all res purposes valid
;          - made pwell/dwg valid
; 06/23/20 - added purpose areaid/padLength
; 06/24/20 - added layer thkox
; 07/06/20 - added PTAP/NTAP std vias
; 07/08/20 - deleted padCenter - not used
;          - changed fill purpose to fill because "fill" is reserved
; 08/10/20 - removed extDrain20 purpose and layer defs - not used
; 08/12/20 - removed areaid/contres (obsolete)
;          - tightened up the std via enclosures and constraints
; 09/11/20 - changed function of npc to nwell to prevent tech warnings
; 09/14/20 - updated std via defs to remove negative cut spacing
;             and increase some enclosure spacings
;             and increase some via spacings
; 09/22/20 - added areaid types pad_io, pad_pwr and pad_gnd
; 10/01/20 - fixed the MPPs which were missign spacing values for 
;             contacts/vias and split the ntap_li, ntap_m1 into
;             ndiff_li, ntap_li, ndiff_m1 & ntap_m1 MPPs.
; 10/14/20 - removed more unused data (current density/defaultWidths etc)
;          - removed SkyWater constraint group
;          - added virtuosoDefaultExtractorSetup and virtuosoDefault
; 10/20/20 - added areaid/guard_boundary for latchup checks
; 11/05/20 - removed areaid purposes sigPadDiff/SigPadWell/SigPadMetNtr
; 11/20/20 - updated the poly/li contact for npc enclosure of licon
; 11/30/20 - changed li1 to li, licon1 to licon and via to via1
; 12/15/20 - Added derived layer polylicon and diffv5
;          - Changed minSpacing constraint for li from 0.13 to 0.17
;          - Added minSpacing constraint from diff to poly llicon of 0.19
;          - Adding minSpacing constraint for v5 diff of 0.30
; 12/22/20 - Changed fill_dmy to fill
; 12/23/20 - Changed areaid/waffleWindow to areaid/fillWindow
; 12/24/20 - Made fill and fill_block purposes valid
; 01/04/21 - removed fom/dummy
; 01/20/21 - remove pwelliso and pwell/drawing
;            made pwell/pin and pwell/label valid
; 03/26/21 - removed mode layer/boundary as CDN says:
;            IC6.1.4.500.12 onwards requirement for boundary purpose has 
;            been removed entirely. The boundary purpose will be created 
;            in virtual memory and techfile write permission won't be required. 
; 04/13/21 - added constraintGroup "LEFDefaultRouteSpec"
; Q6.01
; 05/03/21 - removed diff:hv
; 06/02/21 - added v5/v12/v20 options to ntap_li and ntap_met1
;            widened nw in above to 0.84 min width
;            added thkox
; 06/03/21 - renamed ntap_li* and ntap_met1* mpps to nw_li* and nw_met1*
; 06/24/21 - changed layers met4/fuse and target to be invalid
; 07/01/21 - changed areaid;notCritSide to be invalid
; 07/15/21 - moved areaid:guardBoundary and areaid:hvnwell to invalid
; 10/14/21 - CBPL Added viatop Layer 16 and cviatop Layer 72
; 10/28/21 - CBPL Added cmtest layer to be used for testing viatop Layer 74
; 03/09/22 - JAG Added areaid:lv_net to use for exempting latch-up checks
;********************************
; CONTROLS
;********************************
controls(
 techVersion("1.0")

 techParams(
 ;( parameter           value             )
 ;( ----------          -----             )
  ( TECHtechnology 	"s130"   )
  ( TECHtdrSpecNum 	"001-01905"     )
  ( TECHtdrSpecRev 	"EQ"            )
  ( TECHbondPadStressSpecNum	"01-70004"      )
  ( TECHbondPadStressSpecRev	"BC"            )
  ( TECHmiscTdrSpecNum	"001-69087"     )
  ( TECHmiscTdrSpecRev	"AA"            )
  ( TECHcompileTime	"Nov 10 22:04:23 2017" )
  ( TECHcompileTimeUTC	1510322663      )
 ) ;techParams

 viewTypeUnits(
 ;( viewType            userUnit       dbuperuu           )
 ;( --------            --------       --------           )
  ( maskLayout         "micron"         1000            )
  ( schematic           "inch"          160             )
  ( schematicSymbol     "inch"          160             )
  ( netlist             "inch"          160             )
  ( hierDesign          "_def_"         1000            )
 ) ;viewTypeUnits

 mfgGridResolution(
      ( 0.005000 )
 ) ;mfgGridResolution

 refTechLibs(
; techLibName            
; -----------            
 ) ;refTechLibs

 processFamily(
 ) ;processFamily

 distanceMeasure(
 ) ;distanceMeasure

 processNode()

) ;controls


;********************************
; LAYER DEFINITION
;********************************
layerDefinitions(

 techPurposes(
 ;( PurposeName               Purpose#   Abbreviation )
 ;( -----------               --------   ------------ )
 ;User-Defined Purposes:
  ( seal                      1                       )
  ( core                      2                       )
  ( frame                     3                       )
  ( fill_block                4                       )
  ( standardc                 5                       )
; ( sigPadDiff                6                       )
; ( sigPadWell                7                       )
; ( sigPadMetNtr              8                       )
  ( ferro                     9                       )
  ( moduleCut                 10                      )
  ( dieCut                    11                      )
  ( frameRect                 12                      )
  ( zener                     13                      )
; ( extDrain20                14                      )
  ( padLength                 15                      )
  ( res                       16                      )
  ( esd                       17                      )
  ( tmppnp                    18                      )
  ( mask                      20                      )
  ( maskAdd                   21                      )
  ( maskDrop                  22                      )
  ( diode                     23                      )
  ( fuse                      24                      )
  ( gate                      25                      )
  ( hvnwell                   26                      )
  ( rdlprobepad               27                      )
  ( hv                        28                      )
  ( probe                     29                      )
  ( extFab                    30                      )
  ( option1                   31                      )
  ( option2                   32                      )
  ( option3                   33                      )
  ( option4                   34                      )
  ( option5                   35                      )
  ( option6                   36                      )
  ( option7                   37                      )
  ( option8                   38                      )
  ( precres                   39                      )
  ( silicon                   40                      )
  ( vlc                       41                      )
  ( met3                      42                      )
  ( met2                      43                      )
  ( met1                      44                      )
  ( li                        45                      )
  ( poly                      46                      )
  ( injection                 47                      )
  ( nodnw                     49                      )
  ( deadZon                   50                      )
  ( critCorner                51                      )
  ( critSid                   52                      )
  ( substrateCut              53                      )
  ( opcDrop                   54                      )
  ( cuPillar                  55                      )
  ( techCd                    56                      )
  ( term1                     57                      )
  ( term2                     58                      )
  ( term3                     59                      )
  ( scr                       60                      )
  ( port                      61                      )
  ( port1                     62                      )
  ( region                    63                      )
  ( dummy                     64                      )
  ( ppath                     65                      )
  ( ppath1                    66                      )
  ( macro                     67                      )
  ( nwellIsolation            68                      )
  ( fillWindow                69                      )
  ( block                     70                      )
  ( waffleAdd1                71                      )
  ( waffleAdd2                72                      )
; ( contres                   73                      )
  ( cuDrop                    74                      )
  ( extendedDrain             75                      )
  ( subcktDevice              76                      )
  ( pixel                     77                      )
  ( capacitor                 78                      )
  ( analog                    79                      )
  ( lvdnw                     80                      )
  ( photo                     81                      )
  ( guardring                 82                      )
  ( model                     83                      )
  ( ipExempt                  84                      )
  ( pitch                     85                      )
  ( HighVt                    86                      )
  ( lvNative                  87                      )
  ( psa1                      88                      )
  ( psa2                      89                      )
  ( psa3                      90                      )
  ( psa4                      91                      )
  ( psa5                      92                      )
  ( psa6                      93                      )
  ( hole                      94                      )
  ( select                    95                      )
  ( umconly                   97                      )
  ( opc                       98                      )
  ( nodummy                   99                      )
  ( drc                       100                     )
  ( etest                     101                     )
  ( vss                       102                     )
  ( fc                        103                     )
  ( fix                       104                     )
  ( mim                       105                     )
  ( nmim                      106                     )
  ( pad                       107                     )
  ( per                       108                     )
  ( cvs                       109                     )
  ( ext                       110                     )
  ( ip                        111                     )
  ( low_vt                    112                     )
  ( cis_array                 113                     )
  ( imagers                   114                     )
  ( t3                        115                     )
  ( logic                     116                     )
  ( dio                       117                     )
  ( cap                       118                     )
  ( res1                      119                     )
  ( bjt                       120                     )
  ( efuseMark                 121                     )
  ( slotBlock                 122                     )
  ( fuseMark                  123                     )
  ( umcIP                     124                     )
  ( rfdiode                   125                     )
  ( lowTapDensity             126                     )
  ( notCritSide               127                     )
  ( fabBlock                  128                     )
  ( pad_io                    1201                    )
  ( pad_pwr                   1202                    )
  ( pad_gnd                   1203                    )
  ( guard_boundary            1204                    )
  ( lv_net                    1205                    )
 ;System-Reserved Purposes
 ) ;techPurposes

 techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
  ( nwell                     0          nwell        )
  ( pwell                     1          pwell        )
  ( diff                      2          diff         )
 ;( tap                       3          tap          )
  ( poly                      4          poly         )
  ( mcon                      5          mcon         )
  ( met1                      6          met1         )
  ( via1                      7          via1         )
  ( met2                      8          met2         )
  ( via2                      9          via2         )
  ( met3                      10         met3         )
  ( pad                       11         pad          )
  ( via3                      12         via3         )
  ( met4                      13         met4         )
  ( via4                      14         via4         )
  ( met5                      15         met5         )
  ( viatop		      16	 viatop	      )
  ( mtest		      17	 mtest	      )
  ( LVS_exclude               21         LVS_exclude  )
  ( li                        22         li           )
  ( dnwell                    23         dnwell       )
  ( inductor                  24         inducto      )
  ( lvtn                      25         lvtn         )
  ( nsdm                      30         nsdm         )
  ( psdm                      31         psdm         )
  ( hvntm                     36         hvntm        )
  ( cnsm                      37         cnsm         )
; jag adds to match dumped tf:
  ( r1v                       39         r1v          )
  ( r1c                       40         r1c          )
; end jag adds
  ( tunm                      41         tunm         )
  ( licon                     43         licon        )
; jag removed
;  ( padCenter                 45         padCent      )
  ( nsm                       47         nsm          )
; jag adds to match dumped tf:
  ( cpwbm                     51         cpwbm        )
; end jag adds
  ( cfom                      52         cfom         )
  ( ldntm                     53         ldntm        )
  ( cp1m                      55         cp1m         )
  ( cnsdm                     56         cnsdm        )
  ( cpsdm                     57         cpsdm        )
  ( cntm                      58         cntm         )
  ( cctm1                     59         cctm1        )
  ( cmm1                      60         cmm1         )
  ( cviam                     61         cviam        )
  ( cmm2                      62         cmm2         )
  ( cviam2                    63         cviam2       )
  ( cmm3                      64         cmm3         )
  ( cpdm                      66         cpdm         )
  ( cviam3                    67         cviam3       )
  ( cmm4                      68         cmm4         )
  ( cviam4                    69         cviam4       )
  ( cmm5                      70         cmm5         )
  ( cviatop		      72	 cviatop      )
  ( cmtest		      74	 cmtest       )
  ( capm                      75         capm         )
  ( pmm                       76         pmm          )
  ( fom                       77         fom          )
  ( cdnm                      79         cdnm         )
; jag adds to match dumped tf:
  ( urpm                      81         urpm         )
  ( crrpm                     82         ccrpm        )
; end jag adds
  ( cli1m                     83         cli1m        )
; jag adds to match dumped tf:
  ( curpm                     84         curpm        )
; end jag adds
  ( chvtpm                    85         chvtpm       )
  ( cap2m                     86         cap2m        )
  ( crpm                      87         crpm         )
  ( v12                       88         v12          )
  ( clvom                     89         clvom        )
  ( cncm                      90         cncm         )
  ( ctunm                     91         ctunm        )
  ( hvtp                      92         hvtp         )
  ( conom                     93         conom        )
  ( clicm1                    95         clicm1       )
  ( ncm                       96         ncm          )
  ( cpmm                      97         cpmm         )
  ( overlap                   99         overlap      )
; jag adds to match dumped tf:
  ( rrpm                      100        rrpm         )
; end jag adds
  ( pnp                       101        pnp          )
  ( chvntm                    102        chvntm       )
  ( capacitor                 103        capacit      )
  ( rpm                       106        rpm          )
  ( target                    107        target       )
  ( cnwm                      109        cnwm         )
  ( areaid                    110        areaid       )
  ( npn                       111        npn          )
  ( hvtr                      113        hvtr         )
  ( cpmm2                     114        cpmm2        )
  ( npc                       115        npc          )
  ( cnpc                      116        cnpc         )
  ( pmm2                      117        pmm2         )
  ( chvtrm                    118        chvtrm       )
  ( cpbo                      119        cpbo         )
  ( clvtnm                    120        clvtnm       )
; ( pwelliso                  122        pwelliso     )
  ( blanking                  123        blankin      )
  ( cldntm                    126        cldntm       )
  ( rdl                       136        rdl          )
  ( ubm                       140        ubm          )
  ( bump                      141        bump         )
  ( ccu1m                     142        ccu1m        )
  ( cubm                      143        cubm         )
  ( cbump                     144        cbump        )
; jag adds to match dumped tf:
  ( cpwdem                    169        cpwdem       )
  ( pwde                      170        pwde         )
  ( pwbm                      173        pwbm         )
  ( v20                       174        v20          )
  ( v5                        175        v5           )
  ( thkox                     171        thkox        )
; end jag adds
 ;System-Reserved Layers:
 ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( prBoundary                boundary   )
  ( text                      drawing    )
 ;( pwell                     drawing    )
  ( pwell                     pin        )
  ( pwell                     label      )
  ( pwell                     res        )
; ( pwelliso                  pin        )
; ( pwelliso                  label      )
  ( nwell                     drawing    )
  ( nwell                     net        )
  ( nwell                     pin        )
  ( nwell                     label      )
  ( dnwell                    drawing    )
  ( thkox                     drawing    )
  ( v5                        drawing    )
  ( v12                       drawing    )
; jag adds to match dumped tf:
  ( v20                       drawing    )
  ( pwbm                      drawing    )
  ( cpwbm                     mask       )
  ( pwde                      drawing    )
  ( cpwdem                    mask       )
; end jag adds
  ( diff                      drawing    )
  ( diff                      res        )
  ( diff                      pin        )
  ( diff                      label      )
  ( diff                      net        )
; ( diff                      dummy      )
; ( diff                      boundary   )
; ( diff                      hv         )
  ( diff                      fill       )
  ( diff                      fill_block )
 ;( tap                       drawing    )
 ;( tap                       pin        )
 ;( tap                       net        )
 ;( tap                       boundary   )
 ;( tap                       label      )
  ( psdm                      drawing    )
  ( nsdm                      drawing    )
  ( poly                      drawing    )
  ( poly                      pin        )
  ( poly                      res        )
  ( poly                      gate       )
  ( poly                      label      )
; ( poly                      boundary   )
  ( poly                      probe      )
  ( poly                      fill       )
  ( poly                      fill_block )
  ( poly                      net        )
; ( poly                      dummy      )
  ( poly                      model      )
  ( ldntm                     drawing    )
  ( lvtn                      drawing    )
  ( hvtp                      drawing    )
  ( hvtr                      drawing    )
  ( tunm                      drawing    )
  ( licon                     drawing    )
  ( licon                     grid       )
  ( licon                     blockage   )
; ( licon                     boundary   )
  ( licon                     pin        )
  ( licon                     net        )
  ( npc                       drawing    )
  ( li                       drawing     )
  ( li                       grid        )
  ( li                       pin         )
  ( li                       res         )
  ( li                       label       )
  ( li                       net         )
; ( li                       dummy       )
; ( li                       boundary    )
  ( li                       fill        )
  ( li                       blockage    )
  ( li                       probe       )
  ( mcon                      drawing    )
  ( mcon                      grid       )
  ( mcon                      blockage   )
; ( mcon                      boundary   )
  ( mcon                      pin        )
  ( mcon                      net        )
  ( met1                      drawing    )
  ( met1                      grid       )
  ( met1                      res        )
  ( met1                      pin        )
  ( met1                      label      )
  ( met1                      net        )
; ( met1                      dummy      )
; ( met1                      boundary   )
  ( met1                      blockage   )
  ( met1                      fill       )
  ( met1                      fill_block )
  ( met1                      probe      )
  ( met1                      option1    )
  ( met1                      option2    )
  ( met1                      option3    )
  ( met1                      option4    )
  ( met1                      option5    )
  ( met1                      option6    )
  ( met1                      option7    )
  ( met1                      option8    )
  ( via1                       drawing   )
  ( via1                       grid      )
  ( via1                       blockage  )
; ( via1                       boundary  )
  ( via1                       net       )
  ( via1                       pin       )
  ( met2                      drawing    )
  ( met2                      grid       )
  ( met2                      res        )
  ( met2                      pin        )
  ( met2                      label      )
  ( met2                      net        )
; ( met2                      dummy      )
; ( met2                      boundary   )
  ( met2                      blockage   )
  ( met2                      fill       )
  ( met2                      fill_block )
  ( met2                      probe      )
  ( met2                      option1    )
  ( met2                      option2    )
  ( met2                      option3    )
  ( met2                      option4    )
  ( met2                      option5    )
  ( met2                      option6    )
  ( met2                      option7    )
  ( met2                      option8    )
  ( via2                      drawing    )
  ( via2                      grid       )
  ( via2                      blockage   )
; ( via2                      boundary   )
  ( via2                      pin        )
  ( via2                      net        )
  ( met3                      drawing    )
  ( met3                      grid       )
  ( met3                      res        )
  ( met3                      pin        )
  ( met3                      label      )
  ( met3                      net        )
; ( met3                      dummy      )
; ( met3                      boundary   )
  ( met3                      blockage   )
  ( met3                      fill       )
  ( met3                      fill_block )
  ( met3                      fuse       )
  ( met3                      probe      )
  ( met3                      option1    )
  ( met3                      option2    )
  ( met3                      option3    )
  ( met3                      option4    )
  ( met3                      option5    )
  ( met3                      option6    )
  ( met3                      option7    )
  ( met3                      option8    )
  ( via3                      drawing    )
  ( via3                      grid       )
  ( via3                      blockage   )
; ( via3                      boundary   )
  ( via3                      pin        )
  ( via3                      net        )
  ( met4                      drawing    )
  ( met4                      grid       )
  ( met4                      res        )
  ( met4                      pin        )
  ( met4                      label      )
  ( met4                      net        )
; ( met4                      dummy      )
; ( met4                      boundary   )
  ( met4                      blockage   )
  ( met4                      fill       )
  ( met4                      fill_block )
  ( met4                      fuse       )
  ( met4                      probe      )
  ( met4                      option1    )
  ( met4                      option2    )
  ( met4                      option3    )
  ( met4                      option4    )
  ( met4                      option5    )
  ( met4                      option6    )
  ( met4                      option7    )
  ( met4                      option8    )
  ( via4                      drawing    )
  ( via4                      grid       )
  ( via4                      blockage   )
; ( via4                      boundary   )
  ( via4                      pin        )
  ( via4                      net        )
  ( met5                      drawing    )
  ( met5                      grid       )
  ( met5                      res        )
  ( met5                      pin        )
  ( met5                      label      )
  ( met5                      net        )
; ( met5                      dummy      )
; ( met5                      boundary   )
  ( met5                      blockage   )
  ( met5                      fill       )
  ( met5                      fill_block )
  ( met5                      fuse       )
  ( met5                      probe      )
  ( met5                      option1    )
  ( met5                      option2    )
  ( met5                      option3    )
  ( met5                      option4    )
  ( met5                      option5    )
  ( met5                      option6    )
  ( met5                      option7    )
  ( met5                      option8    )
  ( viatop		      drawing	 )
  ( nsm                       drawing    )
  ( pad                       drawing    )
  ( pad                       grid       )
  ( pad                       blockage   )
  ( pad                       label      )
  ( pad                       pin        )
  ( pnp                       drawing    )
  ( pnp                       label      )
  ( npn                       drawing    )
  ( npn                       label      )
  ( rpm                       drawing    )
; jag adds to match dumped tf:
  ( rrpm                      drawing    )
  ( urpm                      drawing    )
; end jag adds
  ( capacitor                 drawing    )
  ( ncm                       drawing    )
  ( cncm                      drawing    )
  ( cncm                      mask       )
  ( pmm                       drawing    )
  ( pmm2                      drawing    )
  ( rdl                       drawing    )
  ( rdl                       grid       )
  ( rdl                       blockage   )
  ( rdl                       pin        )
  ( rdl                       label      )
  ( rdl                       res        )
;  ( rdl                       short      )
  ( rdl                       option1    )
  ( rdl                       option2    )
  ( rdl                       option3    )
  ( rdl                       option4    )
  ( rdl                       option5    )
  ( rdl                       option6    )
  ( rdl                       option7    )
  ( rdl                       option8    )
  ( ubm                       drawing    )
  ( bump                      drawing    )
  ( inductor                  drawing    )
  ( inductor                  label      )
  ( inductor                  term1      )
  ( inductor                  term2      )
  ( inductor                  term3      )
  ( cfom                      drawing    )
  ( cfom                      mask       )
  ( cfom                      maskAdd    )
  ( cfom                      maskDrop   )
  ( cfom                      fill_block )
;  ( fom                       dummy      )
  ( fom                       fill       )
  ( cnwm                      drawing    )
  ( cnwm                      mask       )
  ( cnwm                      maskAdd    )
  ( cnwm                      maskDrop   )
  ( cdnm                      drawing    )
  ( cdnm                      mask       )
  ( cdnm                      maskAdd    )
  ( cdnm                      maskDrop   )
  ( clvtnm                    drawing    )
  ( clvtnm                    mask       )
  ( clvtnm                    maskAdd    )
  ( clvtnm                    maskDrop   )
  ( chvtpm                    drawing    )
  ( chvtpm                    mask       )
  ( chvtpm                    maskAdd    )
  ( chvtpm                    maskDrop   )
  ( chvtrm                    drawing    )
  ( chvtrm                    mask       )
  ( chvtrm                    maskAdd    )
  ( chvtrm                    maskDrop   )
  ( ctunm                     drawing    )
  ( ctunm                     mask       )
  ( ctunm                     maskAdd    )
  ( ctunm                     maskDrop   )
  ( conom                     drawing    )
  ( conom                     mask       )
  ( conom                     maskAdd    )
  ( conom                     maskDrop   )
  ( cnsdm                     drawing    )
  ( cnsdm                     mask       )
  ( cnsdm                     maskAdd    )
  ( cnsdm                     maskDrop   )
  ( cpsdm                     drawing    )
  ( cpsdm                     mask       )
  ( cpsdm                     maskAdd    )
  ( cpsdm                     maskDrop   )
  ( cntm                      drawing    )
  ( cntm                      mask       )
  ( cntm                      maskAdd    )
  ( cntm                      maskDrop   )
  ( hvntm                     drawing    )
  ( chvntm                    drawing    )
  ( chvntm                    mask       )
  ( chvntm                    maskAdd    )
  ( chvntm                    maskDrop   )
  ( cldntm                    drawing    )
  ( cldntm                    mask       )
  ( clvom                     drawing    )
  ( clvom                     mask       )
  ( clvom                     maskAdd    )
  ( clvom                     maskDrop   )
  ( cp1m                      drawing    )
  ( cp1m                      mask       )
  ( cp1m                      maskAdd    )
  ( cp1m                      fill_block )
  ( cp1m                      maskDrop   )
  ( cli1m                     drawing    )
  ( cli1m                     mask       )
  ( cli1m                     maskAdd    )
  ( cli1m                     maskDrop   )
  ( clicm1                    drawing    )
  ( clicm1                    mask       )
  ( clicm1                    maskAdd    )
  ( clicm1                    maskDrop   )
  ( cmm1                      drawing    )
  ( cmm1                      mask       )
  ( cmm1                      maskAdd    )
  ( cmm1                      maskDrop   )
  ( cmm1                      fill_block )
  ( cviam                     drawing    )
  ( cviam                     mask       )
  ( cviam                     maskAdd    )
  ( cviam                     maskDrop   )
  ( cmm2                      drawing    )
  ( cmm2                      mask       )
  ( cmm2                      maskAdd    )
  ( cmm2                      maskDrop   )
  ( cmm2                      fill_block )
  ( cviam2                    drawing    )
  ( cviam2                    mask       )
  ( cviam2                    maskAdd    )
  ( cviam2                    maskDrop   )
  ( cmm3                      drawing    )
  ( cmm3                      mask       )
  ( cmm3                      maskAdd    )
  ( cmm3                      maskDrop   )
  ( cmm3                      fill_block )
  ( cnpc                      drawing    )
  ( cnpc                      mask       )
  ( cnpc                      maskAdd    )
  ( cnpc                      maskDrop   )
  ( cviam3                    drawing    )
  ( cviam3                    mask       )
  ( cviam3                    maskAdd    )
  ( cviam3                    maskDrop   )
  ( cnsm                      mask       )
  ( cpdm                      drawing    )
  ( cpdm                      mask       )
  ( cpdm                      maskAdd    )
  ( cpdm                      maskDrop   )
  ( cpmm                      drawing    )
  ( cpbo                      mask       )
  ( cmm4                      mask       )
  ( cmm4                      maskAdd    )
  ( cmm4                      maskDrop   )
  ( cmm4                      fill_block )
  ( cviam4                    drawing    )
  ( cviam4                    mask       )
  ( cviam4                    maskAdd    )
  ( cviam4                    maskDrop   )
  ( cmm5                      mask       )
  ( cmm5                      fill_block )
  ( cviatop		      mask	 )
  ( cmtest                    drawing    )
  ( cmtest		      mask	 )
  ( cmtest		      maskDrop	 )
  ( target                    drawing    )
  ( cctm1                     drawing    )
  ( cctm1                     mask       )
  ( cctm1                     maskAdd    )
  ( cctm1                     maskDrop   )
  ( capm                      drawing    )
  ( cap2m                     drawing    )
; jag adds to match dumped tf:
  ( crrpm                     mask       )
; end jag adds
  ( crpm                      drawing    )
  ( crpm                      mask       )
  ( crpm                      maskAdd    )
  ( crpm                      maskDrop   )
; jag adds to match dumped tf:
  ( curpm                     drawing    )
  ( curpm                     mask       )
; end jag adds
  ( ccu1m                     mask       )
  ( cpmm2                     mask       )
  ( cubm                      mask       )
  ( cbump                     mask       )
  ( overlap                   drawing    )
  ( overlap                   boundary   )
  ( areaid                    lowTapDensity )
  ( areaid                    notCritSide )
  ( areaid                    injection  )
  ( areaid                    rfdiode    )
  ( areaid                    seal       )
  ( areaid                    core       )
  ( areaid                    frame      )
  ( areaid                    esd        )
  ( areaid                    dieCut     )
  ( areaid                    moduleCut  )
  ( areaid                    frameRect  )
  ( areaid                    substrateCut )
  ( areaid                    diode      )
  ( areaid                    standardc  )
  ( areaid                    deadZon    )
  ( areaid                    critCorner )
  ( areaid                    critSid    )
  ( areaid                    opcDrop    )
  ( areaid                    fillWindow )
  ( areaid                    extendedDrain )
; jag adds to match dumped tf:
; ( areaid                    extDrain20 )
; end jag adds
  ( areaid                    lvNative   )
  ( areaid                    photo      )
  ( areaid                    etest      )
  ( areaid                    hvnwell    )
  ( areaid                    rdlprobepad )
;  ( areaid                    sigPadDiff )
;  ( areaid                    sigPadWell )
;  ( areaid                    sigPadMetNtr )
  ( areaid                    analog     )
; jag adds to match dumped tf:
  ( areaid                    low_vt     )
  ( areaid                    fabBlock   )
; ( areaid                    contres    )
; jag adds for pads 6/22/20
  ( areaid                    padLength )
  ( areaid                    pad_io     )
  ( areaid                    pad_pwr    )
  ( areaid                    pad_gnd    )
  ( areaid                    guard_boundary )
  ( areaid                    lv_net     )
  ( r1c                       drawing    )
  ( r1c                       grid       )
  ( r1c                       blockage   )
; ( r1c                       boundary   )
  ( r1c                       mask       )
  ( r1c                       net        )
  ( r1c                       pin        )
  ( r1v                       drawing    )
  ( r1v                       grid       )
  ( r1v                       blockage   )
; ( r1v                       boundary   )
  ( r1v                       mask       )
  ( r1v                       net        )
  ( r1v                       pin        )
; end jag adds
  ( LVS_exclude               drawing    )
; jag removed
; ( padCenter                 drawing    )
  ( met1                      psa1       )
  ( met2                      psa1       )
  ( met3                      psa1       )
  ( met4                      psa1       )
  ( met5                      psa1       )
  ( met1                      psa2       )
  ( met2                      psa2       )
  ( met3                      psa2       )
  ( met4                      psa2       )
  ( met5                      psa2       )
  ( met1                      psa3       )
  ( met2                      psa3       )
  ( met3                      psa3       )
  ( met4                      psa3       )
  ( met5                      psa3       )
  ( met1                      psa4       )
  ( met2                      psa4       )
  ( met3                      psa4       )
  ( met4                      psa4       )
  ( met5                      psa4       )
  ( met1                      psa5       )
  ( met2                      psa5       )
  ( met3                      psa5       )
  ( met4                      psa5       )
  ( met5                      psa5       )
  ( met1                      psa6       )
  ( met2                      psa6       )
  ( met3                      psa6       )
  ( met4                      psa6       )
  ( met5                      psa6       )
  ( rdl                       psa1       )
  ( rdl                       psa2       )
  ( rdl                       psa3       )
  ( rdl                       psa4       )
  ( rdl                       psa5       )
  ( rdl                       psa6       )
  ( blanking                  drawing    )
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( text         drawing      text             t t t t t )
; jag changed valid t to valid nil
 ;( pwell        drawing      pwell            t t t t t )
  ( pwell        pin          rpolyPin         t t t t t )
  ( pwell        label        rpolyLabel       t t t t t )
  ( pwell        res          rpolyRes         t t t t t )
; ( pwelliso     pin          elm              t t t t nil )
; ( pwelliso     label        rpolyLabel       t t t t nil )
; end jag changed
  ( nwell        drawing      nwell            t t t t t )
; jag changed valid t to valid nil
  ( nwell        net          hilite1          t t t t nil )
  ( nwell        pin          nwellPin         t t t t nil )
  ( nwell        label        nwellLabel       t t t t nil )
; end jag changed
  ( dnwell       drawing      dnwell           t t t t t )
  ( v12          drawing      VhviId           t t t t t )
; jag adds new for dumped tech file:
  ( v20          drawing      uhviId           t t t t t )
  ( pwbm         drawing      pwbm             t t t t t )
  ( cpwbm        mask         cpwbmmask        t t t nil nil )
  ( pwde         drawing      redfil           t t t t t )
  ( cpwdem       mask         cmm8             t t t t nil )
; end jag changed
  ( diff         drawing      diff             t t t t t )
; ( diff         dummy         diffFill        t t t t nil )
; jag changed valid t to valid nil
  ( diff         res          diffRes          t t t t t )
; end jag changed
  ( diff         pin          diffPin          t t t t t )
  ( diff         label        diffLabel        t t t t t )
  ( diff         net          diffNet          t t t t nil )
; ( diff         boundary     diffBnd          t t t t nil )
  ( diff         hv           diffHv           t t t t t )
  ( diff         fill         diffFillF        t t t t t )
  ( diff         fill_block   diffFillB        t t t t t )
 ;( tap          drawing      tap              t t t t t )
 ;( tap          pin          tapPin           t t t t t )
 ;( tap          net          tapNet           t t t t nil )
 ;( tap          boundary     tapBnd           t t t t nil )
 ;( tap          label        tapLabel         t t t t t )
  ( psdm         drawing      psdm             t t t t t )
  ( nsdm         drawing      nsdm             t t t t t )
  ( poly         drawing      poly             t t t t t )
; ( poly         dummy        polyFill         t t t t nil )
; jag changed valid t to valid nil
  ( poly         pin          polyPin          t t t t t )
  ( poly         res          polyRes          t t t t t )
  ( poly         gate         polyGate         t t t t nil )
  ( poly         label        polyLabel        t t t t t )
; ( poly         boundary     polyBnd          t t t t nil )
  ( poly         probe        polyProbe        t t t t nil )
  ( poly         fill         polyShortF       t t t t t )
  ( poly         fill_block   polyShortB       t t t t t )
  ( poly         net          polyNet          t t t t nil )
; end jag changed
  ( poly         model        polyModel        t t t t nil )
  ( ldntm        drawing      met8             t t t t t )
  ( lvtn         drawing      lvtn             t t t t t )
  ( hvtp         drawing      hvtp             t t t t t )
  ( hvtr         drawing      hvtr             t t t t nil )
  ( tunm         drawing      tunm             t t t t t )
  ( licon        drawing      licon           t t t t t )
  ( licon        grid         licon           t nil nil nil nil )
  ( licon        blockage     licon           t nil t t nil )
; jag changed valid t to valid nil
; ( licon       boundary     liconBnd         t t t t nil )
; end jag changed
  ( licon        pin          liconPin        t t t t nil )
; jag changed valid t to valid nil
  ( licon        net          liconNet        t t t t nil )
; end jag changed
  ( npc         drawing      silm              t t t t t )
  ( li          drawing      li                t t t t t )
  ( li          fill         liShortF          t t t t t )
  ( li          grid         li                t nil nil nil nil )
  ( li          pin          liPin             t t t t t )
  ( li          res          liRes             t t t t t )
  ( li          label        liLabel           t t t t t )
; jag changed valid t to valid nil
  ( li           net          liNet            t t t t nil )
; ( li           boundary     liBnd            t t t t nil )
  ( li           blockage     liBlkg           t t t t nil )
  ( li           probe        liProbe          t t t t nil )
; end jag changed
  ( mcon         drawing      mcon             t t t t t )
  ( mcon         grid         mcon             t nil nil nil nil )
  ( mcon         blockage     mcon             t nil t t nil )
; ( mcon         boundary     mconBnd          t t t t nil )
  ( mcon         pin          mconPin          t t t t nil )
; jag changed valid t to valid nil
  ( mcon         net          mconNet          t t t t nil )
; end jag changed
  ( met1         drawing      met1             t t t t t )
; ( met1         dummy        met1Fill         t t t t nil )
  ( met1         grid         met1             t nil nil nil nil )
  ( met1         res          met1Res          t t t t t )
  ( met1         pin          met1Pin          t t t t t )
  ( met1         label        met1Label        t t t t t )
  ( met1         net          met1Net          t t t t nil )
; jag changed valid t to valid nil
; ( met1         boundary     met1Bnd          t t t t nil )
  ( met1         blockage     met1Blkg         t t t t nil )
  ( met1         fill         met1ShortF       t t t t t )
  ( met1         fill_block   met1ShortB       t t t t t )
  ( met1         probe        met1Probe        t t t t nil )
; end jag changed
  ( met1         option1      met1Metop1       t t t t nil )
  ( met1         option2      met1Metop2       t t t t nil )
  ( met1         option3      met1Metop3       t t t t nil )
  ( met1         option4      met1Metop4       t t t t nil )
  ( met1         option5      met1Metop5       t t t t nil )
  ( met1         option6      met1Metop6       t t t t nil )
  ( met1         option7      met1Metop7       t t t t nil )
  ( met1         option8      met1Metop8       t t t t nil )
  ( via1          drawing      via1            t t t t t )
  ( via1          grid         via1            t nil nil nil nil )
  ( via1          blockage     via1            t nil t t nil )
; jag changed valid t to valid nil
; ( via1          boundary     viaBnd          t t t t nil )
  ( via1          net          viaNet          t t t t nil )
; end jag changed
  ( via1          pin          viaPin           t t t t nil )
  ( met2         drawing      met2             t t t t t )
; ( met2         dummy        met2Fill         t t t t nil )
  ( met2         grid         met2             t nil nil nil nil )
  ( met2         res          met2Res          t t t t t )
  ( met2         pin          met2Pin          t t t t t )
  ( met2         label        met2Label        t t t t t )
; jag changed valid t to valid nil
  ( met2         net          met2Net          t t t t nil )
; ( met2         boundary     met2Bnd          t t t t nil )
  ( met2         blockage     met2Blkg         t t t t nil )
  ( met2         fill         met2ShortF       t t t t t )
  ( met2         fill_block   met2ShortB       t t t t t )
  ( met2         probe        met2Probe        t t t t nil )
; end jag changed
  ( met2         option1      met2Metop1       t t t t nil )
  ( met2         option2      met2Metop2       t t t t nil )
  ( met2         option3      met2Metop3       t t t t nil )
  ( met2         option4      met2Metop4       t t t t nil )
  ( met2         option5      met2Metop5       t t t t nil )
  ( met2         option6      met2Metop6       t t t t nil )
  ( met2         option7      met2Metop7       t t t t nil )
  ( met2         option8      met2Metop8       t t t t nil )
  ( via2         drawing      via2             t t t t t )
  ( via2         grid         via2             t nil nil nil nil )
  ( via2         blockage     via2             t nil t t nil )
; jag changed valid t to valid nil
; ( via2         boundary     via2Bnd          t t t t nil )
; end jag changed
  ( via2         pin          via2Pin          t t t t nil )
; jag changed valid t to valid nil
  ( via2         net          via2Net          t t t t nil )
; end jag changed
  ( met3         drawing      met3             t t t t t )
; ( met3         dummy        met3Fill         t t t t nil )
  ( met3         grid         met3             t nil nil nil nil )
  ( met3         res          met3Res          t t t t t )
  ( met3         pin          met3Pin          t t t t t )
  ( met3         label        met3Label        t t t t t )
; jag changed valid t to valid nil
  ( met3         net          met3Net          t t t t nil )
; ( met3         boundary     met3Bnd          t t t t nil )
  ( met3         blockage     met3Blkg         t t t t nil )
  ( met3         fill         met3ShortF       t t t t t   )
  ( met3         fill_block   met3ShortB       t t t t t   )
; end jag changed
  ( met3         fuse         met3Fuse         t t t t nil )
; jag changed valid t to valid nil
  ( met3         probe        met3Probe        t t t t nil )
; end jag changed
  ( met3         option1      met3Metop1       t t t t nil )
  ( met3         option2      met3Metop2       t t t t nil )
  ( met3         option3      met3Metop3       t t t t nil )
  ( met3         option4      met3Metop4       t t t t nil )
  ( met3         option5      met3Metop5       t t t t nil )
  ( met3         option6      met3Metop6       t t t t nil )
  ( met3         option7      met3Metop7       t t t t nil )
  ( met3         option8      met3Metop8       t t t t nil )
  ( via3         drawing      via3             t t t t t )
  ( via3         grid         via3             t nil nil nil nil )
  ( via3         blockage     via3             t nil t t nil )
; jag changed valid t to valid nil
; ( via3         boundary     via3Bnd          t t t t nil )
; end jag changed
  ( via3         pin          via3Pin          t t t t nil )
; jag changed valid t to valid nil
  ( via3         net          via3Net          t t t t nil )
; end jag changed
  ( met4         drawing      met4             t t t t t )
; ( met4         dummy        met4Fill         t t t t nil )
  ( met4         grid         met4             t nil nil nil nil )
  ( met4         res          met4Res          t t t t t )
  ( met4         pin          met4Pin          t t t t t )
  ( met4         label        met4Label        t t t t t )
; jag changed valid t to valid nil
  ( met4         net          met4Net          t t t t nil )
; ( met4         boundary     met4Bnd          t t t t nil )
  ( met4         blockage     met4Blkg         t t t t nil )
  ( met4         fill         met4ShortF       t t t t t   )
  ( met4         fill_block   met4ShortB       t t t t t   )
; end jag changed
  ( met4         fuse         met4Fuse         t t t t nil )
; jag changed valid t to valid nil
  ( met4         probe        met4Probe        t t t t nil )
; end jag changed
  ( met4         option1      met4Metop1       t t t t nil )
  ( met4         option2      met4Metop2       t t t t nil )
  ( met4         option3      met4Metop3       t t t t nil )
  ( met4         option4      met4Metop4       t t t t nil )
  ( met4         option5      met4Metop5       t t t t nil )
  ( met4         option6      met4Metop6       t t t t nil )
  ( met4         option7      met4Metop7       t t t t nil )
  ( met4         option8      met4Metop8       t t t t nil )
  ( via4         drawing      via4             t t t t t )
  ( via4         grid         via4             t nil nil nil nil )
  ( via4         blockage     via4             t nil t t nil )
; jag changed valid t to valid nil
; ( via4         boundary     via4Bnd          t t t t nil )
; end jag changed
  ( via4         pin          via4Pin          t t t t nil )
; jag changed valid t to valid nil
  ( via4         net          via4Net          t t t t nil )
; end jag changed
  ( met5         drawing      met5             t t t t t )
; ( met5         dummy        met5Fill         t t t t nil )
  ( met5         grid         met5             t nil nil nil nil )
  ( met5         res          met5Res          t t t t t )
  ( met5         pin          met5Pin          t t t t t )
  ( met5         label        met5Label        t t t t t )
; jag changed valid t to valid nil
  ( met5         net          met5Net          t t t t nil )
; ( met5         boundary     met5Bnd          t t t t nil )
  ( met5         blockage     met5Blkg         t t t t nil )
  ( met5         fill         met5ShortF       t t t t t   )
  ( met5         fill_block   met5ShortB       t t t t t   )
; end jag changed
  ( met5         fuse         met5Fuse         t t t t nil )
; jag changed valid t to valid nil
  ( met5         probe        met5Probe        t t t t nil )
; end jag changed
  ( met5         option1      met5Metop1       t t t t nil )
  ( met5         option2      met5Metop2       t t t t nil )
  ( met5         option3      met5Metop3       t t t t nil )
  ( met5         option4      met5Metop4       t t t t nil )
  ( met5         option5      met5Metop5       t t t t nil )
  ( met5         option6      met5Metop6       t t t t nil )
  ( met5         option7      met5Metop7       t t t t nil )
  ( met5         option8      met5Metop8       t t t t nil )
  ( viatop	 drawing      via5		t t t t nil )
  ( nsm          drawing      met8             t t t t t )
  ( pad          drawing      pad              t t t t t )
  ( pad          grid         pad              t nil nil nil nil )
  ( pad          blockage     pad              t nil t t nil )
  ( pad          label        padLabel         t t t t t )
  ( pad          pin          padPin           t t t t t )
  ( pnp          drawing      pnp              t t t t t )
  ( pnp          label        pnplabel         t t t t t )
  ( npn          drawing      npn              t t t t t )
  ( npn          label        npnlabel         t t t t t )
  ( rpm          drawing      elm              t t t t t )
; jag adds for dumped tech file:
  ( rrpm         drawing      bpm              t t t t t )
  ( urpm         drawing      rpolyRes         t t t t t )
; end jag changed
  ( thkox        drawing      tox              t t t t t )
  ( v5           drawing      hvi              t t t t t )
  ( capacitor    drawing      capacitor        t t t t t )
  ( ncm          drawing      ncm              t t t t t )
  ( cncm         drawing      cncm             t nil t t t )
; jag changed valid t to valid nil
  ( cncm         mask         cncmmask         t nil t t nil )
; end jag changed
  ( pmm          drawing      post2            t t t t t )
  ( pmm2         drawing      cesdmask         t t t t nil )
  ( rdl          drawing      met7             t t t t t )
  ( rdl          grid         met7             t nil nil nil nil )
  ( rdl          blockage     met7             t nil t t nil )
  ( rdl          pin          met7Pin          t t t t t )
  ( rdl          label        met7Label        t t t t t )
; jag changed valid t to valid nil
  ( rdl          res          rpolyRes         t t t t t )
; end jag changed
;  ( rdl          short        met7Short        t t t t nil )
  ( rdl          option1      met7Metop1       t t t t nil )
  ( rdl          option2      met7Metop2       t t t t nil )
  ( rdl          option3      met7Metop3       t t t t nil )
  ( rdl          option4      met7Metop4       t t t t nil )
  ( rdl          option5      met7Metop5       t t t t nil )
  ( rdl          option6      met7Metop6       t t t t nil )
  ( rdl          option7      met7Metop7       t t t t nil )
  ( rdl          option8      met7Metop8       t t t t nil )
  ( ubm          drawing      bpm              t t t t t )
  ( bump         drawing      npm              t t t t t )
  ( inductor     drawing      inductor         t t t t t )
  ( inductor     label        inductorLabel    t t t t t )
  ( inductor     term1        inductorTerm1    t t t t t )
  ( inductor     term2        inductorTerm2    t t t t t )
  ( inductor     term3        inductorTerm3    t t t t t )
  ( cfom         drawing      cfom             t t t t nil )
  ( cfom         mask         cfommask         t t t t nil )
; jag changed valid t to valid nil
  ( cfom         maskAdd      cfommaskAdd      t t t t nil )
  ( cfom         maskDrop     cfommaskDrop     t t t t nil )
; end jag changed
  ( cfom         fill_block   cfomwaffleDrop   t t t t nil )
; ( fom          dummy        cfom             t t t t nil )
  ( fom          fill         cfom             t t t t nil )
  ( cnwm         drawing      cnwm             t t t t nil )
  ( cnwm         mask         cnwmmask         t t t t nil )
  ( cnwm         maskAdd      cnwmmaskAdd      t t t t nil )
  ( cnwm         maskDrop     cnwmmaskDrop     t t t t nil )
  ( cdnm         drawing      cdnm             t t t t nil )
  ( cdnm         mask         cdnmmask         t t t t nil )
; jag changed valid t to valid nil
  ( cdnm         maskAdd      cdnmmaskAdd      t t t t nil )
  ( cdnm         maskDrop     cdnmmaskDrop     t t t t nil )
; end jag changed
  ( clvtnm       drawing      clvtnm           t t t t nil )
  ( clvtnm       mask         clvtnmmask       t t t t nil )
  ( clvtnm       maskAdd      clvtnmmaskAdd    t t t t nil )
  ( clvtnm       maskDrop     clvtnmmaskDrop   t t t t nil )
  ( chvtpm       drawing      chvtpm           t t t t nil )
  ( chvtpm       mask         chvtpmmask       t t t t nil )
  ( chvtpm       maskAdd      chvtpmmaskAdd    t t t t nil )
  ( chvtpm       maskDrop     chvtpmmaskDrop   t t t t nil )
  ( chvtrm       drawing      chvtrm           t t t t nil )
  ( chvtrm       mask         chvtrmmask       t t t t nil )
  ( chvtrm       maskAdd      chvtrmmaskAdd    t t t t nil )
  ( chvtrm       maskDrop     chvtrmmaskDrop   t t t t nil )
  ( ctunm        drawing      ctunm            t t t t nil )
  ( ctunm        mask         ctunmmask        t t t t nil )
; jag changed valid t to valid nil
  ( ctunm        maskAdd      ctunmmaskAdd     t t t t nil )
  ( ctunm        maskDrop     ctunmmaskDrop    t t t t nil )
  ( conom        drawing      conom            t t t t nil )
; end jag changed
  ( conom        mask         conommask        t t t t nil )
; jag changed valid t to valid nil
  ( conom        maskAdd      conommaskAdd     t t t t nil )
  ( conom        maskDrop     conommaskDrop    t t t t nil )
; end jag changed
  ( cnsdm        drawing      cnsdm            t t t t nil )
  ( cnsdm        mask         cnsdmmask        t t t t nil )
; jag changed valid t to valid nil
  ( cnsdm        maskAdd      cnsdmmaskAdd     t t t t nil )
  ( cnsdm        maskDrop     cnsdmmaskDrop    t t t t nil )
; end jag changed
  ( cpsdm        drawing      cpsdm            t t t t nil )
  ( cpsdm        mask         cpsdmmask        t t t t nil )
; jag changed valid t to valid nil
  ( cpsdm        maskAdd      cpsdmmaskAdd     t t t t nil )
  ( cpsdm        maskDrop     cpsdmmaskDrop    t t t t nil )
; end jag changed
  ( cntm         drawing      cntm             t t t t nil )
  ( cntm         mask         cntmmask         t t t t nil )
  ( cntm         maskAdd      cntmmaskAdd      t t t t nil )
  ( cntm         maskDrop     cntmmaskDrop     t t t t nil )
  ( hvntm        drawing      hvntm            t t t t t )
  ( chvntm       drawing      chvntm           t t t t nil )
  ( chvntm       mask         chvntmmask       t t t t nil )
  ( chvntm       maskAdd      chvntmmaskAdd    t t t t nil )
  ( chvntm       maskDrop     chvntmmaskDrop   t t t t nil )
  ( cldntm       drawing      cmm8             t t t t nil )
  ( cldntm       mask         cmm8mask         t t t t nil )
  ( clvom        drawing      clvom            t t t t nil )
  ( clvom        mask         clvommask        t t t t nil )
  ( clvom        maskAdd      clvommaskAdd     t t t t nil )
  ( clvom        maskDrop     clvommaskDrop    t t t t nil )
  ( cp1m         drawing      cp1m             t t t t nil )
  ( cp1m         mask         cp1mmask         t t t t nil )
; jag changed valid t to valid nil
  ( cp1m         maskAdd      cp1mmaskAdd      t t t t nil )
  ( cp1m         fill_block   cp1mwaffleDrop   t t t t nil )
  ( cp1m         maskDrop     cp1mmaskDrop     t t t t nil )
; end jag changed
  ( cli1m        drawing      cli1m            t t t t nil )
  ( cli1m        mask         cli1mmask        t t t t nil )
; jag changed valid t to valid nil
  ( cli1m        maskAdd      cli1mmaskAdd     t t t t nil )
  ( cli1m        maskDrop     cli1mmaskDrop    t t t t nil )
; end jag changed
  ( clicm1       drawing      clicm1           t t t t nil )
  ( clicm1       mask         clicm1mask       t t t t nil )
; jag changed valid t to valid nil
  ( clicm1       maskAdd      clicm1maskAdd    t t t t nil )
  ( clicm1       maskDrop     clicm1maskDrop   t t t t nil )
; end jag changed
  ( cmm1         drawing      cmm1             t t t t nil )
  ( cmm1         mask         cmm1mask         t t t t nil )
  ( cmm1         maskAdd      cmm1maskAdd      t t t t nil )
  ( cmm1         maskDrop     cmm1maskDrop     t t t t nil )
  ( cmm1         fill_block   cmm1waffleDrop   t t t t nil )
  ( cviam        drawing      cviam            t t t t nil )
  ( cviam        mask         cviammask        t t t t nil )
  ( cviam        maskAdd      cviammaskAdd     t t t t nil )
  ( cviam        maskDrop     cviammaskDrop    t t t t nil )
  ( cmm2         drawing      cmm2             t t t t nil )
  ( cmm2         mask         cmm2mask         t t t t nil )
  ( cmm2         maskAdd      cmm2maskAdd      t t t t nil )
  ( cmm2         maskDrop     cmm2maskDrop     t t t t nil )
  ( cmm2         fill_block   cmm2waffleDrop   t t t t nil )
  ( cviam2       drawing      cviam2           t t t t nil )
  ( cviam2       mask         cviam2mask       t t t t nil )
  ( cviam2       maskAdd      cviam2maskAdd    t t t t nil )
  ( cviam2       maskDrop     cviam2maskDrop   t t t t nil )
  ( cmm3         drawing      cmm3             t t t t nil )
  ( cmm3         mask         cmm3mask         t t t t nil )
  ( cmm3         maskAdd      cmm3maskAdd      t t t t nil )
  ( cmm3         maskDrop     cmm3maskDrop     t t t t nil )
  ( cmm3         fill_block   cmm3waffleDrop   t t t t nil )
  ( cnpc         drawing      csilm            t t t t nil )
  ( cnpc         mask         csilmmask        t t t t nil )
  ( cnpc         maskAdd      csilmmaskAdd     t t t t nil )
  ( cnpc         maskDrop     csilmmaskDrop    t t t t nil )
  ( cviam3       drawing      cviam3           t t t t nil )
  ( cviam3       mask         cviam3mask       t t t t nil )
  ( cviam3       maskAdd      cviam3maskAdd    t t t t nil )
  ( cviam3       maskDrop     cviam3maskDrop   t t t t nil )
  ( capm         drawing      b55capm          t t t t t )
  ( cap2m        drawing      cmm8mask         t t t t t )
  ( cnsm         mask         cmm8             t t t t nil )
  ( cpdm         drawing      cpdm             t t t t nil )
  ( cpdm         mask         cpdmmask         t t t t nil )
  ( cpdm         maskAdd      cpdmmaskAdd      t t t t nil )
  ( cpdm         maskDrop     cpdmmaskDrop     t t t t nil )
; jag changed valid t to valid nil
  ( cpmm         drawing      ccim             t t t t nil )
; end jag changed
  ( cpbo         mask         ccimmask         t t t t nil )
  ( cmm4         mask         cmm4mask         t t t t nil )
; jag changed valid t to valid nil
  ( cmm4         maskAdd      cmm4maskAdd      t t t t nil )
  ( cmm4         maskDrop     cmm4maskDrop     t t t t nil )
; end jag changed
  ( cmm4         fill_block   cmm4waffleDrop   t t t t nil )
  ( cviam4       drawing      cviam4           t t t t nil )
  ( cviam4       mask         cviam4mask       t t t t nil )
  ( cviam4       maskAdd      cviam4maskAdd    t t t t nil )
  ( cviam4       maskDrop     cviam4maskDrop   t t t t nil )
  ( cmm5         mask         cmm5mask         t t t t t )
  ( cmm5         fill_block   cmm5waffleDrop   t t t t t )
  ( cviatop      mask         cviam5mask       t t t t nil )
  ( cmtest	 drawing      met6		t t t t nil )
  ( cmtest       mask         cmm6mask         t t t t nil )
  ( cmtest       maskDrop     cmm6maskDrop     t t t t nil )
  ( target       drawing      target           t t t t nil )
  ( cctm1        drawing      cctm1            t t t t nil )
  ( cctm1        mask         cctm1mask        t t t t nil )
  ( cctm1        maskAdd      cctm1maskAdd     t t t t nil )
  ( cctm1        maskDrop     cctm1maskDrop    t t t t nil )
  ( crpm         drawing      crpm             t t t t nil )
  ( crpm         mask         crpmmask         t t t t nil )
; jag changed valid t to valid nil
  ( crpm         maskAdd      crpmmaskAdd      t t t t nil )
  ( crpm         maskDrop     crpmmaskDrop     t t t t nil )
; end jag changed
  ( ccu1m        mask         met7             t t nil nil nil )
  ( cpmm2        mask         cesdmask         t t nil nil nil )
  ( cubm         mask         bpm              t t nil nil nil )
  ( cbump        mask         npm              t t nil nil nil )
  ( curpm        mask         npm              t t nil nil nil )
  ( crrpm        mask         npm              t t nil nil nil )
  ( curpm        drawing      npm              t t nil nil nil )
; jag changed valid t to valid nil
  ( overlap      drawing      overlap          t t t t nil )
  ( overlap      boundary     overlapBnd       t t t t nil )
  ( areaid       lowTapDensity areaidDualMemory t t t t nil )
; end jag changed
  ( areaid       notCritSide  areaidTcamMemory t t t t nil )
; jag changed valid t to valid nil
  ( areaid       injection    per              t t t t nil )
  ( areaid       rfdiode      fix              t t t t nil )
; end jag changed
  ( areaid       seal         areaidseal       t t t t t )
  ( areaid       core         areaidcore       t t t t t )
  ( areaid       frame        areaidframe      t t t t t )
  ( areaid       esd          areaidesd        t t t t t )
  ( areaid       dieCut       areaiddieCut     t t t t t )
  ( areaid       moduleCut    areaidmoduleCut  t t t t t )
  ( areaid       frameRect    areaidframeRect  t t t t t )
; ( areaid       contres      polyContin       t t t t t )
  ( areaid       substrateCut areaidsubstrateCut2 t t t t t )
  ( areaid       diode        areaidde         t t t t t )
  ( areaid       standardc    areaidStandardc  t t t t t )
  ( areaid       deadZon      areaiddn         t t t t t )
  ( areaid       critCorner   areaidcr         t t t t t )
  ( areaid       critSid      areaidcd         t t t t t )
  ( areaid       opcDrop      areaidopcDrop    t t t t t )
  ( areaid       fillWindow   areaidWaffleWindow t t t t t )
  ( areaid       extendedDrain areaidextendedDrain t t t t t )
; jag adds for dumped tech file:
; ( areaid       extDrain20   areaidextDrain20 t t t t t )
; end jag changed
  ( areaid       lvNative     areaidTcamMemory t t t t t )
  ( areaid       photo        areaidprobe      t t t t t )
  ( areaid       etest        cmsm             t t t t t )
  ( areaid       hvnwell      msm              t t t t nil )
  ( areaid       rdlprobepad  areaidprobe      t t t t t )
; jag changed valid t to valid nil
; ( areaid       sigPadDiff   overlap          t t t t nil )
; ( areaid       sigPadWell   feedthru         t t t t nil )
; ( areaid       sigPadMetNtr overlapBnd       t t t t nil )
  ( areaid       analog       areaidanalog     t t t t nil )
  ( LVS_exclude  drawing      prunedg          t t t t nil )
; end jag changed
; jag adds for dumped tech file:
  ( areaid       low_vt       low_vt           t t t t t )
  ( areaid       fabBlock     areaidTcamMemory t t t t nil )
; jag adds for pads 6/22/20
  ( areaid       padLength    areaidPadLength  nil t t t nil )
; end jag changed
  ( areaid       pad_io       ioId             t t t t t )
  ( areaid       pad_pwr      pwrId            t t t t t )
  ( areaid       pad_gnd      gndId            t t t t t )
  ( areaid       guard_boundary gbId           t t t t nil )
  ( areaid       lv_net       areaidlvnet      t t t t nil )
  ( r1c          drawing      cmm1             t t t t nil )
  ( r1c          grid         cmm1             nil nil nil nil nil )
  ( r1c          blockage     cmm1             nil t t t nil )
; ( r1c          boundary     cmm1             nil t t t nil )
  ( r1c          mask         met3Short        nil t t t nil )
  ( r1c          net          cmm1             nil t t t nil )
  ( r1c          pin          cmm1             nil t t t nil )
  ( r1v          drawing      ncm              t t t t nil )
  ( r1v          grid         ncm              nil nil nil nil nil )
  ( r1v          blockage     ncm              nil t t t nil )
; ( r1v          boundary     ncm              nil t t t nil )
  ( r1v          mask         met4Fuse         nil t t t nil )
  ( r1v          net          ncm              nil t t t nil )
  ( r1v          pin          ncm              nil t t t nil )
; end jag changed
; jag removed
; ( padCenter    drawing      target           t t t t nil )
; jag changed valid t to valid nil
  ( met1         psa1         met1Psa1         t t t t nil )
  ( met2         psa1         met2Psa1         t t t t nil )
  ( met3         psa1         met3Psa1         t t t t nil )
  ( met4         psa1         met4Psa1         t t t t nil )
  ( met5         psa1         met5Psa1         t t t t nil )
  ( met1         psa2         met1Psa2         t t t t nil )
  ( met2         psa2         met2Psa2         t t t t nil )
  ( met3         psa2         met3Psa2         t t t t nil )
  ( met4         psa2         met4Psa2         t t t t nil )
  ( met5         psa2         met5Psa2         t t t t nil )
  ( met1         psa3         met1Psa3         t t t t nil )
  ( met2         psa3         met2Psa3         t t t t nil )
  ( met3         psa3         met3Psa3         t t t t nil )
  ( met4         psa3         met4Psa3         t t t t nil )
  ( met5         psa3         met5Psa3         t t t t nil )
  ( met1         psa4         met1Psa4         t t t t nil )
  ( met2         psa4         met2Psa4         t t t t nil )
  ( met3         psa4         met3Psa4         t t t t nil )
  ( met4         psa4         met4Psa4         t t t t nil )
  ( met5         psa4         met5Psa4         t t t t nil )
  ( met1         psa5         met1Psa5         t t t t nil )
  ( met2         psa5         met2Psa5         t t t t nil )
  ( met3         psa5         met3Psa5         t t t t nil )
  ( met4         psa5         met4Psa5         t t t t nil )
  ( met5         psa5         met5Psa5         t t t t nil )
  ( met1         psa6         met1Psa6         t t t t nil )
  ( met2         psa6         met2Psa6         t t t t nil )
  ( met3         psa6         met3Psa6         t t t t nil )
  ( met4         psa6         met4Psa6         t t t t nil )
  ( met5         psa6         met5Psa6         t t t t nil )
  ( rdl          psa1         met7Psa1         t t t t nil )
  ( rdl          psa2         met7Psa2         t t t t nil )
  ( rdl          psa3         met7Psa3         t t t t nil )
  ( rdl          psa4         met7Psa4         t t t t nil )
  ( rdl          psa5         met7Psa5         t t t t nil )
  ( rdl          psa6         met7Psa6         t t t t nil )
; end jag changed
  ( blanking     drawing      post2            t t t t nil )
 ) ;techDisplays

 techLayerProperties(
 ;( PropName               Layer1 [ Layer2 ]            PropValue )
 ;( --------               ------ ----------            --------- )
  ( sheetResistance        nwell                          1700.000000 )
  ( sheetResistance        diff                           120.000000 )
  ( areaCapacitance        poly                           1.060000e-04 )
  ( edgeCapacitance        poly                           1.030000e-05 )
  ( sheetResistance        poly                           48.200001 )
  ( thickness              poly                           0.18 )
  ( areaCapacitance        met1                           2.580000e-05 )
  ( edgeCapacitance        met1                           1.790000e-06 )
  ( sheetResistance        met1                           0.125000 )
  ( thickness              met1                           0.35 )
  ( areaCapacitance        met2                           1.750000e-05 )
  ( edgeCapacitance        met2                           1.220000e-06 )
  ( sheetResistance        met2                           0.125000 )
  ( thickness              met2                           0.35 )
  ( areaCapacitance        met3                           1.260000e-05 )
  ( edgeCapacitance        met3                           1.860000e-06 )
  ( sheetResistance        met3                           0.047000 )
  ( thickness              met3                           0.8 )
  ( areaCapacitance        met4                           8.670000e-06 )
  ( edgeCapacitance        met4                           1.290000e-06 )
  ( sheetResistance        met4                           0.047000 )
  ( thickness              met4                           0.8 )
  ( areaCapacitance        met5                           6.480000e-06 )
  ( edgeCapacitance        met5                           4.960000e-06 )
  ( sheetResistance        met5                           0.028500 )
  ( thickness              met5                           1.2 )
  ( areaCapacitance        li                             3.690000e-05 )
  ( edgeCapacitance        li                             3.260000e-06 )
  ( sheetResistance        li                             12.200000 )
  ( thickness              li                             0.1 )
  ( areaCapacitance        rdl                            2.660000e-06 )
  ( edgeCapacitance        rdl                            6.200000e-06 )
  ( sheetResistance        rdl                            0.005000 )
  ( thickness              rdl                            2.0 )
 ) ;techLayerProperties

 techDerivedLayers(
 ;( DerivedLayerName          #          composition  )
 ;( ----------------          ------     ------------ )
  ( ntap                      10035           ( nsdm       'and    nwell     ))
  ( ptap                      10036           ( psdm       'not    nwell     ))
  ( polycutoxide              10037           ( diff       'not    poly      ))
  ( gate                      10038           ( diff       'and    poly      ))
  ( polylicon                 10039           ( poly       'and    licon     ))
  ( diffv5                    10040           ( diff       'and    v5        ))
 ) ;techDerivedLayers
) ;layerDefinitions


;********************************
; LAYER RULES
;********************************
layerRules(

 equivalentLayers(
 ;( list of layers )
 ;( -------------- )
 ) ;equivalentLayers

 functions(
 ;( layer                       function        [maskNumber])
 ;( -----                       --------        ------------)
  ( pwell                    	"pwell"      		1)
  ( nwell                    	"nwell"      		2)
  ( dnwell                    	"deepNwell"    		3)
  ( diff                     	"diff"      		4)
  ( nsdm                     	"nimplant"     		5)
  ( psdm                     	"pimplant"     		6)
  ( poly                     	"poly"       		7)
  ( npc                     	"nwell"     		8)
  ( licon                      	"cut"       		9)
  ( li                       	"metal"      		10)
  ( mcon                      	"cut"      		11)
  ( met1                     	"metal"      		12)
  ( via1			"cut"			13)
  ( met2                     	"metal"      		14)
  ( via2			"cut"			15)
  ( met3                     	"metal"      		16)
  ( via3			"cut"			17)
  ( met4                     	"metal"      		18)
  ( via4			"cut"			19)
  ( met5                     	"metal"      		20)
  ( rdl                      	"metal"      		21)
 ) ;functions

 mfgResolutions(
 ;( layer                       mfgResolution )
 ;( -----                       ------------- )
 ) ;mfgResolutions

 routingDirections(
 ;( layer                       direction     )
 ;( -----                       ---------     )
 ) ;routingDirections

 incompatibleLayers(
 ;( layer                       incompatibleLayers       )
 ;( -----                       ------------------       )
 ) ;incompatibleLayers

 labelLayers(
 ;( textLayer   layers        )
 ;( ---------   ----------------------------------        )
 ) ;labelLayers

 stampLabelLayers(
 ;( textLayer   layers        )
 ;( ---------   ----------------------------------        )
 ) ;stampLabelLayers

 backsideLayers(
 ; layerName1 layerName2 ... 
 ; ---------------------------------------------------------------------- 
  
 ) ;backsideLayers

 currentDensity(
 ;( rule                	layer1    	layer2    	value    )
 ;( ----                	------    	------    	-----    )
 ) ;currentDensity

 currentDensityTables(
 ;( rule                	layer1    
 ;  (( index1Definitions	[index2Definitions]) [defaultValue] )
 ;  (table))
 ;( ----------------------------------------------------------------------)
 ) ;currentDensityTables

 cutClasses(
 ;( layerName    )
 ;(   (cutClassName                                        (width length)) )
 ;( ---------------------------------------------------------------------- )
 ) ;cutClasses

) ;layerRules


;********************************
; VIADEFS
;********************************
viaDefs(

 standardViaDefs(
 ;( viaDefName	layer1	layer2	(cutLayer cutWidth cutHeight [resistancePerCut]) 
 ;   (cutRows	cutCol	(cutSpace)	[(l_cutPattern)]) 
 ;   (layer1Enc) (layer2Enc)	(layer1Offset)	(layer2Offset)	(origOffset) 
 ;   [implant1	 (implant1Enc)	[implant2	(implant2Enc) [well/substrate]]]) 
 ;( -------------------------------------------------------------------------- ) 
  ( M4M5      	met5        met4        	("via4" 0.8 0.8 0.38)
     (1 1 (0.8 0.8))
     (0.31 0.31)	(0.06 0.06)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M3M4      	met4        met3        	("via3" 0.2 0.2 3.41)
     (1 1 (0.2 0.2))
     (0.065 0.065)	(0.09 0.06)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M2M3      	met3        met2        	("via2" 0.2 0.2 3.41)
     (1 1 (0.2 0.2))
     (0.065 0.065)	(0.085 0.065)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M1M2      	met2        met1        	("via1" 0.15 0.15 4.5)
     (1 1 (0.17 0.17))
     (0.085 0.055)	(0.085 0.055)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( L1M1      	met1        li          	("mcon" 0.17 0.17 9.3)
     (1 1 (0.19 0.19))
     (0.06 0.03)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( PYL1      	poly        li          	("licon" 0.17 0.17 145.28)
     (1 1 (0.17 0.17))
     (0.08 0.05)	(0.08 0.00)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
     nil         	nil	npc         	(0.1 0.1)
  )
  ( DFL1      	li          diff       	("licon" 0.17 0.17 600.0)
     (1 1 (0.17 0.17))
     (0.08 0.08)	(0.12 0.12)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( NPDF      	li          diff       	("licon" 0.17 0.17 600.0)
     (1 1 (0.17 0.17))
     (0.08 0.08)	(0.12 0.12)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
     nil         	nil	nsdm         	(0.02 0.02)
  )
  ( PPDF      	li         diff       	("licon" 0.17 0.17 600.0)
     (1 1 (0.17 0.17))
     (0.08 0.08)	(0.12 0.12)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
     nil         	nil	psdm         	(0.02 0.02)
  )
  ( NTAP      	li         diff       	("licon" 0.17 0.17 600.0)
     (1 1 (0.17 0.17))
     (0.08 0.08)	(0.12 0.12)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
     nil         	nil	nsdm         	(0.125 0.125)
  )
  ( PTAP      	li         diff       	("licon" 0.17 0.17 600.0)
     (1 1 (0.17 0.17))
     (0.08 0.08)	(0.12 0.12)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
     nil         	nil	psdm         	(0.125 0.125)
  )
 ) ;standardViaDefs

) ;viaDefs



;********************************
; CONSTRAINT GROUPS
;********************************
constraintGroups(
 ;( group       [override] )
 ;( -----       ---------- )
  ( "virtuosoDefaultExtractorSetup"     nil

    interconnect(
     ( validLayers   (polycutoxide gate poly li  met1  met2  met3  met4  met5  ) )
     ( validVias     (DFL1 PPDF NPDF PTAP NTAP PYL1 L1M1 M1M2  M2M3  M3M4  M4M5  ) )
    ) ;interconnect
  ) ;virtuosoDefaultExtractorSetup

 ;( group       [override] )
 ;( -----       ---------- )
  ( "virtuosoDefaultSetup"      nil

    interconnect(
     ( validLayers   (polycutoxide poly  li  met1  met2  met3  met4  met5  ) )
     ( validVias     (DFL1 PPDF NPDF PTAP NTAP PYL1 L1M1 M1M2  M2M3  M3M4  M4M5  ) )
    ) ;interconnect
  ) ;virtuosoDefaultSetup


 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "foundry"	nil
   interconnect(
     ( validLayers   (polycutoxide gate poly  li  met1  met2  met3  met4  met5  ) )
     ( validVias     (DFL1 PPDF NPDF PTAP NTAP PYL1 L1M1 M1M2  M2M3  M3M4  M4M5  ) )
    ) ;interconnect

    spacings(
     ( minWidth                   "poly"        0.1 )
     ( minSpacing                 "poly"        0.18 )
     ( minWidth                   "li"          0.13 )
     ( minSpacing                 "li"          0.17 )
     ;( minWidth                  "met1"        0.14 )
     ;( minSpacing                "met1"        0.14 )
     ;( minWidth                  "met2"        0.14 )
     ;( minSpacing                "met2"        0.14 )
     ;( minWidth                  "met3"        0.24 )
     ;( minSpacing                "met3"        0.24 )
     ;( minWidth                  "met4"        0.24 )
     ;( minSpacing                "met4"        0.24 )
     ( minWidth                   "met5"        0.36 )
     ( minSpacing                 "met5"        0.36 )
     ( minSpacing                 "licon"       0.17 )
     ( minSpacing                 "mcon"        0.19 )
     ( minSpacing                 "via1"        0.17 )
     ( minSpacing                 "via2"        0.20 )
     ( minSpacing                 "via3"        0.20 )
     ( minSpacing                 "via4"        0.80 )
    ) ;spacings

    orderedSpacings(
     ( minExtensionDistance       "rdl"         "pad"           10.75 )
     ( minExtensionDistance       "met5"        "via4"          0.31 )
     ( minExtensionDistance       "met4"        "via4"          0.06 )
     ( minExtensionDistance       "met4"        "via3"          0.065 )
     ( minExtensionDistance       "met3"        "via3"          0.06 )
     ( minExtensionDistance       "met3"        "via2"          0.065 )
     ( minExtensionDistance       "met2"        "via2"          0.04 )
     ( minExtensionDistance       "poly"        "licon"         0.05 )
     ( minExtensionDistance       "met5"        "pad"           2.7 )
     ( minExtensionDistance       "met2"        "via1"          0.055 )
     ( minExtensionDistance       "met1"        "via1"          0.055 )
     ( minExtensionDistance       "met1"        "mcon"          0.03 )
     ( minExtensionDistance       ("cap2m"      "drawing")    ("via4" "drawing")       0.2 )
     ( minExtensionDistance       ("capm"       "drawing")    ("via3" "drawing")      0.14 )
     ( minExtensionDistance       "nwell"       "capacitor"             1.5 )
     ( minExtensionDistance       "li"          "mcon"          0.0 )
     ( minExtensionDistance       "npc" "licon"                 0.1 )
    ;( minExtensionDistance       "tap" "licon"                 0.12 )
    ;
    ;( minExtensionDistance       "diff"        "licon" 'insideLayers("nsdm" "ntap") 0.12 )
    ;( minExtensionDistance       "diff"        "licon" 'insideLayers("psdm" "ptap") 0.12 )
    ;( minExtensionDistance       "diff"        "licon" 'outsideLayers("ntap")  0.04 )
    ;( minExtensionDistance       "diff"        "licon" 'outsideLayers("ptap")  0.04 )
    ;
     ( minExtensionDistance       "li" "licon"                  0.00 )
     ( minExtensionDistance       "nwell"       "diff"          0.18 )
     ( minExtensionDistance       "dnwell"      "nwell"         0.4  )
     ( minOppExtension 		  "li"          "licon"  (0.08 0.05) )  
     ( minOppExtension 		  "poly"        "licon"  (0.08 0.05) )  
     ( minOppExtension 		  "met1"        "mcon"   (0.06 0.03) )  
     ( minOppExtension 		  "met1"        "via1"   (0.085 0.055) )  
     ( minOppExtension 		  "met2"        "via1"   (0.085 0.055) )  
     ( minOppExtension 		  "met2"        "via2"   (0.085 0.055) )  
     ( minOppExtension 		  "met3"        "via2"   (0.085 0.065) )  
     ( minOppExtension 		  "met3"        "via3"   (0.06 0.09) )  
    ) ;orderedSpacings

   spacings(
     ( minWidth                   "pad" 60.0 )
     ( minWidth                   "rdl" 10.0 )
     ( minWidth                   "met5"        1.6 )
     ( minWidth                   "via4"        0.8 )
     ( minWidth                   "met4"        0.3 )
     ( minWidth                   "via3"        0.2 )
     ( minWidth                   "met3"        0.3 )
     ( minWidth                   "via2"        0.2 )
     ( minWidth                   "hvtr"        0.38 )
     ( minWidth                   "hvntm"       0.7 )
     ( minWidth                   "hvtp"        0.38 )
     ( minWidth                   "ncm"         0.38 )
     ( minWidth                   "nsm"         3.0 )
     ( minWidth                   "met2"        0.14 )
     ( minWidth                   "via1"        0.15 )
     ( minWidth                   "met1"        0.14 )
     ( minWidth                   "capacitor"   1.43 )
     ( minWidth                   "mcon"        0.17 )
     ( minWidth                   "licon"       0.17 )
     ( minWidth                   "poly"        0.15 )
     ( minWidth                   "v5"          0.6 )
     ( minWidth                   "ldntm"       0.7 )
     ( minWidth                   "lvtn"        0.38 )
     ( minWidth                   "li"          0.17 )
     ( minWidth                   "npc"         0.27 )
     ( minWidth                   "psdm"        0.38 )
     ( minWidth                   "nsdm"        0.38 )
     ( minWidth                   "tunm"        0.41 )
     ( minWidth                   "diff"        0.15 )
     ( minWidth                   "nwell"       0.84 )
     ( minWidth                   "dnwell"      3.0 )
     ( minWidth                   ("cap2m" "drawing")   2.0 )
     ( minWidth                   ("capm" "drawing")    2.0 )
     ( minArea                    "met4"        0.24 )
     ( minArea                    "met3"        0.24 )
     ( minArea                    "met2"        0.0676 )
     ( minArea                    "met1"        0.083 )
     ( minArea                    "psdm"        0.255 )
     ( minArea                    "nsdm"        0.265 )
     ( minArea                    "tunm"        0.672 )
     ( minHoleArea                "met2"        0.14 )
     ( minHoleArea                "met1"        0.14 )
     ( minSpacing                 "rdl" 10.0 )
     ( minSpacing                 "met5"        1.6 )
     ( minSpacing                 "via4"        0.8 )
     ( minSpacing                 "via3"        0.2 )
     ( minSpacing                 "via2"        0.2 )
     ( minSpacing                 "hvtr"        0.38 )
     ( minSpacing                 "hvntm"       0.7 )
    ( minSpacing                 "hvtp"         0.38 )
     ( minSpacing                 "ncm"         0.38 )
     ( minSpacing                 "pad"         1.27 )
     ( minSpacing                 ("cap2m" "drawing")   0.84 )
     ( minSpacing                 ("capm" "drawing")    0.84 )
     ( minSpacing                 "nsm"         4.0 )
     ( minSpacing                 "via1"        0.17 )
     ( minSpacing                 "mcon"        0.19 )
     ( minSpacing                 "licon"       0.17 )
    ;( minSpacing                 "poly"        "tap" 0.055 )
     ( minSpacing                 "poly"        "diff"  0.075 )
     ( minSpacing                 "poly"        0.21 )
     ( minSpacing                 "v5"  "nwell"         0.7 )
     ( minSpacing                 "polylicon"  "diff"   0.19 )
     ( minSpacing                 "v5"  0.7 )
     ( minSpacing                 "ldntm"       0.7 )
     ( minSpacing                 "lvtn"        "hvtp"          0.38 )
     ( minSpacing                 "lvtn"        0.38 )
     ( minSpacing                 "li"          0.17 )
     ( minSpacing                 "npc"         0.27 )
     ( minSpacing                 "psdm"        0.38 )
     ( minSpacing                 "nsdm"        0.38 )
     ( minSpacing                 "tunm"        0.5 )
    ;( minSpacing                 "tap"         "nwell"         0.34 )
    ;( minSpacing                 "diff"        "nwell"         0.34 )
    ;( minSpacing                 "diff"        "tap"           0.27 )
    ;( minSpacing                 "tap" 0.27 )
     ( minSpacing                 "diff"        0.27 )
     ( minSpacing                 "diffv5"      0.30 )
     ( minSpacing                 "nwell"       "dnwell"                4.5 )
     ( minSpacing                 "nwell"       1.27 )
     ( minSpacing                 "dnwell"      6.3 )
     ( minSameNetSpacing          ("via3" "drawing")     ("via4" "drawing")             0.0 )
     ( minSameNetSpacing          ("via2" "drawing")    ("via3" "drawing")              0.0 )
     ( minSameNetSpacing          ("via1" "drawing")    ("via3" "drawing")              0.0 )
     ( minSameNetSpacing          ("via1" "drawing")    ("via2" "drawing")              0.0 )
     ( minSameNetSpacing          ("mcon" "drawing")    ("via3" "drawing")              0.0 )
     ( minSameNetSpacing          ("mcon" "drawing")    ("via2" "drawing")              0.0 )
     ( minSameNetSpacing          ("mcon" "drawing")    ("via1" "drawing")              0.0 )
     ( minSameNetSpacing          ("met5" "drawing")    1.6 )
     ( minSameNetSpacing          ("met4" "drawing")    0.3 )
     ( minSameNetSpacing          ("via3" "drawing")    0.2 )
     ( minSameNetSpacing          ("met3" "drawing")    0.3 )
     ( minSameNetSpacing          ("via2" "drawing")    0.2 )
     ( minSameNetSpacing          ("met2" "drawing")    0.14 )
     ( minSameNetSpacing          ("via1" "drawing")    0.17 )
     ( minSameNetSpacing          ("met1" "drawing")    0.14 )
     ( minSameNetSpacing          ("mcon" "drawing")    0.19 )
    ) ;spacings
    routingGrids(
     ( horizontalOffset           "met5"        1.555 )
     ( verticalOffset             "met5"        1.555 )
     ( horizontalOffset           "met4"        0.305 )
     ( verticalOffset             "met4"        0.305 )
     ( horizontalOffset           "met3"        0.305 )
     ( verticalOffset             "met3"        0.305 )
     ( horizontalOffset           "met2"        0.185 )
     ( verticalOffset             "met2"        0.185 )
     ( horizontalOffset           "met1"        0.185 )
     ( verticalOffset             "met1"        0.185 )
    ) ;routingGrids

    spacingTables(
    ;( constraint               layer1              [layer2]
    ;   (( index1Definitions    [index2Defintions]) [defaultValue] )
    ;   ( table) )
    ;( --------------------------------------------)
     ( minSpacing                "met1"
        (( "width" nil nil )    0.14 )
         (
            0.0       0.14
            3.005     0.28
         )
     )
     ( minStubInfluenceSpacing   "met1"
        (( "width"   nil  nil    "distance"   nil   nil  )       )
        (
           (3.005       0.28      )     0.28
        )
     )
     ( minSpacing                "met2"
        (( "width" nil nil )    0.14 )
         (
            0.0       0.14
            3.005     0.28
         )
     )
    ( minStubInfluenceSpacing   "met2"
        (( "width"   nil  nil    "distance"   nil   nil  )       )
        (
           (3.005       0.28      )     0.28
        )
     )
     ( minSpacing                "met3"
        (( "width" nil nil )    0.3 )
         (
            0.0       0.3
            3.005     0.4
         )
     )
     ( minStubInfluenceSpacing   "met3"
        (( "width"   nil  nil    "distance"   nil   nil  )       )
        (
           (3.005       0.4       )     0.4
        )
     )
     ( minSpacing                "met4"
        (( "width" nil nil )    0.3 )
         (
            0.0       0.3
            3.005     0.4
         )
     )
     ( minStubInfluenceSpacing   "met4"
        (( "width"   nil  nil    "distance"   nil   nil  )       )
        (
           (3.005       0.4       )     0.4
        )
     )
    ) ;spacingTables

    antennaModels(
    ;( model )
    ;( ----- )
     ( "default"
       antenna(
        ( areaRatio          "via4"     6.0 )
        ( diffAreaRatio      "via4"
           (
              ( 0.0 6.0 )
              ( 0.0125 6.0 )
              ( 0.0225 6.81 )
              ( 22.5 816.0 )
           )
        )
       ) ;antenna
       antenna(
        ( areaRatio          "via3"     6.0 )
        ( diffAreaRatio      "via3"
           (
              ( 0.0 6.0 )
              ( 0.0125 6.0 )
              ( 0.0225 6.81 )
              ( 22.5 816.0 )
           )
        )
       ) ;antenna
      antenna(
        ( areaRatio          "via2"     6.0 )
        ( diffAreaRatio      "via2"
           (
              ( 0.0 6.0 )
              ( 0.0125 6.0 )
              ( 0.0225 6.81 )
              ( 22.5 816.0 )
           )
        )
       ) ;antenna
       antenna(
        ( areaRatio          "via1"     6.0 )
        ( diffAreaRatio      "via1"
           (
              ( 0.0 6.0 )
              ( 0.0125 6.0 )
              ( 0.0225 6.81 )
              ( 22.5 816.0 )
           )
        )
       ) ;antenna
       antenna(
        ( areaRatio          "mcon"     3.0 )
        ( diffAreaRatio      "mcon"
           (
              ( 0.0 3.0 )
              ( 0.0125 3.0 )
              ( 0.0225 3.405 )
              ( 22.5 408.0 )
           )
        )
       ) ;antenna
       antenna(
        ( areaRatio          "met5"       400.0 'side )
        ( diffAreaRatio      "met5"
           (
              ( 0.0 400.0 )
              ( 0.0125 400.0 )
              ( 0.0225 2609.0 )
              ( 22.5 11600.0 )
           )
        'side )
       ) ;antenna
       antenna(
        ( areaRatio          "met4"       400.0 'side )
        ( diffAreaRatio      "met4"
           (
              ( 0.0 400.0 )
              ( 0.0125 400.0 )
              ( 0.0225 2609.0 )
              ( 22.5 11600.0 )
           )
        'side )
       ) ;antenna
       antenna(
        ( areaRatio          "met2"       400.0 'side )
        ( diffAreaRatio      "met2"
           (
              ( 0.0 400.0 )
              ( 0.0125 400.0 )
              ( 0.0225 2609.0 )
              ( 22.5 11600.0 )
           )
        'side )
       ) ;antenna
       antenna(
        ( areaRatio          "met1"       400.0 'side )
        ( diffAreaRatio      "met1"
           (
              ( 0.0 400.0 )
              ( 0.0125 400.0 )
              ( 0.0225 2609.0 )
              ( 22.5 11600.0 )
           )
        'side )
       ) ;antenna
     antenna(
        ( areaRatio          "met1"       400.0 'side )
        ( diffAreaRatio      "met1"
           (
              ( 0.0 400.0 )
              ( 0.0125 400.0 )
              ( 0.0225 2609.0 )
              ( 22.5 11600.0 )
           )
        'side )
       ) ;antenna
       antenna(
        ( areaRatio          "li"       75.0 'side )
        ( diffAreaRatio      "li"
           (
              ( 0.0 75.0 )
              ( 0.0125 75.0 )
              ( 0.0225 85.125 )
              ( 22.5 10200.0 )
           )
        'side )
       ) ;antenna
       cumulativeMetalAntenna(
        ( areaRatio                 0.0 'side )
       ) ;cumulativeMetalAntenna
       cumulativeViaAntenna(
        ( areaRatio               0.0 )
       ) ;cumulativeViaAntenna
     ) ;default
    ) ;antennaModels

    ;spacings(
    ;( constraint               layer1          [layer2]        value  )
    ;( ----------               ------          --------        -----  )
    ;( defaultWidth               "via4"        0.8 )
    ;( defaultWidth               "via3"        0.2 )
    ;( defaultWidth               "via2"        0.2 )
    ;( defaultWidth               "via1"        0.15 )
    ;( defaultWidth               "mcon"        0.17 )
    ;( defaultWidth               "licon"       0.17 )
    ;( defaultWidth               "diff"        0.15 )
    ;) ;spacings

    ;electrical(
    ;( constraint               layer1          [layer2]        value  )
    ;( ----------               ------          --------        -----  )
    ;( currentden                 "via4"        0.0072 )
    ;( currentden                 "via3"        0.0027 )
    ;( currentden                 "via2"        0.0027 )
    ;( currentden                 "met5"        0.016272 )
    ;( currentden                 "met4"        0.00204 )
    ;( currentden                 "met3"        0.00204 )
    ;( currentden                 "via1"        0.002025 )
    ;( currentden                 "mcon"        0.002295 )
    ;( currentden                 "met2"        0.000392 )
    ;( currentden                 "met1"        0.000392 )
    ;) ;electrical
    ;orderedElectrical(
    ;( constraint               layer1          layer2          value  )
    ;( ----------               ------          ------          ------  )
    ;( parallelCap                ("rdl" "drawing")     ("diff" "drawing")      5.45e-05 )
    ;( parallelCap                ("met5" "drawing")    ("diff" "drawing")      6.47e-05 )
    ;( parallelCap                ("met4" "drawing")    ("diff" "drawing")      0.000108 )
    ;( parallelCap                ("met3" "drawing")    ("diff" "drawing")      0.000107 )
    ;( parallelCap                ("met2" "drawing")    ("diff" "drawing")      0.000106 )
    ;( parallelCap                ("met1" "drawing")    ("diff" "drawing")      0.000105 )
    ;( parallelCap                ("li"   "drawing")    ("diff" "drawing")      7.98e-05 )
    ;( parallelCap                ("poly" "drawing")    ("diff" "drawing")      7.61e-05 )
   ; ) ;orderedElectrical
  ) ;foundry

) ;constraintGroups

constraintGroups(
( "LEFDefaultRouteSpec"
; layer constraints
interconnect(
   ( validLayers ( met1 met2 met3 met4 met5 ) )
   ( validVias   (M1M2  M2M3  M3M4  M4M5  ) )
) ;interconnect
) ;LEFDefaultRouteSpec
) ;constraintGroups


;********************************
; DEVICES
;********************************

devices(
tcCreateCDSDeviceClass()

multipartPathTemplates(
; ( name [masterPath] [offsetSubpaths] [encSubPaths] [subRects] )
; 
;   masterPath:
;   (layer [width] [choppable] [endType] [beginExt] [endExt] [justify] [offset]
;   [connectivity])
; 
;   offsetSubpaths:
;   (layer [width] [choppable] [separation] [justification] [begOffset] [endOffset]
;   [connectivity])
; 
;   encSubPaths:
;   (layer [enclosure] [choppable] [begOffset] [endOffset]
;   [connectivity])
; 
;   subRects:
;   (layer [width] [length] [choppable] [separation] [justification] [space] [begOffset] [endOffset] [gap] 
;   [connectivity] [beginSegOffset] [endSegOffset])
; 
;   connectivity:
;   ([I/O type] [pin] [accDir] [dispPinName] [height] [ layer]
;    [layer] [justification] [font] [textOptions] [orientation]
;    [refHandle] [offset])
; 
; ( --------------------------------------------------------------------- )
  (poly_li 
    (("poly" "drawing")	0.33	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	0.00	t	0.0	0.0)
     (("npc" "drawing")	-0.02	t	0.1	0.1)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.1	-0.1	minimum	nil	0.1	0.1)
    )
  )

  (poly_met1 
    (("poly" "drawing")	0.33	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	0.00	t	0.0	0.0)
     (("npc" "drawing")	-0.02	t	0.02	0.02)
     (("met1" "drawing")	0.02	t	0.0	0.0)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.1	-0.1	minimum	nil	0.1	0.1)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (li_met1 
    (("met1" "drawing")	0.23	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
    )
    ((("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (li_met2 
    (("met2" "drawing")	0.26	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	nil	t	0.0	0.0)
    )
    ((("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
     (("via1" "drawing")	0.15	0.15	t	0.0	center	0.17	-0.085	-0.085	minimum	nil	0.085	0.085)
    )
  )

  (met1_met2 
    (("met2" "drawing")	0.26	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("met1" "drawing")	nil	t	0.0	0.0)
    )
    ((("via1" "drawing")	0.15	0.15	t	0.0	center	0.17	-0.085	-0.085	minimum	nil	0.085	0.085)
    )
  )
  (met2_met3 
    (("met2" "drawing")	0.28	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("met3" "drawing")	-0.025	t	0.0	0.0)
    )
    ((("via2" "drawing")	0.2	0.2	t	0.0	center	0.2	-0.085	-0.065	minimum	nil	0.085	0.065)
    )
  )

  (pdiff_li 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("psdm" "drawing")	-0.125	t	0.125	0.125)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (pdiff_met1 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("psdm" "drawing")	-0.125	t	0.125	0.125)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (ndiff_li 
    (("diff" "drawing")	0.25	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (nw_li 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (nw_li_v5 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
     (("v5" "drawing")          -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (nw_li_v12 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("v12" "drawing")         -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (nw_li_v20 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("v20" "drawing")         -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
    )
  )

  (ndiff_met1 
    (("diff" "drawing")	0.25	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (nw_met1 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (nw_met1_v5 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("v5" "drawing")          -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (nw_met1_v12 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("v12" "drawing")         -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

  (nw_met1_v20 
    (("diff" "drawing")	0.17	t	truncate	0.0	0.0	center	0.0)
    nil
    ((("li" "drawing")	nil	t	0.0	0.0)
     (("met1" "drawing")	-0.06	t	0.0	0.0)
     (("nsdm" "drawing")	-0.125	t	0.125	0.125)
     (("nwell" "drawing")       -0.335   t       0.335    0.335)
     (("v20" "drawing")         -0.335   t       0.335    0.335)
     (("thkox" "drawing")       -0.335   t       0.335    0.335)
    )
    ((("licon" "drawing")	0.17	0.17	t	0.0	center	0.17	-0.12	-0.12	minimum	nil	0.12	0.12)
     (("mcon" "drawing")	0.17	0.17	t	0.0	center	0.19	-0.06	-0.06	minimum	nil	0.06	0.06)
    )
  )

)  ;multipartPathTemplates

) ;devices



;********************************
; LE RULES
;********************************
leRules(

 leLswLayers(
 ;( layer               purpose         )
 ;( -----               -------         )
 ) ;leLswLayers

) ;leRules


;********************************
; SITEDEFS
;********************************
siteDefs(

 scalarSiteDefs(
 ;( siteDefName          type width  height  symInX symInY symInR90)
 ;( -----------          ---- -----  ------  ------ ------ -------)
 ) ;scalarSiteDefs

 arraySiteDefs(
 ; ( name	type
 ;  ((siteDefName     dx      dy      orientation) ...)
 ;   [symX] [symY] [symR90] )

 ) ;arraySiteDefs

) ;siteDefs


;********************************
; VIASPECS
;********************************

viaSpecs(
 ;(layer1  layer2  (viaDefName ...) 
 ;   [(        
 ;	(layer1MinWidth layer1MaxWidth layer2MinWidth layer2MaxWidth 
 ;            (viaDefName ...)) 
 ;	...         
 ;   )])       
 ;( ------------------------------------------------------------------------ ) 
) ;viaSpecs
