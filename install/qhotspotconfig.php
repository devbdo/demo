global $config;
$config = parse_config(true);
$eapconf = &$config['installedpackages']['freeradiuseapconf']['config'][0];
// Cron Ekleme
if (!array_search("/usr/local/bin/boxnet_check.sh", array_column($config['cron']['item'], "command"))) {
    $config['cron']['item'][] = array(
        "minute" => "*/1",
        "hour" => "*",
        "mday" => "*",
        "month" => "*",
        "wday" => "*",
        "who" => "root",
        "command" => "/usr/local/bin/boxnet_check.sh"
    );

    $config['cron']['item'][] = array(
        "minute" => "*/1",
        "hour" => "*",
        "mday" => "*",
        "month" => "*",
        "wday" => "*",
        "who" => "root",
        "command" => "/usr/local/bin/php /usr/local/boxnet/public/Runtime/netGrupCheck.php"
    );

    $config['cron']['item'][] = array(
        "minute" => "*/1",
        "hour" => "*",
        "mday" => "*",
        "month" => "*",
        "wday" => "*",
        "who" => "root",
        "command" => "/usr/local/bin/php /usr/local/boxnet/public/Runtime/netCheck.php"
    );

    $config['cron']['item'][] = array(
        "minute" => "*/5",
        "hour" => "*",
        "mday" => "*",
        "month" => "*",
        "wday" => "*",
        "who" => "root",
        "command" => "/usr/local/bin/php /usr/local/boxnet/public/Runtime/Entegre.php"
    );
    $config['cron']['item'][] = array(
        "minute" => "59",
        "hour" => "23",
        "mday" => "*",
        "month" => "*",
        "wday" => "*",
        "who" => "root",
        "command" => " /sbin/5651Imzala.sh"
    );

    write_config("Boxnet Check Cron added.");
}

// Variables: EAP
$eapconf['vareapconfdefaulteaptype'] = 'md5';
$eapconf['vareapconftimerexpire'] = '60';
$eapconf['vareapconfignoreunknowneaptypes'] = 'no';
$eapconf['vareapconfciscoaccountingusernamebug'] = 'no';
$eapconf['vareapconfmaxsessions'] = '4096';
// Variables: EAP-TLS
$eapconf['vareapconffragmentsize'] = '1024';
$eapconf['vareapconfincludelength'] = 'yes';
$eapconf['vareapconfcountry'] = 'US';
$eapconf['vareapconfstate'] = 'Texas';
$eapconf['vareapconfcity'] = 'Austin';
$eapconf['vareapconforganization'] = 'My Company Ltd';
$eapconf['vareapconfemail'] = 'admin@mycompany.com';
$eapconf['vareapconfcommonname'] = 'internal-ca';
// Variables: Cache
$eapconf['vareapconfcacheenablecache'] = 'no';
$eapconf['vareapconfcachelifetime'] = '24';
$eapconf['vareapconfcachemaxentries'] = '255';
// Variables OSCP
$eapconf['vareapconfocspenable'] = 'no';
$eapconf['vareapconfocspoverridecerturl'] = 'no';
$eapconf['vareapconfocspurl'] = 'http://127.0.0.1/ocsp/';
// Variables: EAP-TTLS
$eapconf['vareapconfttlsdefaulteaptype'] = 'md5';
$eapconf['vareapconfttlscopyrequesttotunnel'] = 'no';
$eapconf['vareapconfttlsusetunneledreply'] = 'no';
$eapconf['vareapconfttlsincludelength'] = 'yes';
// Variables: EAP-PEAP with MSCHAPv2
$eapconf['vareapconfpeapdefaulteaptype'] = 'mschapv2';
$eapconf['vareapconfpeapcopyrequesttotunnel'] = 'no';
$eapconf['vareapconfpeapusetunneledreply'] = 'no';
$eapconf['vareapconfpeapsohenable'] = 'Disable';
write_config("EAP Config");


