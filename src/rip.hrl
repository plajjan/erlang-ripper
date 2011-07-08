-ifndef(RIP_HRL).
-define(RIP_HRL, true).

-include_lib("types.hrl").

-record(rip_packet,{
		command	:: uint8(),
		version	:: uint8(),
		entries	:: [#rip_entry]
	}).

-record(rip_entry,{
		afi		:: uint16(),
		tag		:: uint16(),
		address	:: ipv4_address(),
		netmask	:: ipv4_address(),
		nexthop	:: ipv4_address(),
		metric	:: uint32()
	}).
