;; this will load all the pad pcell files to create the symbols, layout, and cdf

let( (fileLocation filePath)

  fileLocation = simplifyFilename(which(get_filename(piport)))
  filePath = strcat( "/" buildString(reverse(cdr(reverse(parseString(fileLocation
    "/")))) "/") )
  ;printf("skillFile location: %s\n" filePath )

  ; create symbols
  loadi(strcat(filePath "/SYMBOLS/S130padPcell.SYM.il"))
  ; create layout
  loadi(strcat(filePath "/LAYOUTS/S130padPcell.LAY.il"))
  ; create CDFs
  loadi(strcat(filePath "/CDFS/S130padPcell.CDF.il"))

); let