$freeradiusclients = [
    'varclientip' => $config["interfaces"]["lan"]["ipaddr"],
    'varclientipversion' => "ipaddr",
    'varclientshortname' => "BOXNET",
    'varclientsharedsecret' => "boxnet",
    'varclientproto' => "udp",
    'varclientnastype' => "other",
    'varrequiremessageauthenticator' => "no",
    'varclientmaxconnections' => 16,
    'varclientlogininput' => null,
    'varclientpasswordinput' => null,
    'description' => null,
];

$freeradiusinterfaces0 = [
    'varinterfaceip' => "*",
    'varinterfaceport' => 1812,
    'varinterfacetype' => "auth",
    'varinterfaceipversion' => "ipaddr",
    'description' => null,
];

$freeradiusinterfaces1 = [
    'varinterfaceip' => "*",
    'varinterfaceport' => 1813,
    'varinterfacetype' => "acct",
    'varinterfaceipversion' => "ipaddr",
    'description' => null,
];

$freeradiussettings = [
    "varsettingsmaxrequests" => 1024,
    "varsettingsmaxrequesttime" => 30,
    "varsettingscleanupdelay" => 5,
    "varsettingsallowcoredumps" => "no",
    "varsettingsregularexpressions" => "yes",
    "varsettingsextendedexpressions" => "yes",
    "varsettingslogdir" => "syslog",
    "varsettingsauth" => "yes",
    "varsettingsauthbadpass" => "no",
    "varsettingsauthbadpassmessage" => null,
    "varsettingsauthgoodpass" => "no",
    "varsettingsauthgoodpassmessage" => null,
    "varsettingsstrippednames" => "no",
    "varsettingshostnamelookups" => "no",
    "varsettingsmaxattributes" => 200,
    "varsettingsrejectdelay" => 1,
    "varsettingsstartservers" => 5,
    "varsettingsmaxservers" => 32,
    "varsettingsminspareservers" => 3,
    "varsettingsmaxspareservers" => 10,
    "varsettingsmaxqueuesize" => 65536,
    "varsettingsmaxrequestsperserver" => 0,
    "varsettingsmotpenable" => null,
    "varsettingsmotptimespan" => null,
    "varsettingsmotppasswordattempts" => null,
    "varsettingsmotpchecksumtype" => "md5",
    "varsettingsmotptokenlength" => null,
    "varsettingsenablemacauth" => null,
    "varsettingsenableacctunique" => null,
];

$freeradiussqlconf = [
    "varsqlconfincludeenable" => "on",
    "varsqlconfenableauthorize" => "Enable",
    "varsqlconfenableaccounting" => "Enable",
    "varsqlconfenablesession" => "Enable",
    "varsqlconfenablepostauth" => "Enable",
    "varsqlconfdatabase" => "mysql",
    "varsqlconfserver" => "localhost",
    "varsqlconfport" => 3306,
    "varsqlconflogin" => "{QH_MYSQL_USER_NAME}",
    "varsqlconfpassword" => "{QH_MYSQL_USER_PASS}",
    "varsqlconfradiusdb" => "{QH_MYSQL_DBNAME}",
    "varsqlconfaccttable1" => "radacct",
    "varsqlconfaccttable2" => "radacct",
    "varsqlconfpostauthtable" => "radpostauth",
    "varsqlconfauthchecktable" => "radcheck",
    "varsqlconfauthreplytable" => "radreply",
    "varsqlconfgroupchecktable" => "radgroupcheck",
    "varsqlconfgroupreplytable" => "radgroupreply",
    "varsqlconfusergrouptable" => "radusergroup",
    "varsqlconfreadgroups" => "yes",
    "varsqlconfdeletestalesessions" => "yes",
    "varsqlconfsqltrace" => "no",
    "varsqlconfnumsqlsocks" => 5,
    "varsqlconfconnectfailureretrydelay" => "60",
    "varsqlconflifetime" => 0,
    "varsqlconfmaxqueries" => 0,
    "varsqlconfreadclients" => "no",
    "varsqlconfnastable" => "nas",
    "varsqlconf2failover" => "redundant",
    "varsqlconf2includeenable" => null,
    "varsqlconf2enableauthorize" => "Disable",
    "varsqlconf2enableaccounting" => "Disable",
    "varsqlconf2enablesession" => "Disable",
    "varsqlconf2enablepostauth" => "Disable",
    "varsqlconf2database" => "mysql",
    "varsqlconf2server" => null,
    "varsqlconf2port" => null,
    "varsqlconf2login" => null,
    "varsqlconf2password" => null,
    "varsqlconf2radiusdb" => null,
    "varsqlconf2accttable1" => null,
    "varsqlconf2accttable2" => null,
    "varsqlconf2postauthtable" => null,
    "varsqlconf2authchecktable" => null,
    "varsqlconf2authreplytable" => null,
    "varsqlconf2groupchecktable" => null,
    "varsqlconf2groupreplytable" => null,
    "varsqlconf2usergrouptable" => null,
    "varsqlconf2readgroups" => "yes",
    "varsqlconf2deletestalesessions" => "yes",
    "varsqlconf2sqltrace" => "no",
    "varsqlconf2numsqlsocks" => null,
    "varsqlconf2connectfailureretrydelay" => null,
    "varsqlconf2lifetime" => null,
    "varsqlconf2maxqueries" => null,
    "varsqlconf2readclients" => "yes",
    "varsqlconf2nastable" => null,
];

