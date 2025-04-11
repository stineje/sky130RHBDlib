prog((tech techLibName techFileName)
	techLibName = "S130"
	techFileName = "tech.db"
	tech = techOpenTechFile(techLibName techFileName "r")
	if(tech==nil then
		return(nil)
	)
	;The template name is : 20V_iso

	leDefineMPPTemplate(
		?techId	 tech
		?name	 "20V_iso"
		?layer	 list("diff" "drawing")
		?width	 0.170000
		?choppable	 t
		?endType	 "truncate"
		?beginExt	 0.000000
		?endExt	 0.000000
		?justification	 "center"
		?offset	 0.000000
		?offsetSubPath	 list(
		 list(
			?layer	 list("nwell" "drawing")
			?width	 1.430000
			?choppable	 t
			?sep	 0.300000
			?justification	 "center"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		 list(
			?layer	 list("dnwell" "drawing")
			?width	 3.430000
			?choppable	 t
			?sep	 -0.700000
			?justification	 "center"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		 list(
			?layer	 list("v20" "drawing")
			?width	 4.430000
			?choppable	 t
			?sep	 -1.200000
			?justification	 "center"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		 list(
			?layer	 list("pwbm" "drawing")
			?width	 2.500000
			?choppable	 t
			?sep	 -1.665000
			?justification	 "center"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		 list(
			?layer	 list("v5" "drawing")
			?width	 1.430000
			?choppable	 t
			?sep	 0.300000
			?justification	 "center"
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		)
		?encSubPath	 list(
		list(
			?layer	 list("li1" "drawing")
			?enclosure	 0.000000
			?choppable	 t
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		list(
			?layer	 list("nsdm" "drawing")
			?enclosure	 -0.125000
			?choppable	 t
			?beginOffset	 0.000000
			?endOffset	 0.000000
			)
		)
		?subRect	 list(
		list(
			?layer	 list("licon1" "drawing")
			?width	 0.170000
			?length	 0.170000
			?choppable	 t
			?sep	 0.000000
			?justification	 "center"
			?space	 0.170000
			?beginOffset	 -0.120000
			?endOffset	 -0.120000
			?beginSegOffset	 0.120000
			?endSegOffset	 0.120000
			?gap	 "distribute"
			)
		)
	) ; end of leDefineMPPTemplate procedure
) ; end of prog in ASCII fileTACH met1tt m1
