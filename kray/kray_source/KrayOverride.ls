
/*

 Kray Override Script
 by Jure Judez
 Modification and *FREE* redistribution allowed

 User Interface Modifcation, Matt Gorner

*/

@asyncspawn 
@warnings
@version 2.4
@script master
@save relative
@name Kray Override
@define KRAY_COMRING "kray_hub_comring"

version=1055;
modal=0;

c_TotalBlend;
v_TotalBlend=0;
c_ColorLayer;
v_ColorLayer=0;
c_OverrideColor;
v_OverrideColor=0;
c_PureColor;
v_PureColor=0;
c_disblBlur;
v_disblBlur=0;
c_disblLumi;
v_disblLumi=0;
c_disblSpec;
v_disblSpec=0;
c_disblRefl;
v_disblRefl=0;
c_disblTransp;
v_disblTransp=0;
c_disblTranslu;
v_disblTranslu=0;
c_PureDiffuse;
v_PureDiffuse=0;
c_Nodes;
v_Nodes=0;

v_onFlag=0;
c_onFlag;
v_ChooseColor=<200,200,200>;
c_ChooseColor;

v_Wireframe=0;
c_Wireframe;
v_WireColor=<128,128,128>;
c_WireColor;
v_WireThick=0.5;
c_WireThick;
v_WireSmooth=1.5;
c_WireSmooth;

c_disblAll; v_disblAll=0;

lsver{
	v=lscriptVersion();
	
	return v[2]*100+v[3]*10+v[4];
}
lscomringactive{
	return lsver()>270;
}
create
{
    // one-time initialization takes place here

	if (lscomringactive()){
		comringattach(KRAY_COMRING,"process_comring_message");
		send_comring_message(1,5,v_onFlag);
	}
}

destroy
{
    // take care of final clean-up activities here

	if (lscomringactive()){
		send_comring_message(1,5,0);
		comringdetach(KRAY_COMRING);
	}
}

flags
{
    // indicates the type of the Master script.  it can
    // be either SCENE or LAYOUT.  SCENE scripts will be
    // removed whenever the current scene is cleared or
    // replaced.  LAYOUT scripts persist until manually
    // removed.

    return(SCENE);
}

process: event, command
{
    // called for each event that occurs within the filter
    // you specified in flags()
    
    if (!modal && reqisopen()){
        get_values();
    }
}
get_values{
    v_TotalBlend=getvalue(c_TotalBlend);
    v_ColorLayer=getvalue(c_ColorLayer);
    v_OverrideColor=getvalue(c_OverrideColor);
    v_PureColor=getvalue(c_PureColor);
    v_disblBlur=getvalue(c_disblBlur);
    v_disblLumi=getvalue(c_disblLumi);
    v_disblSpec=getvalue(c_disblSpec);
    v_disblRefl=getvalue(c_disblRefl);
    v_disblTransp=getvalue(c_disblTransp);
    v_disblTranslu=getvalue(c_disblTranslu);
    v_PureDiffuse=getvalue(c_PureDiffuse);

    v_onFlag=getvalue(c_onFlag);
    v_ChooseColor=getvalue(c_ChooseColor);
	
	v_disblAll=getvalue(c_disblAll);
	
	v_Nodes=getvalue(c_Nodes);
	
	v_Wireframe=getvalue(c_Wireframe);
	v_WireColor=getvalue(c_WireColor);
	v_WireThick=getvalue(c_WireThick);
	v_WireSmooth=getvalue(c_WireSmooth);

}
read_line: io{
    line=string(io.read());

    if (size(line)>0){  // strip strange ascii chars
        if (strright(line,1)<" "){
            line=strleft(line,len+(-1));
        }
    }
    
    return line;
}
read_int: io{
    return int(read_line(io));
}
read_vector: io{
	return vector(read_line(io));
}

