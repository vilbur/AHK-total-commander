# TcButtonBarButton  
``` php
$usercmd_ini	= %Commander_Path%\usercmd.ini
$Button_empty   := new TcButtonBarButton().empty()
$Custom_command := new TcButtonBarButton($usercmd_ini).loadCommand( "em_TestTcButtonBar" )
$Button         := new TcButtonBarButton().cmd( "foo.bat" )
                                          .icon("%systemroot%\system32\shell32.dll", 43)
                                          .tooltip("Tooltip test")
```  