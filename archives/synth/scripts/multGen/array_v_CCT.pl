eval 'exec /usr/bin/perl $0 ${1+"${@}"}'
    if 0;
  
# Perl script to generate truncated array multiplier (Constant Correction)
# Last update: 08/23/02
   
use Getopt::Std;
    
# options are
#       -x <bits> the number of x bits
#       -y <bits> the number of y bits
#       -z <bits> the number of output bits
#       -k <int> number of columns to keep
#       -m <string> module name
     
getopts('x:y:z:k:m:');

$XBITS=$opt_x;
$YBITS=$opt_y;
$ZBITS=$opt_z;
$K=$opt_k;
$MODULE=$opt_m;

if($XBITS<=0 || $YBITS<=0 || $ZBITS<=0 || $K<0){
    print("Input parameters:\n");
    print("    -x <bits> the number of x bits\n");
    print("    -y <bits> the number of y bits\n");
    print("    -z <bits> the number of output bits\n");
    print("    -k <int> number of columns to keep\n");
    print("    -m <string> module name (optional)\n");
    exit(1);
}

if($ZBITS+$K>$XBITS+$YBITS) {    
    print("Error: z+k must be smaller than or equal to x+y\n\n");
    exit(1);
}

$pp_label=1;
$ha_label=1;
$fa_label=1;
$cpa_label=1;
       
$instcnt=1;

# Calculation of the correction constant
# --------------------------------------
$err_red = 0;
for($q = $ZBITS+$K+1; $q <= $XBITS+$YBITS; $q++) {
    $err_red += ($XBITS+$YBITS+1-$q)/&pow2($q);  # reduction error
#    printf("%s  %s  %s  %s\n",$q,&pow2($q),$err_red,$XBITS+$YBITS+1-$q);
}
$err_rnd = 1/pow2($ZBITS)*(1 - 1/&pow2($K));  # rounding error
$err_tot = 0.25*$err_red + 0.5*$err_rnd;
printf("\n// Correction constant value: %s (",$err_tot);

# Rounding of that constant
$err_tot_rnd = $err_tot * &pow2($ZBITS+$K);
$err_tot_rnd = &round_near($err_tot_rnd);
$err_tot_rnd = $err_tot_rnd / &pow2($ZBITS+$K);

# Conversion into binary format
@carray;
$rem = $err_tot_rnd;
for($j=1;$j<=$ZBITS+$K;$j++){
    $mod = $rem *  &pow2($j);
    if($mod>=1){
        $rem = $rem - 1/&pow2($j);
        @carray[$XBITS+$YBITS-$j] = 1;
    }
    else{
        @carray[$XBITS+$YBITS-$j] = 0;
    }
}

# Display the value of the constant correction
for($j=$XBITS+$YBITS-1;$j>=$XBITS+$YBITS-$ZBITS-$K;$j--){
    printf("%s",@carray[$j]);
}
printf(")\n\n");

# Calculation of the number of bits required for the constant correction
# ----------------------------------------------------------------------
$nbitscon=0;
for($j=$XBITS+$YBITS-$ZBITS-$K;$j<$XBITS+$YBITS;$j++){
    $nbitscon += @carray[$j]*&pow2($j-($XBITS+$YBITS-$ZBITS-$K));
}

# calculation of which partial products have to be generated
# ----------------------------------------------------------
if($XBITS<$ZBITS+$K){
    $x_pp_size=$XBITS;
    $h_pp_size=$K+$ZBITS-$XBITS;
}
else{
    $x_pp_size=$ZBITS+$K;
    $h_pp_size=0;
}
if($YBITS<=$ZBITS+$K){
    $y_pp_size=$YBITS;
}
else{
    $y_pp_size=$ZBITS+$K-1;
}

# Calculation of the number of bits available for correction
# (number of HA located on the diagonal and on the second line)
# -------------------------------------------------------------
$nha=0;
$nhadiag=0;
for($y=$YBITS-$y_pp_size; $y < $YBITS ; $y++) {
    for($x=$XBITS-2; $x >= $XBITS-$x_pp_size; $x--) {
        if($x+$y>=$XBITS+$YBITS-$ZBITS-$K){
            if($y==$YBITS-$y_pp_size+1){
                $nha++;
            }
        }
        if($x+$y==$XBITS+$YBITS-$ZBITS-$K && $y>$YBITS-$y_pp_size+1){
            $nhadiag++;
        }
    }
}

