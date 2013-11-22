
/*

 Kray Tome Mapping Blend
 by Jure Judez
 Modification and *FREE* redistribution allowed

 User Interface Modifcation, Matt Gorner

*/

@asyncspawn 
@warnings 
@version 2.4
@script master
@save relative
@name Kray Tonemap Blending
@define KRAY_COMRING "kray_hub_comring"

// global values go here
version = 1024;
   
c_onFlag;
v_onFlag=1;

c_1st_tmo;
v_1st_tmo=2;		// Tone mapping mode 1=linear 2=gamma 3=exponential
c_1st_tmhsv;
v_1st_tmhsv=0;		// HSV 0=off 1=on
c_1st_outparam;
v_1st_outparam=2.2;   // Parameter
c_1st_outexp;
v_1st_outexp=1;     // Exposure

c_2nd_tmo;
v_2nd_tmo=3;		// Tone mapping mode 1=linear 2=gamma 3=exponential
c_2nd_tmhsv;
v_2nd_tmhsv=0;		// HSV 0=off 1=on
c_2nd_outparam;
v_2nd_outparam=2.2;   // Parameter
c_2nd_outexp;
v_2nd_outexp=1;     // Exposure

c_blending;
blending=0.5;

modal=0;

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
		send_comring_message(1,4,v_onFlag);
	}
}

destroy
{
    // take care of final clean-up activities here

	if (lscomringactive()){
		send_comring_message(1,4,0);
		comringdetach(KRAY_COMRING);
	}
}

