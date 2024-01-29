$computername = Read-Host -Prompt 'what is the old computer name'
cmd /c "p:\loadstate.exe q:\$computername /auto"