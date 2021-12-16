
#                                                             𝝢 𝝠 𝝩 𝝞 𝗩 𝝣 ⧟ 𝝞 𝝩                                                             
# ⎧ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎫
# |                                                                                                                                         |
# |                                                                                                                                         |
# |  This script sets Splashtop's security settings such that it will require entering Windows credentials before allowing                  |
# |  remote access connections to complete.                                                                                                 |
# |                                                                                                                                         |
# ⎩ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ⎭
#       ⧉ desk.nativeit.net                                                                        𝑖 𝑚 𝑎 𝑔 𝑖 𝑛 𝑎 𝑡 𝑖 𝑜 𝑛  ✚  𝑡 𝑒 𝑐 ℎ 𝑛 𝑜 𝑙 𝑜 𝑔 𝑦


wmic os get osarchitecture | find "64-bit" && reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Splashtop Inc.\Splashtop Remote Server" /v ReqPassword /t REG_DWORD /d 8 /f || reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Splashtop Inc.\Splashtop Remote Server" /v ReqPassword /t REG_DWORD /d 8 /f 

net stop "SplashtopRemoteService"  

net start "SplashtopRemoteService" 
 
