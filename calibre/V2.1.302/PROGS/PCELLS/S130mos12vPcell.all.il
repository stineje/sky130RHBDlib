;; this will load all the mos pcell files to create the symbols, layout, and cdf

let( (fileLocation filePath)

  fileLocation = simplifyFilename(which(get_filename(piport)))
  filePath = strcat( "/" buildString(reverse(cdr(reverse(parseString(fileLocation
    "/")))) "/") )

  ; create symbols
  loadi(strcat(filePath "/SYMBOLS/S130mos12vPcell.SYM.il"))
  ; create layout
  loadi(strcat(filePath "/LAYOUTS/S130mos12vPcell.LAY.il"))
  ; create CDFs
  loadi(strcat(filePath "/CDFS/S130mos12vPcell.CDF.il"))

); let

