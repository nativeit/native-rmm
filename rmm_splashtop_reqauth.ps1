# |  #   #   #   #   #   #   #   #   #   #   #   #   #   __//    N A T I V E . I T    //__    #   #   #   #   #   #   #   #   #   #   #   |
# |                                                                                                                                       |
# |  This script sets Splashtop's security settings such that it will require entering Windows credentials before allowing                |
# |  remote access connections to complete.                                                                                               |
# |                                                                                                                                       |
# |  #   #   #   #   #   #   #   #   #   #   #   #   #   __//    desk.nativeit.net     //__   #   #   #   #   #   #   #   #   #   #   #   |

wmic os get osarchitecture | find "64-bit" && reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Splashtop Inc.\Splashtop Remote Server" /v ReqPassword /t REG_DWORD /d 8 /f || reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Splashtop Inc.\Splashtop Remote Server" /v ReqPassword /t REG_DWORD /d 8 /f 

net stop "SplashtopRemoteService"  

net start "SplashtopRemoteService" 
 
