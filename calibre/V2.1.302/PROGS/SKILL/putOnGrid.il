;-------------------------putOnGrid.il-----------------

/*
Function Name: CCSputOnGrid Title : Snap vertices of selected objects to specified grid

Description: Procedure to round the vertices of rectangles, polygons, lines, and paths to the grid specified
by the user. Label origins will also be moved onto grid. The routine will not handle ellipses or donuts.

To run the routine, edit the cell that contains the shapes to be put on grid, select all the shapes to be
modified to grid, and run CCSputOnGrid(). This command is not undoable.

The rounding of numbers is not consistently handled leading to the distortion of some geometries. The
workaround is to add a compensation factor (compFactor) to each geometry path point before rounding .
*/

/************************************************************************
* DISCLAIMER: The following code is provided for Cadence customers       *
* to use at their own risk. The code may require modification to         *
* satisfy the requirements of any user. The code and any modifications   *
* to the code may not be compatible with current or future versions of   *
* Cadence products. THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, *
* INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED         *
* WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.         *
**********************************************************************/

procedure(putOnGrid()
   let((putOnGridForm)
hiCreateForm('putOnGridForm "Put On Grid Form"
            "putOnGridCB(putOnGridForm->gridField->value)"
            list(hiCreateStringField( ?name 'gridField
                                    ?prompt "Enter Grid Value"
                                    ?value "0.25"
;;                                    ?defValue "0.1"
                                    )
        ) ;list
        ""
        ) ;hiCreateForm
hiDisplayForm(putOnGridForm)
   ) ;let
) ;procedure putOnGrid

procedure(putOnGridCB(grid)
    prog( (compFactor cv path error_cmd units rep xgrid ygrid grids newpath)

 if(!(rep = geGetEditRep()) then
     hiDisplayModelessDBox('formHandle "Put On Grid"
      "A cellView must be opened."
      "" "")
     return()
) ; if !rep

 if( geGetSelSet() == nil then
     hiDisplayModelessDBox('formHandle "Put On Grid"
      "Nothing has been selected \n
       Program works on only selected objects"
      "" "")
     return()
) ; if geGetSelSet

 compFactor = 1 / rep~>DBUPerUU
units = rep~>userUnits
if(!compFactor  then
     hiDisplayModelessDBox('formHandle "Put On Grid"
             "The CellView does not have the DBUPerUU property defined"
             "" "")
     return()
) ; if !compFactor

 grids = parseString(grid)
xgrid = evalstring(nth(0 grids))
if(! numberp(xgrid) then
     printf("Grid must be a number.\n")
     return()
) ; if !numberp

 if(! (ygrid = nth(1 grids)) then
     ygrid = xgrid
else
     ygrid = evalstring(ygrid)
     if(! numberp(ygrid) then
         printf("Grid must be a number.\n")
         ygrid = xgrid
     ) ;if !numberp
) ;if !ygrid

 printf("Snapping x-coordinates to nearest %f %s.\n" float(xgrid) units)
printf("Snapping y-coordinates to nearest %f %s.\n" float(ygrid) units)

 cv = geGetEditRep()

 foreach( obj geGetSelSet()
     case( obj~>objType
      (("rect" "dot")
          path = obj~>bBox
          path = list( lowerLeft(path)
       list(xCoord(upperRight(path)) yCoord(lowerLeft(path)))
       upperRight(path)
       list(xCoord(lowerLeft(path)) yCoord(upperRight(path))))
      ) ;rect

      (("polygon" "path" "line")
          path = obj~>path
      ) ; polygon, path, line

      ("label"
          path = list(roundCoord(obj~>xy xgrid ygrid compFactor))
      ) ; if label

      (("inst" "mosaic")
          path = list(roundCoord(obj~>xy xgrid ygrid compFactor))
      ) ; if inst
      (t
          sprintf(error_cmd "Cannot handle \"%s\" object types."
           obj~>objType)
                     hiDisplayModelessDBox('formHandle "Put On Grid" error_cmd "" "")
                     return()
      ) ; default

     ) ;case

     newpath=nil
     foreach( pt path
  newpath=cons(roundCoord(pt xgrid ygrid compFactor) newpath)
     )
     path=newpath
     case( obj~>objType
  (("rect" "polygon" "dot")
     geSelectObject(dbCreatePolygon(cv obj~>lpp path))
     dbDeleteObject(obj)
  )
  ("line"
    geSelectObject(dbCreateLine(cv obj~>lpp path))
    dbDeleteObject(obj)
  )
  ("path"
    geSelectObject(dbCreatePath(cv obj~>lpp path obj~>width))
    dbDeleteObject(obj)
  )
  ("label"
    geSelectObject(dbCreateLabel(cv car(obj~>lpp) car(path)
    obj~>theLabel obj~>justify obj~>orient
    obj~>font obj~>height
     )
    )
    dbDeleteObject(obj)
  )
  ("inst"
    obj~>xy = car(path)
  )
  (t
    error("Put On Grid: Encountered unknown shape")
    return()
  )
     )
)
    )
)

procedure( roundCoord( point xgrid ygrid compFactor )
    prog( (x y)
x=round((xCoord(point) + compFactor) / xgrid) * xgrid
y=round((yCoord(point) + compFactor) / ygrid) * ygrid
return(list( x y ))
    ) ;prog
) ;procedure

