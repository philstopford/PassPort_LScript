@version 2.4
@script generic
@name KrayLicenseTool

kray_lic_name="kray_key.txt";

verstion=1002;

c_license;
v_license;
	
find_plugs{
	dir=getdir("Settings");
	if (dir!=nil){
		return dir;
	}else{
		return getdir("Plugins");
	}
}
openunlock{
    CommandInput("Generic_KrayGotoUnlockURL");
}
refreshlicense : value{
	v_license=getvalue(c_license);
		
	if (size(v_license)<(5+1+1+3+1+1+4+32)){
		info("Unlock code is too short. Make sure you have copied whole unlock code.");
	}
}
generic
{
	license_file=find_plugs()+"/"+kray_lic_name;

	f=File(license_file,"r");

	if (f){
		v_license=f.read();
		f.close();
	}else{
		v_license="Copy and paste unlock code here.";
	}		
	
	reqbegin("Kray License Tool");
	c_license = ctlstring("Unlock",v_license);
	ctlposition(c_license, 10, 10, 500, 20, 50);
	ctlrefresh(c_license,"refreshlicense");

    c_gotourl = ctlbutton("Get unlock code, visit www.kraytracing.com/unlockcode",1,"openunlock");
	ctlposition(c_gotourl, 10, 30, 500, 20, 50);
	
	return if !reqpost();
	
	v_license=getvalue(c_license);
	f=File(license_file,"w");

	if (f){
		f.writeln(v_license);
		f.close();
	}else{
		info("Unable to write license key file.");
	}		

	reqend();
}

