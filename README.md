This project contains code for converting data from property appraiser's office into .shp files that contains market value and tax value for <b>n</b> number of years

###STEP BY STEP INSTRUCTIONS FOR IMPORTING AN ADDITIONAL YEAR OF DATA
-----------------------------------------------------------------
####DATA PREP
1. Copy the data into ./valuedata/<year>/
2. Open sql folder and for each year of data, create a copy of the following files
	```	
		createtables_XX.sql
		importdata_XX.sql
		createrollup_xx.sql
	```
3. In the files created in the step above, search and `replace _<yearnumber>` with the correct one. 
4. Open filelist.csv and remove all existing lines except header line
5. Add the new text files in the following format
	```	
	fullpath to the current filename, fullpath to the output csv, fileformat (10,35, 40), name of the table the data belongs to
	```
**TIP**: We only care about files 10,35 and 40
6. Open `setup.ps1` and add a line for cerate tables and importdata referencing the sql files that were created in step 2
**TIP**: look for the following runway markers in the scripts for indication on where to add the files
	```
		@@@@@@@@@@@@@@@@
		 ADD A LINE here
		@@@@@@@@@@@@@@@@
	```
7. Open `createrollups.ps1` and add a line for calling the createrollup sql script created in step 2
8. open `./parcelshape` folder and replace the shapefiles with the new ones. name it `parcels.shp`, `parcels.dbf` etc if it isnt named that
9. Delete `parcels.sql`


####RUNNING SCRIPTS 
1. Open powershell window
2. Navigate to the scripts folder 
3. run the following
	```
	./setup.ps1
	```
4. If there is no new shp file to import, skip this step. Else once the above process exits, run the following
	```	
	./shpFileSetup.ps1
	```
5. Once the above process exits, run the following
	./createrollups.ps1


####EXPORTING SHAPE FILES
1. Update the script as required in ExportShp.ps1
2. Run the following
	./exportshp.ps1


####CLEANUP
-------
No you are not done.
open each of the .ps1 files you created and move the new lines inside the '$nuke' context


STEP BY STEP INSTRUCTIONS FOR IMPORTING NEW SHAPE FILE
-----------------------------------------------------------------
1. open ./parcelshape folder and replace the shapefiles with the new ones. name it parcels.shp, parcels.dbf etc if it isnt named that
2. Delete parcels.sql
3. Open powershell window
4. Navigate to this folder  (cd C:\git\propertymap\scripts)
5. run the following
	./shpFileSetup.ps1
6. Once the above process exits, run the following
	./createrollups.ps1 -nuke 1
