
/*

 Kray Instances
 by Jure Judez
 Modification and *FREE* redistribution allowed

 User Interface Modifcation, Matt Gorner

*/

@asyncspawn 
@warnings 
@version 2.4
@save relative
@name Kray Instances
@script custom
@define KRAY_COMRING "kray_hub_comring"

version= 1048;

modal=0;

c_onFlag;
v_onFlag=1;

CloneObject = nil;	c_CloneObject;
driveObject = nil;	c_driveObject;

Hmini = 0; c_Hmini;	Hmaxi = 360; c_Hmaxi;
Pmini = 0; c_Pmini;	Pmaxi = 0; c_Pmaxi;
Bmini = 0; c_Bmini;	Bmaxi = 0; c_Bmaxi;

normalRotate = 0; c_normalRotate;
patternAxes = 0; c_patternAxes;

Xmini = 0.8; c_Xmini;	Xmaxi = 1.2; c_Xmaxi;
Ymini = 1; c_Ymini;	Ymaxi = 1; c_Ymaxi;
Zmini = 1; c_Zmini;	Zmaxi = 1; c_Zmaxi;

LockSize=1; c_LockSize;

Seed = 1;	c_Seed;
useColor = 0;	c_useColor;

lsver{
	v=lscriptVersion();
	
	return v[2]*100+v[3]*10+v[4];
}
lscomringactive{
	return lsver()>270;
}

BaseObj;
objM;
currTime=0;


create: iobj{
	BaseObj = iobj;
	if(BaseObj){
		objM = Mesh(BaseObj.id);
	}

	if (lscomringactive()){
	comringattach(KRAY_COMRING,"process_comring_message");
	send_comring_message(1,7,v_onFlag);
		
	}
}

newtime: frame, time{
	currTime = time;
}

process: ca{
    if (!modal && reqisopen() && !loadmode){
        get_values();
    }
	pntCntT = BaseObj.pointCount(); // count number of points in object
	
	//setdesc("Kray Instances - using ",pntCntT," points");
	prefix = "Kray Instances: ";
	
	if (v_onFlag == 0){
		setdesc(prefix, " Disabled");
	}else if (CloneObject == nil){
		setdesc(prefix," (none)");
	// }else if (Particle(BaseObj)){
		// particles = Particle(BaseObj);
		// partcnt = particles.count();
		// setdesc(prefix, " using particles");
		// if (v_onFlag == 0){
			// setdesc(prefix, " Disabled");}
	}else{
		if (patternAxes){
			polCnt = BaseObj.polygonCount();
			setdesc(prefix, CloneObject.name, " - ", polCnt/2, " instances");
		}else{
			setdesc(prefix, CloneObject.name, " - ", pntCntT, " instances");
		}
	}
}

