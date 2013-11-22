
/*

 Kray Quick Linear Workflow
 by Jure Judez
 Modification and *FREE* redistribution allowed

 User Interface Modifcation, Matt Gorner

*/

@asyncspawn 
@warnings 
@version 2.4
@script master
@save relative
@name KrayQuickLWF
@define KRAY_COMRING "kray_hub_comring"

// global values go here
version = 1023;

c_onFlag;
v_onFlag=1;

c_tmo;
v_tmo=2;		// Tone mapping mode 1=linear 2=gamma 3=exponential
c_tmhsv;
v_tmhsv=0;		// HSV 0=off 1=on
c_outparam;
v_outparam=2.2;   // Parameter
c_outexp;
v_outexp=1;     // Exposure

c_affectbackdrop;
v_affectbackdrop=1;
c_affecttextures;
v_affecttextures=1;
c_affectlights;
v_affectlights=1;

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
		send_comring_message(1,3,v_onFlag);
	}
}

destroy
{
    // take care of final clean-up activities here

	if (lscomringactive()){
		send_comring_message(1,3,0);
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
        send_comring_message(1,3,v_onFlag);
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
    io.writeln(number,v_tmo);
    io.writeln(number,v_tmhsv);
    io.writeln(number,v_outparam);
    io.writeln(number,v_outexp);

    io.writeln(int,201);
    io.writeln(number,v_affectbackdrop);
	
    io.writeln(int,301);
    io.writeln(number,v_affecttextures);
	
    io.writeln(int,401);
    io.writeln(number,v_affectlights);
	
	io.writeln(int,501);
	io.writeln(boolean,v_onFlag);	
	
    io.writeln(int,0);  // end hunk
}

get_general_values{
	v_onFlag=getvalue(c_onFlag);

    v_tmo=getvalue(c_tmo);
    v_tmhsv=getvalue(c_tmhsv);
    v_outparam=getvalue(c_outparam);
    v_outexp=getvalue(c_outexp);

	v_affectbackdrop=getvalue(c_affectbackdrop);
	v_affecttextures=getvalue(c_affecttextures);
	v_affectlights=getvalue(c_affectlights);
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
	v_onFlag=1;
	
	hunk=100;
	while(hunk>=100){
		hunk=read_int(io);
		switch(hunk){
			case 0:
			break;
			case 104:
				v_tmo=read_number(io);
				v_tmhsv=read_number(io);
				v_outparam=read_number(io);
				v_outexp=read_number(io);	
			break;
			case 201:
				v_affectbackdrop=read_number(io);
			break;
			case 301:
				v_affecttextures=read_number(io);
			break;
			case 401:
				v_affectlights=read_number(io);
			break;
			case 501:
				v_onFlag=read_int(io);
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

	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size

	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_row_offset		= gad_h + ui_spacing;				// Row offset

	ui_window_w			= 292;								// Window width
	ui_window_h			= ui_banner_height + (ui_row_offset*num_gads); // Window height
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
	
    reqbegin("Kray Quick LWF (Build " + version + " " + cmp + ")");
    reqsize(ui_window_w, ui_window_h);

    // Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_quicklwf_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_quicklwf_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}
	
	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
    ctlposition(c_onFlag, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);
    ctlrefresh(c_onFlag,"toggle_kray_quicklwf");
	
	ui_offset_y += ui_row_offset;

    c_tmo = ctlpopup("Tone Map Type",v_tmo,@"Linear","Gamma","Exponential"@);
    ctlposition(c_tmo, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

    c_outparam = ctlnumber("Parameter",v_outparam);
    ctlposition(c_outparam, gad_x, ui_offset_y, 67 + gad_text_offset, gad_h, gad_text_offset);

    c_outexp = ctlnumber("Exposure",v_outexp);
    ctlposition(c_outexp, gad_x + 67 + gad_text_offset + ui_spacing, ui_offset_y, 67 + 50, gad_h, 50);

	ui_offset_y += ui_row_offset;

    c_tmhsv = ctlcheckbox("HSV Mode",v_tmhsv);
    ctlposition(c_tmhsv, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset + 5;
	c_sep = ctlsep(0, ui_seperator_w + (-24));
	ctlposition(c_sep, 10, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

    ctlvisible(c_tmo,"is_not_1",c_outexp,c_tmhsv,c_outparam);

	c_affect_text=ctltext("","Affect:");
	ctlposition(c_affect_text, gad_x, ui_offset_y, gad_text_offset, gad_h, gad_text_offset);
	
	c_affectbackdrop = ctlcheckbox("Affect Backdrop",v_affectbackdrop);
    ctlposition(c_affectbackdrop, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	c_affecttextures = ctlcheckbox("Affect Textures",v_affecttextures);
    ctlposition(c_affecttextures, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);

    ui_offset_y += ui_row_offset;

	c_affectlights = ctlcheckbox("Affect Lights",v_affectlights);
    ctlposition(c_affectlights, gad_x, ui_offset_y, gad_w + gad_text_offset, gad_h, gad_text_offset);
	
	ctlactive(c_onFlag,"is_1",c_tmo,c_outparam,c_outexp,c_tmhsv,c_affect_text,c_affectbackdrop,c_affecttextures,c_affectlights);



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
		if (v_affectbackdrop || v_affecttextures || v_affectlights){
			krayfile.writeln("KrayScriptLWSInlined -900;");
			krayfile.writeln("echo '*** Kray quick LWF applied';");			

			tm="inputtonemapper";
			
			switch(v_tmo){
				case 1:
					krayfile.writeln(tm+" linear;");            
				break;
				case 2:
					if (v_tmhsv){
						krayfile.writeln(tm+" v_gamma_exposure,"+v_outparam+","+v_outexp+";");
					}else{
						krayfile.writeln(tm+" gamma_exposure,"+v_outparam+","+v_outexp+";");
					}
				break;
				case 3:
					_v_outexp=v_outexp;
					if (_v_outexp<1.00001){
						_v_outexp=1.00001;
					}
					
					if (v_tmhsv){
						krayfile.writeln(tm+" v_exp_exposure,"+v_outparam+","+_v_outexp+";");
					}else{
						krayfile.writeln(tm+" exp_exposure,"+v_outparam+","+_v_outexp+";");
					}
				break;
			}
			
			if (v_affectlights){
				krayfile.writeln("lwtonemaplights 1;");
			}

			krayfile.writeln("end;");     

			if (v_affecttextures){
				krayfile.writeln("KrayScriptLWSInlined -1900;");
				krayfile.writeln("var __importflags,__importflags|16;");
				krayfile.writeln("end;");     
			}

			if (v_affectbackdrop){
				krayfile.writeln("KrayScriptLWSInlined 1100;");
				krayfile.writeln("background tone_map;");
				krayfile.writeln("end;");     
			}
		}
	}
}

toggle_kray_quicklwf: value
{
    send_comring_message(1,3,value);
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
		if(dest == 3 && from == 1)
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
