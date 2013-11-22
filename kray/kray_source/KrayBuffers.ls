
/*

 Kray Buffers Script
 by Grzegorz Tanski / Jure Judez
 Modification and *FREE* redistribution allowed

 User Interface Modifcation, Matt Gorner

*/

@asyncspawn
@warnings
@version 2.4
@script master
@save relative
@name KrayBuffers
@define KRAY_COMRING "kray_hub_comring"

version=1018;

modal=0;
   
c_onFlag;
v_onFlag=1;

c_rgb;
v_rgb=1;
c_alph;
v_alph=0;
c_txtr;
v_txtr=0;
c_zbuf;
v_zbuf=0;

c_zbufMode;
v_zbufMode=1;
c_zbufFrontClip;
v_zbufFrontClip=0;
c_zbufBackClip;
v_zbufBackClip=-1;
c_zbufFrontValue;
v_zbufFrontValue=0;
c_zbufBackValue;
v_zbufBackValue=1;

c_dire;
v_dire=0;
c_indi;
v_indi=0;
c_caus;
v_caus=0;
c_refl;
v_refl=0;
c_refr;
v_refr=0;
c_othr;
v_othr=0;

c_lumi;
v_lumi=0;
c_sfid;
v_sfid=0;
c_obid;
v_obid=0;
c_norm;
v_norm=0;

c_all_on;
c_all_off;

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
		send_comring_message(1,6,v_onFlag);
	}
}