get_values{
	v_onFlag=getvalue(c_onFlag);

	CloneObject=getvalue(c_CloneObject);
	driveObject=getvalue(c_driveObject);

	Hmini=getvalue(c_Hmini);
	Hmaxi=getvalue(c_Hmaxi);
	Pmini=getvalue(c_Pmini);
	Pmaxi=getvalue(c_Pmaxi);
	Bmini=getvalue(c_Bmini);
	Bmaxi=getvalue(c_Bmaxi);
	patternAxes=getvalue(c_patternAxes);
	normalRotate=getvalue(c_normalRotate);

	Xmini=getvalue(c_Xmini);
	Xmaxi=getvalue(c_Xmaxi);
	Ymini=getvalue(c_Ymini);
	Ymaxi=getvalue(c_Ymaxi);
	Zmini=getvalue(c_Zmini);
	Zmaxi=getvalue(c_Zmaxi);
	LockSize=getvalue(c_LockSize);
	
	Seed=getvalue(c_Seed);
	useColor=getvalue(c_useColor);

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

	gad_x				= 10;								// Gadget X coord
	gad_y				= 24;								// Gadget Y coord
	gad_w				= 77;								// Gadget width
	gad_h				= 19;								// Gadget height
	gad_text_offset		= 82;								// Gadget text offset
	gad_prefixv_w			= 0;								// prefixvious gadget width temp variable

	ui_window_w			= 292;								// Window width
	ui_window_h			= 434;								// Window height
	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size

	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_seperator_w		= ui_window_w + 2;					// Width of seperators
	ui_row_offset		= gad_h + ui_spacing;				// Row offset
	
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

    reqbegin("Kray Instances (Build " + version+ " " + cmp + ")");   
    if (modal){
		reqsize(ui_window_w,ui_window_h);
    }else{
        reqsize(ui_window_w,ui_window_h+(-30));
    }

	
	// Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_instance_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_instance_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}
	
	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
    ctlposition(c_onFlag, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset, gad_h, gad_text_offset);
	//ctlrefresh(c_onFlag,"toggle_kray_instances");
	
	ui_offset_y += ui_row_offset;
	
    c_CloneObject = ctlmeshitems("Object to Clone",CloneObject);
    ctlposition(c_CloneObject, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset, gad_h, gad_text_offset);
    
    ui_offset_y += ui_row_offset;

    c_driveObject = ctlmeshitems("Object to Follow",driveObject);
    ctlposition(c_driveObject,gad_x, ui_offset_y, gad_w + 106  + gad_text_offset, gad_h, gad_text_offset);
    
	ui_offset_y += ui_row_offset + 4;
	c_sep1 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep1, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    c_Hmini = ctlangle("Heading Min",Hmini);
    ctlposition(c_Hmini,gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);
    
    c_Hmaxi = ctlangle("Max",Hmaxi);
    ctlposition(c_Hmaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);
    
    ui_offset_y += ui_row_offset;

    c_Pmini = ctlangle("Pitch Min",Pmini);
    ctlposition(c_Pmini, gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);

    c_Pmaxi = ctlangle("Max",Pmaxi);
    ctlposition(c_Pmaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);

    ui_offset_y += ui_row_offset;

    c_Bmini = ctlangle("Bank Min",Bmini);
    ctlposition(c_Bmini, gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);

    c_Bmaxi = ctlangle("Max",Bmaxi);
    ctlposition(c_Bmaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);

    ui_offset_y += ui_row_offset;

    c_normalRotate = ctlcheckbox("Use Normals",normalRotate);
    ctlposition(c_normalRotate, gad_x, ui_offset_y, gad_w + 106  + gad_text_offset, gad_h, gad_text_offset);
    
	ui_offset_y += ui_row_offset + 4;
	c_sep1 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep1, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    c_Xmini = ctlpercent("Scale X Min",Xmini);
    ctlposition(c_Xmini, gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);

    c_Xmaxi = ctlpercent("Max",Xmaxi);
    ctlposition(c_Xmaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);

    ui_offset_y += ui_row_offset;

    c_Ymini = ctlpercent("Scale Y Min",Ymini);
    ctlposition(c_Ymini, gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);

    c_Ymaxi = ctlpercent("Max",Ymaxi);
    ctlposition(c_Ymaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);

    ui_offset_y += ui_row_offset;

    c_Zmini = ctlpercent("Scale Z Min",Zmini);
    ctlposition(c_Zmini, gad_x, ui_offset_y, gad_w + gad_text_offset - 22, gad_h, gad_text_offset);

    c_Zmaxi = ctlpercent("Max",Zmaxi);
    ctlposition(c_Zmaxi, gad_x + gad_w + gad_text_offset + ui_spacing, ui_offset_y, gad_w + 26 - 22, gad_h, 26);

    ui_offset_y += ui_row_offset;

    c_LockSize = ctlcheckbox("Lock XYZ Size",LockSize);
    ctlposition(c_LockSize, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset, gad_h, gad_text_offset);
    ctlactive(c_LockSize,"is_not1",c_Ymini,c_Ymaxi,c_Zmini,c_Zmaxi);

	ui_offset_y += ui_row_offset + 4;
	c_sep2 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep2, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    c_Seed = ctlminislider("Random Seed",Seed,1,10000);
    ctlposition(c_Seed, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset - 22, gad_h, gad_text_offset);

    ui_offset_y += ui_row_offset;

    c_useColor = ctlcheckbox("Use Color",useColor);
    ctlposition(c_useColor, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset, gad_h, gad_text_offset);

    ui_offset_y += ui_row_offset;

    c_patternAxes = ctlcheckbox("Use Custom Object",patternAxes);
    ctlposition(c_patternAxes, gad_x, ui_offset_y, gad_w + 106 + gad_text_offset, gad_h, gad_text_offset);
	
	ctlactive(c_onFlag,"is_1",c_CloneObject,c_driveObject,c_Hmini,c_Hmaxi,c_Pmini,c_Pmaxi,c_Bmini,c_Bmaxi,
	c_normalRotate,c_Xmini,c_Xmaxi,c_Ymini,c_Ymaxi,c_Zmini,c_Zmaxi,c_LockSize,c_Seed,c_useColor,c_patternAxes);

	
        if (modal){
        return if !reqpost();
        get_values();
        reqend();
    }else{
        reqopen();
    }

}
is_1:value{
    return (value == 1);
}
is_2:value{
    return (value == 2);
}
is_3:value{
    return (value == 3);
}
is_4:value{
    return (value == 4);
}

is_not_234:value{
    return (value !=2 && value !=3 && value !=4);
}