load: what,io
{
    if(what == SCENEMODE){
        read_version=read_int(io);  // version number
        v_TotalBlend=read_int(io);
        v_ColorLayer=read_int(io);
        v_OverrideColor=read_int(io);
        v_PureColor=read_int(io);
        v_disblBlur=read_int(io);
        v_disblLumi=read_int(io);
        v_disblSpec=read_int(io);
        v_disblRefl=read_int(io);
        v_disblTransp=read_int(io);
        v_disblTranslu=read_int(io);
        v_PureDiffuse=read_int(io);
		v_onFlag=read_int(io);
		v_ChooseColor=read_vector(io);

		v_disblAll=read_int(io);

		if (read_version>1000){
			v_Nodes=read_int(io);
		}else{
			v_Nodes=0;
		}
		if (read_version>=1053){
			v_Wireframe=read_int(io);
			v_WireColor=read_vector(io);
			v_WireThick=io.read().asNum();
			v_WireSmooth=io.read().asNum();
		}else{
			v_Wireframe=0;
			v_WireColor=<128,128,128>;
			v_WireThick=0.5;
			v_WireSmooth=1.5;
		}
    	send_comring_message(1,5,v_onFlag);
    }
}

save: what,io
{
    if(what == SCENEMODE)
    {
        // our controls data
        io.writeln(int,version); // version number
        io.writeln(int,v_TotalBlend);
        io.writeln(int,v_ColorLayer);
        io.writeln(int,v_OverrideColor);
        io.writeln(int,v_PureColor);
        io.writeln(int,v_disblBlur);
        io.writeln(int,v_disblLumi);
        io.writeln(int,v_disblSpec);
        io.writeln(int,v_disblRefl);
        io.writeln(int,v_disblTransp);
        io.writeln(int,v_disblTranslu);
        io.writeln(int,v_PureDiffuse);
		io.writeln(int,v_onFlag);
		io.writeln(vector,v_ChooseColor);
		io.writeln(int,v_disblAll);
		io.writeln(int,v_Nodes);
		io.writeln(int,v_Wireframe);
		io.writeln(vector,v_WireColor);
		io.writeln(v_WireThick);
		io.writeln(v_WireSmooth);
       
	if (v_onFlag==1){
		// and script for Kray
		// will be executed after header commands (-1000) and before scene load (0)
		io.writeln("KrayScriptLWSInlined -900;");
		// show off on Kray log ;)
		io.writeln("echo '*** Kray Override script applied';");
		// command code
		io.writeln("overridesurface 0");
		io.writeln("+1*"+v_TotalBlend);
		io.writeln("+2*"+v_ColorLayer);
		io.writeln("+4*"+v_OverrideColor);
		io.writeln("+8*"+v_PureColor);
		io.writeln("+16*"+v_disblBlur);
		io.writeln("+32*"+v_disblLumi);
		io.writeln("+64*"+v_disblSpec);
		io.writeln("+128*"+v_disblRefl);
		io.writeln("+256*"+v_disblTransp);
		io.writeln("+512*"+v_disblTranslu);
		io.writeln("+1024*"+v_PureDiffuse);
		io.writeln("+2048*"+v_Nodes);
		io.writeln("+4096*"+v_Wireframe+";");


		if (v_OverrideColor==1){
			r=dot3d(v_ChooseColor,<1,0,0>);
			g=dot3d(v_ChooseColor,<0,1,0>);
			b=dot3d(v_ChooseColor,<0,0,1>);
			io.writeln("overridecolor ("+(r/255)+","+(g/255)+","+(b/255)+");");
		}
		if (v_Wireframe==1){
			r=dot3d(v_WireColor,<1,0,0>);
			g=dot3d(v_WireColor,<0,1,0>);
			b=dot3d(v_WireColor,<0,0,1>);
			io.writeln("overridewire ("+(r/255)+","+(g/255)+","+(b/255)+"),"+v_WireThick+","+v_WireSmooth+";");
		}

		// end of our script
	}
        io.writeln("end;");
	}
   
}