flags
{
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
load: what,io
{
    if(what == SCENEMODE){
        load_settings_general(io);
    	send_comring_message(1,4,v_onFlag);
    }
}

save: what,io
{
    if(what == SCENEMODE)
    {
        save_general(io);
		save_krayscript(io);
    }
}

get_values{
    get_general_values();
}

save_general: io
{
    io.writeln(int,104);
    io.writeln(number,v_1st_tmo);
    io.writeln(number,v_1st_tmhsv);
    io.writeln(number,v_1st_outparam);
    io.writeln(number,v_1st_outexp);
	
    io.writeln(number,v_2nd_tmo);
    io.writeln(number,v_2nd_tmhsv);
    io.writeln(number,v_2nd_outparam);
    io.writeln(number,v_2nd_outexp);
	
	io.writeln(number,blending);
	
	io.writeln(int,201);
	io.writeln(boolean,v_onFlag);
	
    io.writeln(int,0);  // end hunk
}

get_general_values{
	v_onFlag=getvalue(c_onFlag);
	
    v_1st_tmo=getvalue(c_1st_tmo);
    v_1st_tmhsv=getvalue(c_1st_tmhsv);
    v_1st_outparam=getvalue(c_1st_outparam);
    v_1st_outexp=getvalue(c_1st_outexp);
	
    v_2nd_tmo=getvalue(c_2nd_tmo);
    v_2nd_tmhsv=getvalue(c_2nd_tmhsv);
    v_2nd_outparam=getvalue(c_2nd_outparam);
    v_2nd_outexp=getvalue(c_2nd_outexp);
	
	blending=getvalue(c_blending);

}

read_line: io{
	line=string(io.read());

	if (size(line)>0){	// strip non ascii chars
		if (strright(line,1)<" "){
			line=strleft(line,len+(-1));
		}
	}
	
	return line;
}
read_int: io{
	return int(read_line(io));
}
read_number: io{
	return number(read_line(io));
}
read_vector: io{
	return vector(read_line(io));
}

load_settings_general: io
{
	hunk=100;
	v_onFlag=1;
	
	while(hunk>=100){
		hunk=read_int(io);
		switch(hunk){
			case 0:
			break;
			case 104:
				v_1st_tmo=read_number(io);
				v_1st_tmhsv=read_number(io);
				v_1st_outparam=read_number(io);
				v_1st_outexp=read_number(io);	
				
				v_2nd_tmo=read_number(io);
				v_2nd_tmhsv=read_number(io);
				v_2nd_outparam=read_number(io);
				v_2nd_outexp=read_number(io);
				
				blending=read_number(io);
				
			break;
			case 201:
				v_onFlag=read_number(io);
			break;
			default:
				hunk_len=hunk%100;
				for (skip=0 ; skip<hunk_len ; skip++){
					s=read_line(io);
				}
			break;
		}
	}
}
is_1:value{
    return (value==1);
}
is_not_1:value{
    return (value!=1);
}
limit100 : value{
	if(value>1) setvalue (c_blending, 1);
	if(value<0) setvalue (c_blending, 0);
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
	gad_w				= 188;								// Gadget width
	gad_h				= 19;								// Gadget height
	gad_text_offset		= 82;								// Gadget text offset
	gad_prev_w			= 0;								// Previous gadget width temp variable

	num_gads			= 8;								// Total number of gadgets vertically (for calculating the max window height)
	num_spacers			= 2;								// Total number of 'normal' spacers
	num_text_spacers	= 0;								// Total number of spacers with text associated with them

	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size

	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_row_offset		= gad_h + ui_spacing;				// Row offset

	ui_window_w			= 292;								// Window width
	ui_window_h			= 248;
	ui_window_h			= ui_banner_height + (ui_row_offset*num_gads) + ((num_spacers*3) + 12) + (4 * ui_spacing) + 2; // Window height

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
	
    reqbegin("Kray Tonemap Blend (Build " + version + " " + cmp + ")");
    reqsize(ui_window_w, ui_window_h);
	
	// Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_tonemap_blend_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_tonemap_blend_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}

    ypos=100;ysize=100;xmid=90;gadget=-25;xsize=280;

	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
    ctlposition(c_onFlag, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);
    ctlrefresh(c_onFlag,"toggle_kray_tonemapblend");
	
	ui_offset_y += ui_row_offset;
    
    c_1st_tmo = ctlpopup("1st Tonemap",v_1st_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(c_1st_tmo, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

    c_1st_tmhsv = ctlcheckbox("HSV Mode",v_1st_tmhsv);
    ctlposition(c_1st_tmhsv, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);
    ypos=ypos+ysize;

	ui_offset_y += ui_row_offset;

    c_1st_outparam = ctlnumber("Parameter",v_1st_outparam);
    ctlposition(c_1st_outparam, gad_x, ui_offset_y, 67 + gad_text_offset, gad_h, gad_text_offset);

    c_1st_outexp = ctlnumber("Exposure",v_1st_outexp);
    ctlposition(c_1st_outexp, gad_x + 67 + gad_text_offset + ui_spacing, ui_offset_y, 67 + 50, gad_h, 50);

    ctlactive(c_1st_tmo,"is_not_1",c_1st_outexp,c_1st_tmhsv,c_1st_outparam);

	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    c_2nd_tmo = ctlpopup("2nd Tonemap",v_2nd_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(c_2nd_tmo, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

    c_2nd_tmhsv = ctlcheckbox("HSV Mode",v_2nd_tmhsv);
    ctlposition(c_2nd_tmhsv,  gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;
	
    c_2nd_outparam = ctlnumber("Parameter",v_2nd_outparam);
    ctlposition(c_2nd_outparam, gad_x, ui_offset_y, 67 + gad_text_offset, gad_h, gad_text_offset);

    c_2nd_outexp = ctlnumber("Exposure",v_2nd_outexp);
    ctlposition(c_2nd_outexp, gad_x + 67 + gad_text_offset + ui_spacing, ui_offset_y, 67 + 50, gad_h, 50);

    ctlactive(c_2nd_tmo,"is_not_1",c_2nd_outexp,c_2nd_tmhsv,c_2nd_outparam);
	
	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;
	
    c_blending = ctlpercent("Blending",blending);
    ctlposition(c_blending,   gad_x, ui_offset_y, gad_w + gad_text_offset - 23, gad_h, gad_text_offset);
	ctlrefresh(c_blending, "limit100");
	
	ctlactive(c_onFlag,"is_1",c_1st_tmo,c_1st_tmhsv,c_1st_outparam,
	c_1st_outexp,c_2nd_tmo,c_2nd_tmhsv,c_2nd_outparam,c_2nd_outexp,c_blending);

    if (modal){
        return if !reqpost();
        get_values();
        reqend();
    }else{
        reqopen();
    }
}

save_krayscript:krayfile{
	if (v_onFlag){
		krayfile.writeln("KrayScriptLWSInlined 200;");
		tm="tonemapdefine";
			switch(v_1st_tmo){
				case 1:
					krayfile.writeln(tm+" t1,linear;");            
				break;
				case 2:
					if (v_1st_tmhsv){
						krayfile.writeln(tm+" t1,v_gamma_exposure,"+v_1st_outparam+","+v_1st_outexp+";");
					}else{
						krayfile.writeln(tm+" t1,gamma_exposure,"+v_1st_outparam+","+v_1st_outexp+";");
					}
				break;
				case 3:
					if (v_1st_tmhsv){
						krayfile.writeln(tm+" t1,v_exp_exposure,"+v_1st_outparam+","+v_1st_outexp+";");
					}else{
						krayfile.writeln(tm+" t1,exp_exposure,"+v_1st_outparam+","+v_1st_outexp+";");
					}
				break;
			}
			switch(v_2nd_tmo){
				case 1:
					krayfile.writeln(tm+" t2,linear;");            
				break;
				case 2:
					if (v_2nd_tmhsv){
						krayfile.writeln(tm+" t2,v_gamma_exposure,"+v_2nd_outparam+","+v_2nd_outexp+";");
					}else{
						krayfile.writeln(tm+" t2,gamma_exposure,"+v_2nd_outparam+","+v_2nd_outexp+";");
					}
				break;
				case 3:
					if (v_2nd_tmhsv){
						krayfile.writeln(tm+" t2,v_exp_exposure,"+v_2nd_outparam+","+v_2nd_outexp+";");
					}else{
						krayfile.writeln(tm+" t2,exp_exposure,"+v_2nd_outparam+","+v_2nd_outexp+";");
					}
				break;
			}
		krayfile.writeln("tonemapper blend,"+blending+",t1,t2;");		
		krayfile.writeln("echo '*** Applying Tonemapper blending: "+blending+" tonemappers: "+v_1st_tmo+"/"+v_2nd_tmo+"';");		

		krayfile.writeln("end;");     
	}
}

toggle_kray_tonemapblend: value
{
    send_comring_message(1,4,value);
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
		if(dest == 4 && from == 1)
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