$captiveportal = [
    "zone" => "{QH_ZONE_NAME}",
    "descr" => "Boxnet Captive Portal",
    "zoneid" => 1,
    "interface" => "lan",
    "maxproc" => null,
    "timeout" => null,
    "idletimeout" => null,
    "freelogins_count" => null,
    "freelogins_resettimeout" => null,
    "enable" => null,
    "auth_method" => "radius",
    "radacct_enable" => null,
    "reauthenticateacct" => "stopstartfreeradius",
    "httpsname" => null,
    "preauthurl" => null,
    "blockedmacsurl" => null,
    "bwdefaultdn" => null,
    "bwdefaultup" => null,
    "certref" => $config["cert"][0]["refid"],
    "radius_protocol" => "PAP",
    "redirurl" => "https://www.google.com.tr",
    "radiusip" => $config["interfaces"]["lan"]["ipaddr"],
    "radiusip2" => null,
    "radiusip3" => null,
    "radiusip4" => null,
    "radiusport" => "1812",
    "radiusport2" => null,
    "radiusport3" => null,
    "radiusport4" => null,
    "radiusacctport" => "1813",
    "radiuskey" => "boxnet",
    "radiuskey2" => null,
    "radiuskey3" => null,
    "radiuskey4" => null,
    "radiusvendor" => "default",
    "radiussrcip_attribute" => "wan",
    "radmac_format" => "default",
    "radiusnasid" => null,
    "page" => null,
	"auth_server" => "radius - LocalRadius",
	"radacct_server" => "LocalRadius"
];

$testuser = [
    "sortable" => null,
    "varusersusername" => "test",
    "varuserspassword" => "test",
    "varuserspasswordencryption" => "Cleartext-Password",
    "varusersmotpenable" => null,
    "varusersmotpinitsecret" => null,
    "varusersmotppin" => null,
    "varusersmotpoffset" => null,
    "varuserswisprredirectionurl" => null,
    "varuserssimultaneousconnect" => null,
    "description" => null,
    "varusersframedipaddress" => null,
    "varusersframedipnetmask" => null,
    "varusersframedroute" => null,
    "varusersvlanid" => null,
    "varusersexpiration" => null,
    "varuserssessiontimeout" => null,
    "varuserslogintime" => null,
    "varusersamountoftime" => null,
    "varuserspointoftime" => "Daily",
    "varusersmaxtotaloctets" => null,
    "varusersmaxtotaloctetstimerange" => "daily",
    "varusersmaxbandwidthdown" => null,
    "varusersmaxbandwidthup" => null,
    "varusersacctinteriminterval" => null,
    "varuserstopadditionaloptions" => null,
    "varuserscheckitemsadditionaloptions" => null,
    "varusersreplyitemsadditionaloptions" => null,
];