is_1:value{
    return (value==1);
}
// Utilities
file_exists : file{
	f=File(file,"r");

	res=0;
	
	if (f){
		res=1;
		f.close();
	}
	
	return res;
}
find_image : file{

	plugs=getdir("Plugins");

	running_script = split(SCRIPTID);

	if(running_script[1] != nil ){
		running_script_path = (running_script[1]) + (running_script[2]);
	}else{
		running_script_path = running_script[2];
	}
	if (!plugs){
		plugs=running_script_path;
	}

	if (file_exists(plugs+"/"+file)){
		return plugs+"/"+file;
	}else if (file_exists(plugs+"/lscripts/"+file)){
		return plugs+"/lscripts/"+file;
	}else if (file_exists(plugs+"/lscripts/kray/"+file)){
		return plugs+"/lscripts/kray/"+file;
	}else if (file_exists(running_script_path+"/"+file)){
		return running_script_path+"/"+file;
	}else{
		return 0;
	}
	return file;
}

options
{

    if (reqisopen()){  // check if requester is already open then close it
        reqabort();
    }
        


	// User Interface Layout Variables

	gad_x				= 6;								// Gadget X coord
	gad_y				= 24;								// Gadget Y coord
	gad_w				= 139;								// Gadget width
	gad_h				= 19;								// Gadget height
	gad_text_offset		= 89;								// Gadget text offset
	gad_prev_w			= 0;								// Previous gadget width temp variable

	num_gads			= 11;								// Total number of gadgets vertically (for calculating the max window height)
	num_spacers			= 1;								// Total number of 'normal' spacers
	num_text_spacers	= 0;								// Total number of spacers with text associated with them

	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing_y		= 3;								// Spacing gap size Y
	ui_spacing_x		= 3;								// Spacing gap size X


	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing_y*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_row_offset		= gad_h + ui_spacing_y;				// Row offset

	ui_window_w			= 292;								// Window width
	ui_window_h			= ui_banner_height + (ui_row_offset*num_gads) + 11 ; // Window height
	ui_seperator_w		= ui_window_w + 2;					// Width of seperators
	
	// Check if compiled	
	cname=SCRIPTID;
	cname=strsub(cname,size(cname),1);
	compiled=1;
	if (cname=="s" || cname=="S"){
		compiled=0;
	}

	cmp="LS";
	if (compiled){
		cmp="LSC";
	}
	
    reqbegin("Kray Surface Override (Build " + version + " " + cmp + ")");	
    reqsize(ui_window_w,ui_window_h);

	// Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_override_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_override_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}

	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
	ctlposition(c_onFlag, gad_x, ui_offset_y, gad_w, gad_h, 0);
	ctlrefresh(c_onFlag,"toggle_kray_override");

	c_PureColor = ctlcheckbox("Pure Color",v_PureColor);
	ctlposition(c_PureColor, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset;
	
	c_OverrideColor = ctlcheckbox("Override with Color",v_OverrideColor);
	ctlposition(c_OverrideColor,gad_x, ui_offset_y, gad_w, gad_h, 0);
	
	c_PureDiffuse = ctlcheckbox("Pure Diffuse",v_PureDiffuse);
	ctlposition(c_PureDiffuse, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset;

	c_ChooseColor = ctlcolor("",v_ChooseColor);
	ctlposition(c_ChooseColor, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_TotalBlend = ctlcheckbox("Opaque to Light",v_TotalBlend);
	ctlposition(c_TotalBlend, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing_y + 5;

	c_disblAll = ctlstate("Disable All",false,0,"all_off");
	ctlposition(c_disblAll,gad_x, ui_offset_y, gad_w*2+ui_spacing_y, gad_h, 0);
	
	ui_offset_y += ui_row_offset;

	c_ColorLayer = ctlcheckbox("Disable Textures",v_ColorLayer);
	ctlposition(c_ColorLayer, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_disblRefl = ctlcheckbox("Disable Reflections",v_disblRefl);
	ctlposition(c_disblRefl, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset;

	c_disblBlur = ctlcheckbox("Disable Refl/Refr Blur",v_disblBlur);
	ctlposition(c_disblBlur, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_disblTransp = ctlcheckbox("Disable Transparency",v_disblTransp);
	ctlposition(c_disblTransp,gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset;
	
	c_disblLumi = ctlcheckbox("Disable Luminosity",v_disblLumi);
	ctlposition(c_disblLumi, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_disblTranslu = ctlcheckbox("Disable Translucency",v_disblTranslu);
	ctlposition(c_disblTranslu, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);
	
	ui_offset_y += ui_row_offset;
	
	c_Nodes = ctlcheckbox("Disable Nodes",v_Nodes);
	ctlposition(c_Nodes, gad_x, ui_offset_y, gad_w, gad_h, 0);
	
	c_disblSpec = ctlcheckbox("Disable Specular",v_disblSpec);
	ctlposition(c_disblSpec,gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, 0);
	
	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing_y + 5;
	
	c_Wireframe = ctlcheckbox("Wireframe",v_Wireframe);
	ctlposition(c_Wireframe, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_WireThick = ctlnumber("Wire thickness",v_WireThick);
	ctlposition(c_WireThick, gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;
	
	c_WireColor = ctlcolor("Wire Color",v_WireColor);
	ctlposition(c_WireColor, gad_x, ui_offset_y, gad_w, gad_h, 0);

	c_WireSmooth = ctlnumber("Wire smoothing",v_WireSmooth);
	ctlposition(c_WireSmooth,gad_x + gad_w + ui_spacing_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
	ctlactive(c_Wireframe,"is_1",c_WireThick,c_WireColor,c_WireSmooth);
	
	ctlactive(c_OverrideColor,"is_1",c_ChooseColor);
	ctlactive(c_onFlag,"is_1",
						c_TotalBlend,
						c_ColorLayer,
						c_OverrideColor,
						c_PureColor,
						c_disblBlur,
						c_disblLumi,
						c_disblSpec,
						c_disblRefl,
						c_disblTransp,
						c_disblTranslu,
						c_PureDiffuse,
						c_Nodes,
						c_disblAll,
						c_Wireframe,c_WireThick,c_WireColor,c_WireSmooth);


    if (modal){
        return if !reqpost();
        get_values();
        reqend();
    }else{
        reqopen();
    }
}
all_off: val{
	setvalue(c_ColorLayer,val);
	setvalue(c_disblBlur,val);
	setvalue(c_disblLumi,val);
	setvalue(c_disblSpec,val);
	setvalue(c_disblRefl,val);
	setvalue(c_disblTransp,val);
	setvalue(c_disblTranslu,val);
	setvalue(c_Nodes,val);
}


toggle_kray_override: value
{
    send_comring_message(1,5,value);
}

send_comring_message: dest, from, value
{
	/*
		1 = "Kray Main UI"
		2 = "Physical Sky Plugin"
		3 = "QuickLWF Plugin"
		4 = "Tonemap Blend Plugin"
		5 = "Buffers Plugin"
		6 = "Override Plugin"
		7 = "Instance Plugin"
		8 = "Photon Multiplier Plugin"
	*/

	if (lscomringactive()){
		comringdata_out = comringencode(@"i","i","i"@,dest,from,value);
		comringmsg(KRAY_COMRING, 1, comringdata_out);
	}
}
// Process events coming IN from the Kray Comring
process_comring_message: eventCode, dataPointer
{
	if(eventCode == 1)
	{
		(dest,from,state) = comringdecode(@"i","i","i"@, dataPointer);

		// Message from Kray Plugin
		if(dest == 5 && from == 1)
		{
	        if(reqisopen())
	        {
	            setvalue(c_onFlag, state);
	            v_onFlag = state;
	        }else
	        {
	            v_onFlag = state;
	        }
		}
	}
}