# Check if the constant correction can be done
# --------------------------------------------
$sum_max=$nhadiag;
for($i=0;$i<$nha;$i++){
    $sum_max += &pow2($i);   
}
$sum_req=$nbitscon;
if($sum_req>$sum_max || ($XBITS+$YBITS==$ZBITS+$K && @carray[$XBITS+$YBITS-$ZBITS-$K]==1)){
    $optimize=0;
}
else{
    $optimize=1;
}

# Write the header of the verilog file (variables definition)
# -----------------------------------------------------------
if(length($MODULE)==0){
    printf("module CCTarray%s_%s_%s_%s (Z2, X, Y);\n", $XBITS, $YBITS, $ZBITS, $K);
}
else{
    printf("module $MODULE (Z2, X, Y);\n", $XBITS, $YBITS, $ZBITS, $K);
}
printf("\t\n");
printf("\tinput [%s:0] Y;\n",$YBITS-1);
printf("\tinput [%s:0] X;\n",$XBITS-1);
printf("\toutput [%s:0] Z2;\n",$ZBITS-1);
printf("\n\n");
for($y=0; $y < $YBITS ; $y++) {
    printf("\twire [%s:0] P%s;\n", $XBITS-1, $y);
    printf("\twire [%s:0] carry%s;\n", $XBITS-1, $y+1);
    printf("\twire [%s:0] sum%s;\n", $XBITS-1, $y+1);
}
printf("\twire [%s:0] carry%s;\n",$ZBITS+$K-2,$YBITS+1);
printf("\twire [%s:0] Z;\n",$ZBITS+$K-1);
print "\n\n";

# Generate the partial products
# -----------------------------
print "\t// generate the partial products.\n";
for($y=$YBITS-$y_pp_size; $y < $YBITS ; $y++) {
    for($x=$XBITS-1; $x >= $XBITS-$x_pp_size; $x--) {
        if($x+$y>=$XBITS+$YBITS-$ZBITS-$K){
	    if($y>$YBITS-$y_pp_size && $x==$XBITS-1) {
	        printf ("\tand pp%s(sum%s[%s], X[%s], Y[%s]);\n", $pp_label, $y, $x, $x, $y);
	        $pp_label++;
	    }
	    else {
	        printf ("\tand pp%s(P%s[%s], X[%s], Y[%s]);\n", $pp_label, $y, $x, $x, $y);
	        $pp_label++;
	    }
	}
    }
}
print "\n";

# $optimize=0;
if($optimize==0 || $XBITS+$YBITS==$ZBITS){
    goto NO_OPTIMIZE;
}

