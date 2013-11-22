scnGen_kray25_ToneMap_limit100 : value
{
	if(value>1) setvalue (kray25_ToneMap_c_blending, 1);
	if(value<0) setvalue (kray25_ToneMap_c_blending, 0);
}
