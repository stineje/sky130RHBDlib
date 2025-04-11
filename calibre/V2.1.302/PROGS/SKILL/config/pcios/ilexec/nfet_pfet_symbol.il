;; To use label, call it in the pcell like:
;;S130GenMOSLabel(cv 0.275:-0.1375 mult m w l)


procedure( S130TruncateZeros(val)
  let( ()
    ;; val = float
    ;; returns string with trailing zeros truncated down to 0.001
    ;; beyond 0.001, full precision returned

    ;; if an integer
    if( abs(val - floor(val)) < 1e-6 then
      sprintf(nil "%.0f" val)
    else
    if( abs(val - floor(val/0.1)*0.1) < 1e-6 then
      sprintf(nil "%.1f" val)
    else
    if( abs(val - floor(val/0.01)*0.01) < 1e-6 then
      sprintf(nil "%.2f" val)
    else
    if( abs(val - floor(val/0.001)*0.001) < 1e-6 then
      sprintf(nil "%.3f" val)
    else
      sprintf(nil "%f" val)
    ); if
    ); if
    ); if
    ); if
  ); let
); procedure

procedure( S130CondLabelMult(mult)
  let( ()
    if( mult == 1 then
      ;; print nothing
      ""
    else
      when( mult > 1
        sprintf(nil "%d" mult)
      ); when
    ); if
  ); let
); procedure

procedure( S130CondLabelX(mult)
  let( ()
    if( mult == 1 then
      ;; print nothing
      ""
    else
      when( mult > 1
        "x"
      ); when
    ); if
  ); let
); procedure

procedure( S130GetLabelW(label)
  let( ()
    rightEdge(label~>bBox) - leftEdge(label~>bBox)
  ); let
); procedure

procedure( S130GenMOSLabel(cv location mult m w l)
  let( (xOS xStart yStart multLabel bracketLLabel fingLabel fingMultLabel widthLabel divBar lengthLabel bracketRLabel
       widthW lengthW divW labelGroup)

    xStart = xCoord(location)
    yStart =  yCoord(location)
    xOS = 0.0

    ;;labelGroup = dbCreateGroup(cv "mosLabel" list("set" "ordered" "uniqueName" "deleteFirst") "unrestricted")
    ;;labelGroup = dbCreateFigGroup(cv "mosLabel" t -2:1 "R0")

    multLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   xStart:yStart
                                   S130CondLabelMult(mult) "lowerLeft" "R0"
                                   "stick" 0.03125)

    ;;multLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup multLabel)
    ;;dbAddFigToFigGroup(labelGroup multLabel)
    xOS = xOS + S130GetLabelW(multLabel)

    xLabel = dbCreateLabel(cv list("annotate" "drawing")
                                xStart+xOS:yStart
                                S130CondLabelX(mult) "lowerLeft" "R0"
                                "stick" 0.03125)

    xOS = xOS + S130GetLabelW(xLabel) - 0.005

    bracketLLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.34375:-0.0625
                                   xStart+xOS:yStart-0.0328125
                                   "[" "lowerLeft"
                                   "R0" "euroStyle" 0.09375)
    bracketLLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup bracketLLabel)
    ;;dbAddFigToFigGroup(labelGroup bracketLLabel)
    xOS = xOS + S130GetLabelW(bracketLLabel) - 0.03

    fingLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.39375:-0.0375
                                   xStart+xOS:yStart
                                   sprintf(nil "%d" m) "lowerLeft" "R0"
                                   "stick" 0.03125)
    ;;fingLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup fingLabel)
    ;;dbAddFigToFigGroup(labelGroup fingLabel)
    xOS = xOS + S130GetLabelW(fingLabel) - 0.005

    fingMultLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.41875:-0.025
                                   xStart+xOS:yStart+0.0125
                                   "." "lowerLeft" "R0"
                                   "stick" 0.0625)
    ;;fingMultLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup fingMultLabel)
    ;;dbAddFigToFigGroup(labelGroup fingMultLabel)
    xOS = xOS + S130GetLabelW(fingMultLabel) - 0.005

    widthLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.49375:0.0
                                   xStart+xOS:yStart+0.025
                                   S130TruncateZeros(w) "lowerLeft" "R0"
                                   "stick" 0.03125)
    ;;widthLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup widthLabel)
    ;;dbAddFigToFigGroup(labelGroup widthLabel)
    widthW = S130GetLabelW(widthLabel)

    lengthLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.49375:-0.0625
                                   xStart+xOS:yStart-0.03
                                   S130TruncateZeros(l) "lowerLeft" "R0"
                                   "stick" 0.03125)
    ;;lengthLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup lengthLabel)
    ;;dbAddFigToFigGroup(labelGroup lengthLabel)
    lengthW = S130GetLabelW(lengthLabel)

    ;; center the shorter label
    if( widthW > lengthW then
      dbMoveShape(lengthLabel cv list((widthW-lengthW)/2.0:0.0 "R0"))
    else
      dbMoveShape(widthLabel cv list((lengthW-widthW)/2.0:0.0 "R0"))
    ); if

    divBar = dbCreateLine(cv list("annotate" "drawing")
                          list(xStart+xOS:yStart+0.015 xStart+xOS+max(lengthW widthW):yStart+0.015))
    ;;dbAddObjectToGroup(labelGroup divBar)
    ;;dbAddFigToFigGroup(labelGroup divBar)
    divW = S130GetLabelW(divBar)

    xOS = xOS + max(lengthW widthW divW) - 0.02

    bracketRLabel = dbCreateLabel(cv list("annotate" "drawing")
                                   ;;0.58125:-0.0625
                                   xStart+xOS:yStart-0.0328125
                                   "]" "lowerLeft"
                                   "R0" "euroStyle" 0.09375)
    bracketRLabel~>isDrafted = nil
    ;;dbAddObjectToGroup(labelGroup bracketRLabel)
    ;;dbAddFigToFigGroup(labelGroup bracketRLabel)
  ); let
); procedure
