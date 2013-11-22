// Kray 2.5 custom functions

	scnGen_kray25_tf_active:value
	{
	    return value;
	}

	scnGen_kray25_ft_active:value
	{
	    return !value;
	}

	scnGen_kray25_is_1:value
	{
	    return (value==1);
	}
	scnGen_kray25_is_not_1:value
	{
	    return (value!=1);
	}
	scnGen_kray25_is_not_one_not_four_active:value
	{
	    return (value!=1 && value!=4);
	}
	scnGen_kray25_is_one_or_four_active:value
	{
	    return (value!=1 && value!=4);
	}
	scnGen_kray25_is_2:value
	{
	    return (value==2);
	}
	scnGen_kray25_is_less_then_6:value
	{
	    return (value<6);
	}

	scnGen_kray25_is_3:value
	{
	    return (value==3);
	}

	scnGen_kray25_is_not_4:value
	{
	    return (value==4);
	}
	scnGen_kray25_is_not_5:value
	{
	    return (value==5);
	}

	scnGen_kray25_ti_refresh2:value
	{
	    v1=getvalue(kray25_c_tifg);
	    v2=getvalue(kray25_c_tiphotons);
	    if (!v1 && !v2)
	    {
			setvalue(kray25_c_tifg,1);
	    }
	}

	scnGen_kray25_ti_refresh1:value
	{
	    v1=getvalue(kray25_c_tifg);
	    v2=getvalue(kray25_c_tiphotons);
	    if (!v1 && !v2)
	    {
			setvalue(kray25_c_tiphotons,1);
	    }
	}

	scnGen_kray25_zero_one_c_prep_refresh:value
	{
	    if (value<0) setvalue(kray25_c_prep,0);
	    if (value>1) setvalue(kray25_c_prep,1);
	}
	
	scnGen_kray25_format_refresh:v
	{
	    value=getvalue(kray25_c_outfmt);
	    fname=scnGen_kray25_find_frame_number(getvalue(kray25_c_outname));
	    
	    if (fname!=""){ 
		   // find last '.'
		   
			dot=0;
			
			for (a=size(fname) ; a>0 ; a--)
			{
				if (fname[a]=="\\" || fname[a]=="/")
				{
					break;
				}
				if (fname[a]==".")
				{
					dot=a;
					break;
				}
			}
			
			if (dot>0)
			{
				fname=strleft(fname,dot);
			} else {
				fname=string(fname,".");
			}
			

			switch(value)
			{
				case 1:
					n_ext="hdr";
				break;
				case 2:
					n_ext="jpg";
				break;
				case 3:
				case 4:
					n_ext="png";
				break;
				case 5:
				case 6:
					n_ext="tif";
				break;
				case 7:
				case 8:
					n_ext="tga";
				break;
				case 9:
				case 10:
					n_ext="bmp";
				break;
			}

			if (fname!="")
			{
				name=string(fname,n_ext);
				setvalue(kray25_c_outname,name);
			}
		}
	}

	scnGen_kray25_c_dof_on:value
	{
	    return kray25_dof_active;
	}

	scnGen_kray25_c_antigrid:value
	{
	    if (value==2)
	    {
			return true;
	    } else {
			return false;
	    }
	}

	scnGen_kray25_c_antistoc:value
	{
	    if (value==3)
	    {
			return true;
	    } else {
			return false;
	    }
	}

	scnGen_kray25_c_antirand:value
	{
	    if (value==4)
	    {
			return true;
	    } else {
			return false;
	    }
	}

	scnGen_kray25_c_pmdirectopt:value
	{
	    if (value==2)
	    {
			return true;
	    } else {
			return false;
	    }
	}

	scnGen_kray25_c_pmcausticsopt:value
	{
	    if (value!=2)
	    {
			return true;
	    } else {
			if (getvalue(kray25_c_gipmmode)==4)
			{
			    if (getvalue(kray25_c_girtdirect)==1)
			    {
					return true;
			    }
			}
			return false;
	    }
	}

	scnGen_kray25_c_pmrtdirect:value
	{
	    if (value!=2)
	    {
			return false;
	    } else {
			if (getvalue(kray25_c_gipmmode)==4)
			{
		    	return true;
			}
			return false;
	    }
	}

	scnGen_kray25_c_pmirrgradopt:value
	{
	    if (value>=3)
	    {
			return true;
		} else {
			return false;
	    }
	}

	scnGen_kray25_on_off_fsaa_refresh:value
	{
	    setvalue(kray25_c_aafscreen,getvalue(kray25_c_aafscreen));
	}

	scnGen_kray25_c_fgircopy:value
	{
	    setvalue(kray25_c_gir,getvalue(kray25_c_gir_copy));
	}

	scnGen_kray25_c_fgirautocopy:value
	{
	    setvalue(kray25_c_girauto,getvalue(kray25_c_girauto_copy));
	}

	scnGen_kray25_c_gmaticrefresh:value
	{
	    if (getvalue(kray25_c_gph_preset)==1){
			setvalue(kray25_c_gph_preset,1);
	    }
	    if (!value){
			setvalue(kray25_c_girauto,0);
	    }
	}

	scnGen_kray25_c_cmaticrefresh:value
	{
	    if (getvalue(kray25_c_cph_preset)==1){
			setvalue(kray25_c_cph_preset,1);
	    }
	}

	scnGen_kray25_c_gipmmode_refresh:value
	{
	    a=getvalue(kray25_c_gipmmode);
	    setvalue(kray25_c_gipmmode,a);
	}

	scnGen_kray25_c_gi_refresh:value
	{
	    a=getvalue(kray25_c_gi);
	    setvalue(kray25_c_gi,a);
	}

	scnGen_kray25_disable_fscreen_refresh:value	// if aa is none
	{
		if (value==1 || value==4)
		{
			setvalue(kray25_c_aafscreen,1);
		}
	}

	scnGen_kray25_resetfile
	{
		filedelete ( kray25_v_giload );
		logger("info","GI File has been reset!");
	}

	scnGen_kray25_is_name:input
	{
		mlsize=size(input);
		if (mlsize!=0)
		{
		    return true;
		}
		return false;
	}

	scnGen_kray25_aa_edge_active:value
	{
		if (value)
		{
			return 0;
		}
		pset=getvalue(kray25_c_aa_preset);
		if (pset!=1)
		{
			return 0;
		}	
		return 1;
	}

	scnGen_kray25_aa_edge_active2:value
	{
		if (value)
		{
			return 0;
		}
		pset=getvalue(kray25_c_aa_preset);
		if (pset!=1)
		{
			return 0;
		}
		underf=getvalue(kray25_c_underf);
		if (underf!=1)
		{
			return 0;
		}
		return 1;
	}

	scnGen_kray25_c_tab_refresh:value
	{
	    new_active_tab=getvalue(kray25_tab0);
	    if (new_active_tab==3){
			setvalue(kray25_c_gir_copy,getvalue(kray25_c_gir));
			setvalue(kray25_c_girauto_copy,getvalue(kray25_c_girauto));
	    }

	    kray25_active_tab=new_active_tab;
	}

	scnGen_kray25_format_refresh:v
	{
	    value=getvalue(kray25_c_outfmt);
	    fname=scnGen_kray25_find_frame_number(getvalue(kray25_c_outname));
	    
	    if (fname!=""){ 
		   // find last '.'
		   
			dot=0;
			
			for (a=size(fname) ; a>0 ; a--)
			{
				if (fname[a]=="\\" || fname[a]=="/")
				{
					break;
				}
				if (fname[a]==".")
				{
					dot=a;
					break;
				}
			}
			
			if (dot>0)
			{
				fname=strleft(fname,dot);
			} else {
				fname=string(fname,".");
			}
			

			switch(value)
			{
				case 1:
					n_ext="hdr";
				break;
				case 2:
					n_ext="jpg";
				break;
				case 3:
				case 4:
					n_ext="png";
				break;
				case 5:
				case 6:
					n_ext="tif";
				break;
				case 7:
				case 8:
					n_ext="tga";
				break;
				case 9:
				case 10:
					n_ext="bmp";
				break;
			}

			if (fname!="")
			{
				name=string(fname,n_ext);
				setvalue(kray25_c_outname,name);
			}
		}
	}

	scnGen_kray25_find_frame_number:input
	{
	    mlsize=size(input);
		dstreak=0;
		nlen=5;
		replacement="%frame%";
		rsize=size(replacement);
		
		// try to find replacement
		for (a=1+rsize ; a<=mlsize ; a++){
			sub=strsub(input,a+(-rsize),rsize);
			
			if (sub=="%frame%"){
				return input;
			}
		}
		
		// find last / or \
		last_slash=1;
		
	    for (a=1 ; a<=mlsize ; a++){
			character=strsub(input,a,1);
			
			if (character=="/" || character=="\\"){
				last_slash=a;
			}
		}
		
	    for (a=last_slash ; a<=mlsize ; a++){
			character=strsub(input,a,1);
			
			// >= <= < > operators does not work on mac
			if ((character=="0") ||
				(character=="1") ||
				(character=="2") ||
				(character=="3") ||
				(character=="4") ||
				(character=="5") ||
				(character=="6") ||
				(character=="7") ||
				(character=="8") ||
				(character=="9")){
				dstreak++;
			}else{
				if (dstreak>=nlen){
					return strleft(input,a+(-6))+replacement+strsub(input,a,mlsize);
				}
				dstreak=0;
			}
		}
		if (dstreak>=nlen){
			return strleft(input,a+(-6))+replacement;
		}

		return input;
	}

	scnGen_kray25_renderOptsList
	{
		list="";
		if (!Scene().renderopts[1])
		{
			list="`Raytrace Shadows`";
		}
		if (!Scene().renderopts[2])
		{
			if (list!="")
			{
				list=list+",";
			}
			list=list+"`Raytrace Reflection`";
		}
		if (!Scene().renderopts[3])
		{
			if (list!="")
			{
				list=list+",";
			}
			list=list+"`Raytrace Refraction`";
		}
		
		return list;
	}

	scnGen_kray25_refresh_renderinfo_add : value
	{
	    index=getvalue(kray25_c_RenderIinfoAdd);
	    if (index!=1)
	    {
			scnGen_kray25_add_info_command(kray25_c_InfoText,kray25_renderinfo_list[index]);
			setvalue(kray25_c_RenderIinfoAdd,1);
	    }
	}

	scnGen_kray25_add_info_command: control,command
	{
	    str=getvalue(control);
	    if (str!="")
	    {
			if (strright(str,1)!=" ")
			{
				str=str+" ";
			}
	    }
	    setvalue(control,str+command);
	}

	scnGen_kray25_c_dof_on:value{
	    return kray25_dof_active;
	}
	
