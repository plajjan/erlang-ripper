-define(RIP_PACKET,
	<<	_RIP_Command:8,
        _RIP_Version:8,
        _RIP_MustBeZero:16,
        _RIP_Entries/binary >>).

-define(RIP_ENTRY,
	<<	_RIP_Entry_AddressFamily:16,
        _RIP_Entry_RouteTag:16,
        _RIP_Entry_IpAddress:32,
        _RIP_Entry_Netmask:32,
        _RIP_Entry_NextHop:32,
        _RIP_Entry_Metric:32,
        EntryRest/binary >>).