$config["installedpackages"]["freeradiusclients"] =
    ["config" =>
        [
            "0" => $freeradiusclients
        ]
    ];

$config["installedpackages"]["freeradiusinterfaces"] =
    ["config" =>
        [
            "0" => $freeradiusinterfaces0,
            "1" => $freeradiusinterfaces1
        ]
    ];

$config["installedpackages"]["freeradiussettings"] =
    ["config" =>
        [
            "0" => $freeradiussettings
        ]
    ];
$config["installedpackages"]["freeradiussqlconf"] =
    ["config" =>
        [
            "0" => $freeradiussqlconf
        ]
    ];

$config["installedpackages"]["freeradius"] =
    ["config" =>
        [
            "0" => $testuser
        ]
    ];

$config["captiveportal"]["boxnet"] = $captiveportal;

$sqlconf = <<<EOF

sql sql1 {
	database = "mysql"
	driver = "rlm_sql_\${database}"
	dialect = "\${database}"
	server = "localhost"
	port = 3306
	login = "{QH_MYSQL_USER_NAME}"
	password = "{QH_MYSQL_USER_PASS}"
	radius_db = "{QH_MYSQL_DBNAME}"
	acct_table1 = "radacct"
	acct_table2 = "radacct"
	postauth_table = "radpostauth"
	authcheck_table = "radcheck"
	authreply_table = "radreply"
	groupcheck_table = "radgroupcheck"
	groupreply_table = "radgroupreply"
	usergroup_table = "radusergroup"
	read_groups = yes
	delete_stale_sessions = yes
	logfile = \${logdir}/sqltrace.sql
	read_clients = no
	client_table = "nas"
	pool {
		start = \${thread[pool].start_servers}
		min = \${thread[pool].min_spare_servers}
		max = 5
		spare = \${thread[pool].max_spare_servers}
		uses = 0
		retry_delay = 60
		lifetime = 0
		idle_timeout = 60
	}
	group_attribute = "\${.:instance}-SQL-Group"
	\$INCLUDE \${modconfdir}/\${.:name}/main/\${dialect}/queries.conf
}
EOF;
file_put_contents("/usr/local/etc/raddb/mods-enabled/sql", $sqlconf);
$lanip = $config["interfaces"]["lan"]["ipaddr"];
$clientsconf = <<<EOF

client "BOXNET" {
	ipaddr = $lanip
	proto = udp
	secret = 'boxnet'
	require_message_authenticator = no
	nas_type = other
	### login = !root ###
	### password = someadminpass ###
	limit {
		max_connections = 16
		lifetime = 0
		idle_timeout = 30
	}
}
EOF;
file_put_contents("/usr/local/etc/raddb/clients.conf", $clientsconf);

$s_mysql = false;
foreach ($config['installedpackages']['service'] as $item) {
    if ('mysql-server' == $item['name']) {
        $s_mysql = true;
        break;
    }
}
if ($s_mysql == false) {
    $config['installedpackages']['service'][] = array(
        'name' => 'mysql-server',
        'rcfile' => 'mysql-server.sh',
        'executable' => 'mysqld',
        'description' => 'MySQL Database Server'
    );
}

$s_boxnet = false;
$status_command = <<<EOF
        \$output=''; exec('/bin/pgrep -anf \'.*BOXNET\.conf.*\'', \$output, \$retval); \$rc=(intval(\$retval) == 0)
EOF;

foreach ($config['installedpackages']['service'] as $item) {
    if ('boxnet' == $item['name']) {
        $s_boxnet = true;
    }
}
if ($s_boxnet == false) {
    $config['installedpackages']['service'][] = array(
        'name' => 'boxnet',
        'rcfile' => 'boxnet.sh',
        'executable' => 'boxnet',
        'custom_php_service_status_command' => $status_command,
        'description' => 'Boxnet Manager Web Console'
    );
}