destroy
{
    // take care of final clean-up activities here
    
	if (lscomringactive()){
		send_comring_message(1,6,0);
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

read_line: io{
	line=string(io.read());

	if (size(line)>0){	// strip strange ascii chars
		if (strright(line,1)<" "){
			line=strleft(line,len+(-1));
		}
	}
	
	return line;
}
read_int: io{
	return int(read_line(io));
}
load: what,io
{
    if(what == SCENEMODE){
		v=read_int(io);  // get version number
		v_rgb=read_int(io);
		v_alph=read_int(io);
		v_txtr=read_int(io);
		v_zbuf=read_int(io);
		v_dire=read_int(io);
		v_indi=read_int(io);
		v_caus=read_int(io);
		v_refl=read_int(io);
		v_refr=read_int(io);
		v_othr=read_int(io);
		
		if (v>10){
			v_zbufMode=read_int(io);
			v_zbufFrontClip=read_int(io);
			v_zbufBackClip=read_int(io);
			v_zbufFrontValue=read_int(io);
			v_zbufBackValue=read_int(io);

			v_lumi=read_int(io);			
			v_sfid=read_int(io);			
			v_obid=read_int(io);
			v_norm=read_int(io);
		}else{
			v_zbufMode=1;
			v_zbufFrontClip=0;
			v_zbufBackClip=-1;
			v_zbufFrontValue=0;
			v_zbufBackValue=1;

			v_lumi=0;			
			v_sfid=0;			
			v_obid=0;
			v_norm=0;
		}
		if (v>1015){
			v_onFlag=read_int(io);
		}else{
			v_onFlag=1;
		}
    	send_comring_message(1,6,v_onFlag);
    }
}

save: what,io
{
    if(what == SCENEMODE)
    {
		// our controls data
		io.writeln(int,version);	// version number
		io.writeln(int,v_rgb);
		io.writeln(int,v_alph);
		io.writeln(int,v_txtr);
		io.writeln(int,v_zbuf);		
		io.writeln(int,v_dire);
		io.writeln(int,v_indi);
		io.writeln(int,v_caus);
		io.writeln(int,v_refl);
		io.writeln(int,v_refr);
		io.writeln(int,v_othr);

		// version 11+
		io.writeln(int,v_zbufMode);
		io.writeln(int,v_zbufFrontClip);
		io.writeln(int,v_zbufBackClip);
		io.writeln(int,v_zbufFrontValue);
		io.writeln(int,v_zbufBackValue);

		io.writeln(int,v_lumi);
		io.writeln(int,v_sfid);
		io.writeln(int,v_obid);
		io.writeln(int,v_norm);
		
		// version 1016+ only
		io.writeln(boolean,v_onFlag);
		
		// and script for Kray
		if (v_onFlag){	
			if (v_sfid|v_obid){
				io.writeln("KrayScriptLWSInlined -1900;");
				io.writeln("var __importflags,__importflags|32;");	// tell Kray to assign sufrace/object ids to surfaces, this must be called before scene load
				io.writeln("end;");
			}


			// will be executed after header commands (-1000) but before scene load (0) and tailer commands (1000)
			io.writeln("KrayScriptLWSInlined -900;");
			// show off on Kray log ;)
			io.writeln("echo '*** Kray buffers script applied';");
			// command code
			io.writeln("needbuffers 0");
			io.writeln("+0x1*"+v_rgb);
			io.writeln("+0x2*"+v_alph);
			io.writeln("+0x4*"+v_txtr);
			io.writeln("+0x8*"+v_zbuf);
			io.writeln("+0x10*"+v_dire);
			io.writeln("+0x40*"+v_indi);
			io.writeln("+0x100*"+v_caus);
			io.writeln("+0x400*"+v_refl);
			io.writeln("+0x1000*"+v_refr);
			io.writeln("+0x4000*"+v_lumi);
			io.writeln("+0x10000*"+v_othr);
			io.writeln("+0x40000*"+v_sfid);
			io.writeln("+0x100000*"+v_obid);
			io.writeln("+0x400000*"+v_norm+";");
			
			switch(v_zbufMode){
				case 1:
					Ztemp="linear";
				break;
				case 2:
					Ztemp="inverse";
				break;	
				case 3:
					Ztemp="log";
				break;			
			}
			
			io.writeln("ztonemapper "+Ztemp+","+v_zbufFrontClip+","+v_zbufBackClip+","+v_zbufFrontValue+","+v_zbufBackValue+";"); 
			if(v_zbuf==1){
				io.writeln("echo '*** Z-buffer tonemap set to "+Ztemp+","+v_zbufFrontClip+","+v_zbufBackClip+","+v_zbufFrontValue+","+v_zbufBackValue+"';");
			}		
			
			// end of our script
			io.writeln("end;");
		}	
    }
}

get_values{
	v_onFlag=getvalue(c_onFlag);

	v_rgb=getvalue(c_rgb);
	v_alph=getvalue(c_alph);
	v_txtr=getvalue(c_txtr);
	v_zbuf=getvalue(c_zbuf);
	v_zbufMode=getvalue(c_zbufMode);
	v_zbufFrontClip=getvalue(c_zbufFrontClip);
	v_zbufBackClip=getvalue(c_zbufBackClip);
	v_zbufFrontValue=getvalue(c_zbufFrontValue);
	v_zbufBackValue=getvalue(c_zbufBackValue);
	v_dire=getvalue(c_dire);
	v_indi=getvalue(c_indi);
	v_caus=getvalue(c_caus);
	v_refl=getvalue(c_refl);
	v_refr=getvalue(c_refr);
	v_othr=getvalue(c_othr);

	v_lumi=getvalue(c_lumi);
	v_sfid=getvalue(c_sfid);
	v_obid=getvalue(c_obid);
	v_norm=getvalue(c_norm);

}
is_1:value{
    return (value==1);
}
c_zbufopt:value{
	if (value==1){
		return true;
	}else{
		return false;
	}
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
	gad_text_offset		= 67;								// Gadget text offset
	gad_prev_w			= 0;								// Previous gadget width temp variable
	
	num_gads			= 11;								// Total number of gadgets vertically (for calculating the max window height)

	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size
	ui_spacing_y		= 3;
	
	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_row_offset		= gad_h + ui_spacing;				// Row offset

	ui_window_w			= 292;								// Window width
	ui_window_h			= ui_offset_y + (gad_h*num_gads) + (ui_spacing*(num_gads+1)) + 12; // Window height
	ui_seperator_w		= ui_window_w + 2;					// Width of seperators
	
	button_third 		= (((gad_w * 2 + ui_spacing_y) / 3) - ui_spacing_y + 1); // Bottom buttons 1/3 of width
	
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
	
    reqbegin("Kray Buffers (Build " + version + " " + cmp + ")");
    reqsize(ui_window_w,ui_window_h);

	// Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_buffers_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_buffers_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}

	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
    ctlposition(c_onFlag, gad_x, ui_offset_y, gad_w, gad_h, 0);
	ctlrefresh(c_onFlag,"toggle_kray_buffers");
	
    c_rgb = ctlcheckbox("RGB Output (Final)",v_rgb);
    ctlposition(c_rgb, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);
	
	ui_offset_y += ui_row_offset;

    c_alph = ctlcheckbox("Alpha",v_alph);
    ctlposition(c_alph, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_txtr = ctlcheckbox("Texture",v_txtr);
    ctlposition(c_txtr, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);
    
    ui_offset_y += ui_row_offset;

    c_zbuf = ctlcheckbox("Z Buffer",v_zbuf);
    ctlposition(c_zbuf, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_zbufMode = ctlpopup("Z Buffer Mode",v_zbufMode,@"Linear","Inverse","Log"@);
	ctlposition(c_zbufMode, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);

    ui_offset_y += ui_row_offset;

	c_zbufFrontClip = ctldistance("Clip: Front",v_zbufFrontClip);
	ctlposition(c_zbufFrontClip, gad_x, ui_offset_y, 68 + gad_text_offset, gad_h, gad_text_offset);

	c_zbufBackClip = ctldistance("Clip: Back",v_zbufBackClip);
	ctlposition(c_zbufBackClip, 68 + gad_text_offset + ui_spacing + gad_x, ui_offset_y, 68 + gad_text_offset, gad_h, gad_text_offset);

    ui_offset_y += ui_row_offset;

	c_zbufFrontValue = ctlnumber("Value: Front",v_zbufFrontValue);
	ctlposition(c_zbufFrontValue, gad_x, ui_offset_y, 68 + gad_text_offset, gad_h, gad_text_offset);

	c_zbufBackValue = ctlnumber("Value: Back",v_zbufBackValue);
	ctlposition(c_zbufBackValue, 68 + gad_text_offset + ui_spacing + gad_x, ui_offset_y, 68 + gad_text_offset, gad_h, gad_text_offset);

	ctlactive(c_zbuf,"c_zbufopt",c_zbufMode,c_zbufFrontClip,c_zbufBackClip,c_zbufFrontValue,c_zbufBackValue);

    ui_offset_y += ui_row_offset;

    c_dire = ctlcheckbox("Direct Lighting",v_dire);
    ctlposition(c_dire, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_indi = ctlcheckbox("Indirect Lighting",v_indi);
    ctlposition(c_indi, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);

    ui_offset_y += ui_row_offset;

    c_refl = ctlcheckbox("Reflections",v_refl);
    ctlposition(c_refl, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_refr = ctlcheckbox("Refractions",v_refr);
    ctlposition(c_refr, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);
    
    ui_offset_y += ui_row_offset;

    c_lumi = ctlcheckbox("Luminosity",v_lumi);
    ctlposition(c_lumi, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_caus = ctlcheckbox("Caustics",v_caus);
    ctlposition(c_caus, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);

    ui_offset_y += ui_row_offset;

    c_sfid = ctlcheckbox("Surface ID",v_sfid);
    ctlposition(c_sfid, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_obid = ctlcheckbox("Object ID",v_obid);
    ctlposition(c_obid, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);

    ui_offset_y += ui_row_offset;

    c_norm = ctlcheckbox("Normal Vector",v_norm);
    ctlposition(c_norm, gad_x, ui_offset_y, gad_w, gad_h, 0);

    c_othr = ctlcheckbox("Other",v_othr);
    ctlposition(c_othr, gad_x + gad_w + ui_spacing, ui_offset_y, gad_w, gad_h, 0);

	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    c_all_on = ctlbutton("Select All",1,"all_on");
    ctlposition(c_all_on, gad_x, ui_offset_y, button_third, gad_h, 0);

    c_all_off = ctlbutton("Clear All",1,"all_off");
    ctlposition(c_all_off, gad_x + button_third + ui_spacing, ui_offset_y, button_third, gad_h, 0);
    
    c_invert = ctlbutton("Invert",1,"invert");
    ctlposition(c_invert, gad_x + button_third*2 + ui_spacing*2, ui_offset_y, button_third, gad_h, 0);

	ctlactive(c_onFlag,"is_1",c_rgb,c_alph,c_txtr,c_zbuf,c_zbufMode,c_zbufFrontClip,
	c_zbufBackClip,c_zbufFrontValue,c_zbufBackValue,c_dire,c_indi,c_refl,c_refr,
	c_lumi,c_caus,c_sfid,c_obid,c_norm,c_othr,c_all_on,c_all_off,c_invert);
	
    if (modal){
        return if !reqpost();
        get_values();
        reqend();
    }else{
        reqopen();
    }
}

all_on
{
	// setvalue(c_rgb,  1);
	setvalue(c_alph, 1);
	setvalue(c_txtr, 1);
	setvalue(c_zbuf, 1);
	setvalue(c_dire, 1);
	setvalue(c_indi, 1);
	setvalue(c_refl, 1);
	setvalue(c_refr, 1);
	setvalue(c_lumi, 1);
	setvalue(c_caus, 1);
	setvalue(c_sfid, 1);
	setvalue(c_obid, 1);
	setvalue(c_norm, 1);
	setvalue(c_othr, 1);
}

all_off
{
	// setvalue(c_rgb,  0);
	setvalue(c_alph, 0);
	setvalue(c_txtr, 0);
	setvalue(c_zbuf, 0);
	setvalue(c_dire, 0);
	setvalue(c_indi, 0);
	setvalue(c_refl, 0);
	setvalue(c_refr, 0);
	setvalue(c_lumi, 0);
	setvalue(c_caus, 0);
	setvalue(c_sfid, 0);
	setvalue(c_obid, 0);
	setvalue(c_norm, 0);
	setvalue(c_othr, 0);
}

invert
{
    if (getvalue(c_alph) == 1){
		setvalue(c_alph, 0);
	}else{
		setvalue(c_alph, 1);
	}

    if (getvalue(c_txtr) == 1){
		setvalue(c_txtr, 0);
	}else{
		setvalue(c_txtr, 1);
	}
	
	if (getvalue(c_zbuf) == 1){
		setvalue(c_zbuf, 0);
	}else{
		setvalue(c_zbuf, 1);
	}
	
	if (getvalue(c_dire) == 1){
		setvalue(c_dire, 0);
	}else{
		setvalue(c_dire, 1);
	}
	
	if (getvalue(c_indi) == 1){
		setvalue(c_indi, 0);
	}else{
		setvalue(c_indi, 1);
	}
	
	if (getvalue(c_refl) == 1){
		setvalue(c_refl, 0);
	}else{
		setvalue(c_refl, 1);
	}
	
	if (getvalue(c_refr) == 1){
		setvalue(c_refr, 0);
	}else{
		setvalue(c_refr, 1);
	}
	
	if (getvalue(c_lumi) == 1){
		setvalue(c_lumi, 0);
	}else{
		setvalue(c_lumi, 1);
	}
	
	if (getvalue(c_caus) == 1){
		setvalue(c_caus, 0);
	}else{
		setvalue(c_caus, 1);
	}
	
	if (getvalue(c_sfid) == 1){
		setvalue(c_sfid, 0);
	}else{
		setvalue(c_sfid, 1);
	}
	
	if (getvalue(c_obid) == 1){
		setvalue(c_obid, 0);
	}else{
		setvalue(c_obid, 1);
	}
	
	if (getvalue(c_norm) == 1){
		setvalue(c_norm, 0);
	}else{
		setvalue(c_norm, 1);
	}
	
	if (getvalue(c_othr) == 1){
		setvalue(c_othr, 0);
	}else{
		setvalue(c_othr, 1);
	}
}

toggle_kray_buffers: value
{
    send_comring_message(1,6,value);
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
		if(dest == 6 && from == 1)
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