# Array Reduction
# ---------------
$nbitsvarused=0;
$nbitsconused=0;
print "\t// Array Reduction\n";
for($y=$YBITS-$y_pp_size; $y < $YBITS ; $y++) {
    for($x=$XBITS-2; $x >= $XBITS-$x_pp_size; $x--) {
        if($x+$y>=$XBITS+$YBITS-$ZBITS-$K){
            if($y==$YBITS-$y_pp_size+1){
                if($nbitsconused+&pow2($x-($XBITS+$YBITS-$ZBITS-$K-$y))<=$nbitscon){
                    if($K>=2 && $x==0){
                        printf("\tassign carry%s[%s] = P%s[%s] & P%s[%s];\n",$y,$x,$y,$x,$y-1,$x+1);
                        $nbitsconused++;
                    }
                    else{
                        printf("\tspecialized_half_adder  SHA%s(carry%s[%s],sum%s[%s],P%s[%s],P%s[%s]);\n",$sha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
                        $sha_label++;
                        $nbitsconused += &pow2($x-($XBITS+$YBITS-$ZBITS-$K-$y));
                    }
                }
                else{
                    if($K>=2 && $x==0){
                        printf("\tassign carry%s[%s] = P%s[%s] | P%s[%s];\n",$y,$x,$y,$x,$y-1,$x+1);
                    }
                    else{
                        printf("\thalf_adder  HA%s(carry%s[%s],sum%s[%s],P%s[%s],P%s[%s]);\n",$ha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
                        $ha_label++;
                    }
                }
            }
            if($y>$YBITS-$y_pp_size+1){
                if($x+$y==$XBITS+$YBITS-$ZBITS-$K){
                    if($nbitsconused<$nbitscon){
                        if($x==0 && $y<$YBITS-$h_pp_size+$K){
                            printf("\tassign carry%s[%s] = P%s[%s] | sum%s[%s];\n",$y,$x,$y,$x,$y-1,$x+1);
                            $nbitsconused++;
                        }
                        else{
                            printf("\tspecialized_half_adder  SHA%s(carry%s[%s],sum%s[%s],P%s[%s],sum%s[%s]);\n",$sha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
                            $sha_label++;
                            $nbitsconused++;
                        }
                    }
                    else{
                        if($x==0 && $y<$YBITS-$h_pp_size+$K){
                            printf("\tassign carry%s[%s] = P%s[%s] & sum%s[%s];\n",$y,$x,$y,$x,$y-1,$x+1);
                        }
                        else{
                            printf("\thalf_adder  HA%s(carry%s[%s],sum%s[%s],P%s[%s],sum%s[%s]);\n",$ha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
                            $ha_label++;
                        }
                    }
                }       
                else{
                    if($x==0 && $y<$YBITS-$h_pp_size+$K){
                        printf("\treduced_full_adder  RFA%s(carry%s[%s],P%s[%s],sum%s[%s],carry%s[%s]);\n",$rfa_label,$y,$x,$y,$x,$y-1,$x+1,$y-1,$x);
                        $rfa_label++;
                    }
                    else{
                        printf("\tfull_adder  FA%s(carry%s[%s],sum%s[%s],P%s[%s],sum%s[%s],carry%s[%s]);\n",$fa_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1,$y-1,$x);
                        $fa_label++;
                    }
                }
            }
        }
    }
}
print "\n";
# Generate lower order product
print "\t// Generate lower product bits YBITS \n";
$Zpin=0;
if($ZBITS>$XBITS){
    for($y=$YBITS+$XBITS-$ZBITS; $y < $YBITS ; $y++){
        if($y==0){
            printf("\tbuf b1(Z2[0], P0[0]);\n");
            $Zpin++;
        }
        else{
            printf ("\tassign Z2[%s] = sum%s[0];\n",$Zpin,$y);
            $Zpin++;
        }
    }
}
print "\n";
# Generate higher order product
print "\t// Final Carry Propagate Addition\n";
print "\t//   Generate higher product bits\n";
if($ZBITS>$XBITS){
    $nhop=$XBITS;
}
else{
    $nhop=$ZBITS;
}
if($ZBITS+$K>$XBITS){
    $xstart=0;
}
else{
    $xstart=$XBITS-$ZBITS-$K;;
}
for($x=$xstart; $x < $XBITS ; $x++) {
    if($x==$xstart) {
        if($x==$XBITS-$nhop){
            if($ZBITS+$K>$XBITS){
                printf("\thalf_adder CPA%s(carry%s[%s],Z2[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS-1,$x+1);
                $cpa_label++;
            }
            else{
                printf("\tassign carry%s[%s] = 0;\n",$YBITS,$x);
                printf("\tassign Z2[%s] = sum%s[%s];\n",$Zpin,$YBITS-1,$x+1);
            }
            $Zpin++;
        }
        else{
            if($ZBITS+$K>$XBITS){
                printf("\tassign carry%s[%s] = carry%s[%s] & sum%s[%s];\n",$YBITS,$x,$YBITS-1,$x,$YBITS-1,$x+1);
            }
            else{
                printf("\tassign carry%s[%s] = 0;\n",$YBITS,$x);
            }
        }                 
    }
    else{
        if($x==$XBITS-2) {
            printf("\tfull_adder CPA%s(Z2[%s],Z2[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$Zpin+1,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
        }
        else{
            if($x>=$XBITS-$nhop && $x<$XBITS-2) {
                printf("\tfull_adder CPA%s(carry%s[%s],Z2[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
                $cpa_label++;
                $Zpin++;
            }
            if($x<$XBITS-$nhop && $x>$xstart && $x<$XBITS-2){
                printf("\treduced_full_adder CPA%s(carry%s[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
                $cpa_label++;      
            } 
        }
    }
}
goto END;

NO_OPTIMIZE: printf("// FAILED TO OPTIMIZE THE CORRECTION!\n");
# Array Reduction
# ---------------
print "\t// Array Reduction\n";
for($y=$YBITS-$y_pp_size; $y < $YBITS ; $y++) {
    for($x=$XBITS-2; $x >= $XBITS-$x_pp_size; $x--) {
        if($x+$y>=$XBITS+$YBITS-$ZBITS-$K){
            if($y==$YBITS-$y_pp_size+1){
	        printf("\thalf_adder  HA%s(carry%s[%s],sum%s[%s],P%s[%s],P%s[%s]);\n",$ha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
	        $ha_label++;
	    }
	    if($y>$YBITS-$y_pp_size+1){
                if($x+$y==$XBITS+$YBITS-$ZBITS-$K){
	            printf("\thalf_adder  HA%s(carry%s[%s],sum%s[%s],P%s[%s],sum%s[%s]);\n",$ha_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1);
	            $ha_label++;
		}	    
	        else{
	            printf("\tfull_adder  FA%s(carry%s[%s],sum%s[%s],P%s[%s],sum%s[%s],carry%s[%s]);\n",$fa_label,$y,$x,$y,$x,$y,$x,$y-1,$x+1,$y-1,$x);
	            $fa_label++;
	        }
	    }
	}
    }
}


print "\n";
if($XBITS+$YBITS>$ZBITS){
    # Generate lower order product
    print "\t// Generate lower product bits YBITS \n";
    $Zpin=0;
    if($ZBITS+$K>$XBITS){
        for($y=$YBITS-$ZBITS-$K+$XBITS; $y < $YBITS ; $y++){
            if($y==0){
                printf("\tbuf b1(Z[0], P0[0]);\n");
                $Zpin++;
	    }
            else{
                printf ("\tassign Z[%s] = sum%s[0];\n",$Zpin,$y);
                $Zpin++;
            }
        }
    }
    print "\n";
    # Generate higher order product
    print "\t// Final Carry Propagate Addition\n";
    print "\t//   Generate higher product bits\n";
    if($ZBITS+$K>$XBITS){
        $nhop=$XBITS;
    }
    else{
        $nhop=$ZBITS+$K;
    }
    for($x=$XBITS-$nhop; $x < $XBITS ; $x++) {
        if($x==$XBITS-$nhop) {
            if($ZBITS+$K>$XBITS){
	        printf("\thalf_adder CPA%s(carry%s[%s],Z[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS-1,$x+1);
            }
	    else{
	        printf("\tassign carry%s[%s] = 0;\n",$YBITS,$x);
                printf("\tassign Z[%s] = sum%s[%s];\n",$Zpin,$YBITS-1,$x+1);
	    }
            $cpa_label++;
            $Zpin++;
        }
        if($x==$XBITS-2) {
	    printf("\tfull_adder CPA%s(Z[%s],Z[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$Zpin+1,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
            $cpa_label++;
            $Zpin++;
        }			
        if($x>$XBITS-$nhop && $x<$XBITS-2) {
            printf("\tfull_adder CPA%s(carry%s[%s],Z[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
            $cpa_label++;
            $Zpin++;	
        }
    }


    print "\n";
    # Add the constant to the sum previously calculated
    print "\t// Add the constant\n";
    for($x=0;$x<$ZBITS+$K;$x++){
        if($x==0) {
            if(@carray[$XBITS+$YBITS-$ZBITS-$K+$x]==0){
                if($K==0){
                    printf("\tassign Z2[%s] = Z[%s];\n",$x,$x);
                }
                printf("\tassign carry%s[%s] = 0;\n",$YBITS+1,$x);
	    }
            else{
                if($K==0){
                    printf("\tassign Z2[%s] = !Z[%s];\n",$x,$x);
                }
                printf("\tassign carry%s[%s] = Z[%s];\n",$YBITS+1,$x,$x);
            }
        }
        if($x==$ZBITS+$K-1) {
            if(@carray[$XBITS+$YBITS-$ZBITS-$K+$x]==0){
                printf("\tassign Z2[%s] = Z[%s] ^ carry%s[%s];\n",$x-$K,$x,$YBITS+1,$x-1);
            }
	    else{
                printf("\tassign Z2[%s] = !Z[%s] ^ carry%s[%s];\n",$x-$K,$x,$YBITS+1,$x-1);    
            }
	    $cpa_label++;
        }			
        if($x>0 && $x<$ZBITS+$K-1) {
            if($x>=$K){
                if(@carray[$XBITS+$YBITS-$ZBITS-$K+$x]==0){
                    printf("\thalf_adder CPA%s(carry%s[%s],Z2[%s],Z[%s],carry%s[%s]);\n",$cpa_label,$YBITS+1,$x,$x-$K,$x,$YBITS+1,$x-1);
                }
	        else{
                    printf("\tspecialized_half_adder CPA%s(carry%s[%s],Z2[%s],Z[%s],carry%s[%s]);\n",$cpa_label,$YBITS+1,$x,$x-$K,$x,$YBITS+1,$x-1);            
                }
            }
	    else{
	        if(@carray[$XBITS+$YBITS-$ZBITS-$K+$x]==0){
                    printf("\tand CPA%s(carry%s[%s],Z[%s],carry%s[%s]);\n",$cpa_label,$YBITS+1,$x,$x,$YBITS+1,$x-1);
                }
                else{
                    printf("\tor CPA%s(carry%s[%s],Z[%s],carry%s[%s]);\n",$cpa_label,$YBITS+1,$x,$x,$YBITS+1,$x-1);
                }
            }
	    $cpa_label++;
        }
    }
}
else{   # if $XBITS+$YBITS=$ZBITS
    # Generate lower order product
    print "\t// Generate lower product bits YBITS \n";
    $Zpin=0;
    if($ZBITS>$XBITS){
        for($y=$YBITS-$ZBITS+$XBITS; $y < $YBITS ; $y++){
            if($y==0){
                printf("\tbuf b1(Z2[0], P0[0]);\n");
                $Zpin++;
	    }
	    else{
                printf ("\tassign Z2[%s] = sum%s[0];\n",$Zpin,$y);
                $Zpin++;
	    }
        }
    }
    print "\n";
    # Generate higher order product
    print "\t// Final Carry Propagate Addition\n";
    print "\t//   Generate higher product bits\n";
    if($ZBITS>$XBITS){
        $nhop=$XBITS;
    }
    else{
        $nhop=$ZBITS;
    }
    if($XBITS-$ZBITS-$K>0){
        $xstart=$XBITS-$ZBITS-$K;
    }
    else{
        $xstart=0;
    }
    for($x=$xstart; $x < $XBITS ; $x++) {
        if($x==$xstart) {
            if($x==$XBITS-$nhop){
                printf("\thalf_adder CPA%s(carry%s[%s],Z2[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS-1,$x+1);
	        $cpa_label++;
                $Zpin++;
            }
            else{
                printf("\tassign carry%s[%s] = carry%s[%s] & sum%s[%s];\n",$YBITS,$x,$YBITS-1,$x,$YBITS-1,$x+1);
            }
        }
        else{
            if($x==$XBITS-2) {
                printf("\tfull_adder CPA%s(Z2[%s],Z2[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$Zpin+1,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
                $cpa_label++;
                $Zpin++;
            }
            else{		
                if($x>=$XBITS-$nhop && $x<$XBITS-2) {
                    printf("\tfull_adder CPA%s(carry%s[%s],Z2[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$Zpin,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
                    $cpa_label++;
                    $Zpin++;
                }
                if($x<$XBITS-$nhop && $x>$xstart && $x<$XBITS-2){
                    printf("\treduced_full_adder CPA%s(carry%s[%s],carry%s[%s],carry%s[%s],sum%s[%s]);\n",$cpa_label,$YBITS,$x,$YBITS-1,$x,$YBITS,$x-1,$YBITS-1,$x+1);
	            $cpa_label++;      
                }
            }
        }
    }
}

END: print "endmodule";

sub pow2 {
    ($p) = @_;
    $res = 1;
    for($i=1;$i<=$p;$i++){
        $res = $res * 2;
    }
    return($res);
}

sub round_near {
    ($num) = @_;
    $rnd = 0;
    while($num>$rnd+0.5){
        $rnd = $rnd + 1;
    }
    return($rnd);
}



