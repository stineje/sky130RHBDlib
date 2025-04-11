;; this will load all the mos pcell files to create the symbols, layout, and cdf

let( (fileLocation filePath)

  fileLocation = simplifyFilename(which(get_filename(piport)))
  filePath = strcat( "/" buildString(reverse(cdr(reverse(parseString(fileLocation
    "/")))) "/") )
  ;printf("skillFile location: %s\n" filePath )

  ; create symbols
  loadi(strcat(filePath "/SYMBOLS/S130mosPcell.SYM.il"))
  ; create layout
  loadi(strcat(filePath "/LAYOUTS/S130mosPcell.LAY.il"))
  ; create CDFs
  loadi(strcat(filePath "/CDFS/S130mosPcell.CDF.il"))

); let

