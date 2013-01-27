@script master
@name "ComRing MC"

create
{
	comringattach("LW_PassPort","getCommand");
}

process: event, command
{
	
}

destroy
{
	comringdetach("LW_PassPort");
}

getCommand: event,data
{
	if(event == 1)
    {
    	info("Well, it recognizes that I've sent a command.");
    	comRingCommand = comringdecode(@"s:200#2"@,data);
    	info(comRingCommand[1]," ",comRingCommand[2]);
    }
}