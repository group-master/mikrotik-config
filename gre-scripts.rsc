/system script
add name=gre-firewall owner=administrator policy=read,write,policy,test \
    source="/ip firewall filter\r\
    \nadd action=accept chain=input comment=\"Allow GRE\" log-prefix=an protoc\
    ol=gre\r\
    \nadd action=accept chain=input comment=\"Allow OSPF\" connection-state=ne\
    w \\\r\
    \n    log-prefix=an protocol=ospf\r\
    \nadd action=accept chain=forward comment=\"accept from GRE to local\" \\\
    \r\
    \n    in-interface-list=\"All GRE\" out-interface=bridge-local\r\
    \nadd action=accept chain=forward comment=\"accept from local toGRE\" in-i\
    nterface=\\\r\
    \n    bridge-local out-interface-list=\"All GRE\"\r\
    \nadd action=accept chain=forward comment=\"accept from GRE to GRE\" \\\r\
    \n    in-interface-list=\"All GRE\" out-interface-list=\"All GRE\""
add name=gre-to-list owner=administrator policy=read,write,test source=":local\
    \_gName \"All GRE\";\r\
    \n:log info \"--- Creating interfaces list.. ---\";\r\
    \n:do {\r\
    \n/interface list add name=\$gName\r\
    \n} on-error={ :log error \"List already exist!\"};\r\
    \n:log info \"--- Finding gre interfaces... ---\";\r\
    \n:foreach g in=[/interface gre find] do={\r\
    \n:log info [/interface gre get \$g name];\r\
    \n:do {\r\
    \n/interface list member add interface=\$g list=\$gName;\r\
    \n} on-error={ :log error \"Interface already in list\"};\r\
    \n}\r\
    \n:log info \"--- Creating firewall rules... ---\";\r\
    \n/ip firewall filter\r\
    \nadd action=accept chain=input comment=\"Allow GRE\" log-prefix=an protoc\
    ol=gre\r\
    \nadd action=accept chain=input comment=\"Allow OSPF\" connection-state=ne\
    w \\\r\
    \n    log-prefix=an protocol=ospf\r\
    \nadd action=accept chain=forward comment=\"accept from GRE to local\" \\\
    \r\
    \n    in-interface-list=\"All GRE\" out-interface=bridge-local\r\
    \nadd action=accept chain=forward comment=\"accept from local toGRE\" in-i\
    nterface=\\\r\
    \n    bridge-local out-interface-list=\"All GRE\"\r\
    \nadd action=accept chain=forward comment=\"accept from GRE to GRE\" \\\r\
    \n    in-interface-list=\"All GRE\" out-interface-list=\"All GRE\""
