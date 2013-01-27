
PassPort
by Jeremy Hardin

Version 1.1.3
Build 0001

---------------------------------------------------------

Made opensource 30 Dec 2010
https://sourceforge.net/projects/lw-passport/

---------------------------------------------------------

LightWave 9.6 fix and UI update - Matt Gorner (28 June 2010)

LightWave 10 fix and UI update - Matt Gorner (27 December 2010)

Installing: Just drag the entire 'PassPort' folder into your Plugins folder.


--

Installing Un-Compiled Version (for development):
Download the files in the folder called 'PassPort' (found here) :
http://lw-passport.svn.sourceforge.net/viewvc/lw-passport/

Create a folder called PassPort in your Plugins folder and put all of the source files in there. Then change the paths (below) in 'PassPort_MC.ls': 

@insert "PATH_TO_YOUR_INSTALL/PassPort/passEditor_Interface_Subfuncs.ls"
@insert "PATH_TO_YOUR_INSTALL/PassPort/passEditor_render_Subfuncs.ls"
@insert "PATH_TO_YOUR_INSTALL/PassPort/passEditor_sceneGen_Subfuncs.ls"
@insert "PATH_TO_YOUR_INSTALL/PassPort/passEditor_sceneParse_Subfuncs.ls"

to the location where you placed PassPort on your hard drive.

---------------------------------------------------------

You will also need to recreate your LWEXT*.cfg / Extension Cache (LW10+ only) files. To do this, delete both from your Config folder and run LightWave. If running v10+ it is adisable to manually scan your plugins also from the 'Edit Plugins' panel.