if (!preg_match("/captive_portal_status/", $config['widgets']['sequence'])) {
    $config['widgets']['sequence'] = $config['widgets']['sequence'] . ",captive_portal_status:col2:open";
}

if (!preg_match("/services_status/", $config['widgets']['sequence'])) {
    $config['widgets']['sequence'] = $config['widgets']['sequence'] . ",services_status:col2:open";
}

$config['system']['authserver'][] = array(
	'refid' => '5bf588f9489a4',
	'type' => 'radius',
	'name' => 'LocalRadius',
	'radius_protocol' => 'PAP',
	'host' => $lanip,
	'radius_nasip_attribute' => 'wan',
	'radius_secret' => 'boxnet',
	'radius_timeout' => '5',
	'radius_auth_port' => '1812',
	'radius_acct_port' => '1813',
);
        $config['system']['hostname']     = 'firewall';
        $config['system']['domain']       = 'boxnet.com.tr';
        $config['system']['timezone']     = 'Asia/Istanbul';
        $config['system']['timeservers']  = 'time.ume.tubitak.gov.tr';
        $config['system']['dnsserver'][0]= '195.175.39.39';
        $config['system']['dns1gw']      = 'WAN_DHCP';
        $config['system']['dnsserver'][1]= '195.175.39.40';
        $config['system']['dns2gw']      = 'WAN_DHCP';
        $config['system']['user'][0]['password'] = '$1$suqhTpY.$Qz5QSc.GjPTBhuD9IxkN6/';
        $config['system']['user'][0]['md5-hash'] = '0989f70b054c011cc0ef55a3100c4435';                                         
        $config['system']['user'][0]['nt-hash'] = '263d56c673bc2cfd940e8ea764e697291c70185e27984b720fdd882cafec5ac7';
        $config['system']['user'][1]['name']     = 'boxnet';
	    $config['system']['user'][1]['descr']    = 'Boxnet Administrator';
	    $config['system']['user'][1]['password'] = '$1$kS8YI/CW$XLUjWcqJ8vvFkQBbrDuXr/';
	    $config['system']['user'][1]['md5-hash'] = '69a6de5c266e35e21e53f3c8aab0f1d1';
	    $config['system']['user'][1]['nt-hash']  = '9dd905df9a215b2291dff21f7c3539f08ec06c2ab3b837660595ff89726ebc51';
	    $config['system']['user'][1]['scope']    = 'system';
	    $config['system']['user'][1]['uid']      = '1000';
	    $config['system']['user'][1]['priv'][] = 'page-dashboard-all';
	    $config['system']['user'][1]['priv'][] = 'page-system-login/logout';
	    $config['system']['user'][1]['priv'][] = 'user-services-captiveportal-login';
	    $config['system']['user'][1]['priv'][] = 'page-dashboard-widgets';
	    $config['system']['user'][1]['priv'][] = 'page-diag-system-activity';
	    $config['system']['user'][1]['priv'][] = 'page-diagnostics-arptable';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-authentication';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-cpuutilization';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-haltsystem';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-interfacetraffic';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-dhcp';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-firewall';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-gateways';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-pptpvpn';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-resolver';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-system';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-logs-wireless';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-ping';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-rebootsystem';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-resetstate';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-routingtables';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-showstates';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-sockets';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-statessummary';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-traceroute';
		$config['system']['user'][1]['priv'][] = 'page-diagnostics-wirelessstatus';
		$config['system']['user'][1]['priv'][] = 'page-firewall-alias-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-alias-import';
		$config['system']['user'][1]['priv'][] = 'page-firewall-aliases';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-1-1';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-1-1-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-outbound';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-outbound-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-portforward';
		$config['system']['user'][1]['priv'][] = 'page-firewall-nat-portforward-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-rules';
		$config['system']['user'][1]['priv'][] = 'page-firewall-rules-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-schedules';
		$config['system']['user'][1]['priv'][] = 'page-firewall-schedules-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-trafficshaper';
		$config['system']['user'][1]['priv'][] = 'page-firewall-trafficshaper-layer7';
		$config['system']['user'][1]['priv'][] = 'page-firewall-trafficshaper-limiter';
		$config['system']['user'][1]['priv'][] = 'page-firewall-trafficshaper-queues';
		$config['system']['user'][1]['priv'][] = 'page-firewall-trafficshaper-wizard';
		$config['system']['user'][1]['priv'][] = 'page-firewall-virtualipaddress-edit';
		$config['system']['user'][1]['priv'][] = 'page-firewall-virtualipaddresses';
		$config['system']['user'][1]['priv'][] = 'page-getserviceproviders';
		$config['system']['user'][1]['priv'][] = 'page-getstats';
		$config['system']['user'][1]['priv'][] = 'page-openvpn-client';
		$config['system']['user'][1]['priv'][] = 'page-openvpn-csc';
		$config['system']['user'][1]['priv'][] = 'page-openvpn-server';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-allowedhostnames';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-allowedips';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-editallowedhostnames';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-editallowedips';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-editmacaddresses';
		$config['system']['user'][1]['priv'][] = 'page-services-captiveportal-filemanager';
		$config['system']['user'][1]['priv'][] = 'page-services-dhcprelay';
		$config['system']['user'][1]['priv'][] = 'page-services-dhcprelay6';
		$config['system']['user'][1]['priv'][] = 'page-services-dhcpserver';
		$config['system']['user'][1]['priv'][] = 'page-services-dhcpserver-editstaticmapping';
		$config['system']['user'][1]['priv'][] = 'page-services-wakeonlan';
		$config['system']['user'][1]['priv'][] = 'page-services-wakeonlan-edit';
		$config['system']['user'][1]['priv'][] = 'page-status-captiveportal';
		$config['system']['user'][1]['priv'][] = 'page-status-cpuload';
		$config['system']['user'][1]['priv'][] = 'page-status-dhcpleases';
		$config['system']['user'][1]['priv'][] = 'page-status-gateways';
		$config['system']['user'][1]['priv'][] = 'page-status-interfaces';
		$config['system']['user'][1]['priv'][] = 'page-status-openvpn';
		$config['system']['user'][1]['priv'][] = 'page-status-services';
		$config['system']['user'][1]['priv'][] = 'page-status-systemlogs-portalauth';
		$config['system']['user'][1]['priv'][] = 'page-status-trafficgraph';
		$config['system']['user'][1]['priv'][] = 'page-system-gateways';
		$config['system']['user'][1]['priv'][] = 'page-system-generalsetup';
		$config['system']['user'][1]['priv'][] = 'page-system-license';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec-editkeys';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec-editphase1';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec-editphase2';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec-listkeys';
		$config['system']['user'][1]['priv'][] = 'page-vpn-ipsec-mobile';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnl2tp';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnl2tp-users';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnl2tp-users-edit';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnpptp';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnpptp-user-edit';
		$config['system']['user'][1]['priv'][] = 'page-vpn-vpnpptp-users';
		$config['system']['user'][1]['priv'][] = 'page-xmlrpcinterfacestats';
		$config['system']['user'][1]['priv'][] = 'page-xmlrpclibrary';
		$config['system']['user'][1]['priv'][] = 'page-interfaces';
		$config['system']['user'][1]['priv'][] = 'page-status-rrdgraph-settings';
		$config['system']['user'][1]['priv'][] = 'page-status-rrdgraphs';
		$config['system']['user'][1]['priv'][] = 'page-services-dnsforwarder';
		$config['system']['user'][1]['priv'][] = 'page-services-dnsforwarder-editdomainoverride';
		$config['system']['user'][1]['priv'][] = 'page-services-dnsforwarder-edithost';
	    

write_config("Boxnet Settings added.");