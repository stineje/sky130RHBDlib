Directions1 = hiCreateLabel(
	?name 'Directions1
	?labelText "<div style='color: #ff0000;'>** The safest way is to instantiate new devices **</div>"
	?justification 'center
	)
Directions2 = hiCreateLabel(
	?name 'Directions2
	?labelText "Select all Schematic Devices that you want converted and hit Apply"
	?justification 'center
	)
Directions3 = hiCreateLabel(
	?name 'Directions3
	?labelText "You need to run Trigger CallBacks on Entire Library after the conversion"
	?justification 'center
	)
Directions4 = hiCreateLabel(
	?name 'Directions4
	?labelText "<div style='color: #ff0000;'>** Triggering CallBacks can alter your currently placed Pcells  **</div>"
	?justification 'center
	)
Dis2Cont = 
hiCreateAppForm(
?name 'discrete2Continuous
?formTitle "Convert Discrete to Continuous"
?fields list(
	list(Directions1 0: 5 350:30)
	list(Directions2 0:35 350:30)
	list(Directions3 0:65 350:30)
	list(Directions4 0:95 350:30)

	)
?callback	"foreach( inst setof(i geGetSelSet() i~> useFixedWL) inst~>useFixedWL=nil)"
?initialSize list(9500 9500)
)
hiDisplayForm( 'discrete2Continuous)
