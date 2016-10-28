			resizeDrawing("2000px", "2000px");

			//importSheet();
			cg();
			lt(90);
			for (var currentStation=1;currentStation<=662;currentStation++)
			{
				var thisStation = localStorage["A"+currentStation];
				
				if (isNumeric(thisStation))
				{
					fd(thisStation);
				} else {
					if (contains(thisStation, ';'))
					{
						eval(thisStation);
					} else {
						label(thisStation);
					circle();
					} // end if this cell is a JS command
				} // end if this cell is a number
			} // end for every row
			
			drawing.setZoom(2);
			drawing.panTo(new L.LatLng(-200, 50));

			ht();