is_not1:value{
    return (value != 1);
}
read_int: io{
    return int(read_line(io));
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

load: what,io
{
    if(what == SCENEMODE) // processing an ASCII scene file
    {        
		Lversion=read_int(io);  // skip version number

		CloneObjectID = integer(io.read());
		if(CloneObjectID != 0){
			CloneObject=Mesh(CloneObjectID);  
		}else{
			CloneObject=nil;
		}
		
		driveObjectID = integer(io.read());
		if(driveObjectID != 0){
			driveObject=Mesh(driveObjectID);  
		}else{
			driveObject=nil;
		}

		Hmini=io.read().asNum();
		Hmaxi=io.read().asNum();
		Pmini=io.read().asNum();
		Pmaxi=io.read().asNum();
		Bmini=io.read().asNum();
		Bmaxi=io.read().asNum();
		patternAxes=read_int(io);
		normalRotate=read_int(io);

		Xmini=io.read().asNum();
		Xmaxi=io.read().asNum();
		Ymini=io.read().asNum();
		Ymaxi=io.read().asNum();
		Zmini=io.read().asNum();
		Zmaxi=io.read().asNum();
		LockSize=read_int(io);

		Seed=read_int(io);
		useColor=read_int(io);
		if (Lversion > 1040){
			v_onFlag=read_int(io);
		}else{
			v_onFlag=1;
		}
    }
}

save: what,io
{

    if(what == SCENEMODE){
		io.writeln(int,version); // version number
		if (CloneObject != nil){
			io.writeln(CloneObject.id);
		}else{
			io.writeln(0);
		}
		if (driveObject != nil){
		   io.writeln(driveObject.id);
		}else{
			io.writeln(0);
		}

		io.writeln(Hmini);
		io.writeln(Hmaxi);
		io.writeln(Pmini);
		io.writeln(Pmaxi);
		io.writeln(Bmini);
		io.writeln(Bmaxi);
		io.writeln(patternAxes);
		io.writeln(normalRotate);

		io.writeln(Xmini);
		io.writeln(Xmaxi);
		io.writeln(Ymini);
		io.writeln(Ymaxi);
		io.writeln(Zmini);
		io.writeln(Zmaxi);
		io.writeln(LockSize);

		io.writeln(Seed);
		io.writeln(useColor);
		
		io.writeln(boolean,v_onFlag);

		
		if (v_onFlag && CloneObject != nil){
			io.writeln("KrayScriptLWSInlined 900;");
			io.writeln("echo '*** Kray Instances applied';");
			
			instanceFlags=0;
			
			if (useColor){
				instanceFlags+=2;
			}
			if (BaseObj.null) {
				instanceFlags+=1;
			}
			instanceFlags+=0x10000;		// add mesh patterns template
			instanceFlags+=0x20000;		// add attached particles as instance template

			io.writeln("instancetemplatelwitem "+hex(BaseObj.id)+","+hex(CloneObject.id)+","+instanceFlags+";");

			io.writeln("instancetransformer "+hex(BaseObj.id)+",randomseed,"+Seed+";");

			io.writeln("instancetransformer "+hex(BaseObj.id)+",randrotate,"+Hmini+","+Hmaxi+",(0,1,0);");
			io.writeln("instancetransformer "+hex(BaseObj.id)+",randrotate,"+Pmini+","+Pmaxi+",(1,0,0);");
			io.writeln("instancetransformer "+hex(BaseObj.id)+",randrotate,"+Bmini+","+Bmaxi+",(0,0,1);");
			if (LockSize){
				io.writeln("instancetransformer "+hex(BaseObj.id)+",randscale,"+Xmini+","+Xmaxi+";");
			}else{
				io.writeln("instancetransformer "+hex(BaseObj.id)+",randscalex,"+Xmini+","+Xmaxi+";");
				io.writeln("instancetransformer "+hex(BaseObj.id)+",randscaley,"+Ymini+","+Ymaxi+";");
				io.writeln("instancetransformer "+hex(BaseObj.id)+",randscalez,"+Zmini+","+Zmaxi+";");
			}
			if (driveObject != nil){
				io.writeln("instancetransformer "+hex(BaseObj.id)+",copyaxes,"+hex(driveObject.id)+";");
			}
			if(patternAxes){
				io.writeln("instancetransformer "+hex(BaseObj.id)+",patternaxes;");
			}

			if(normalRotate){
				io.writeln("instancetransformer "+hex(BaseObj.id)+",normalrotate;");
			}
			io.writeln("end;");
		}
    }
}

// removed to allow switching on individual instances
// toggle_kray_instances: value
// {
    // send_comring_message(1,7,value);
// }

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
		if(dest == 7 && from == 1)
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