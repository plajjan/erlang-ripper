-module(client).
-export([send/3, start/0]).

start() ->
	Port = 520,
	Addr = {224,0,0,9},
	{ok, Socket} = gen_udp:open(Port, [binary, inet]),
	send(Socket, Port, Addr).

send(Socket, Port, Addr) ->
	Packet = [
		% "header"
		2, % command
		2, % version
		0, 0, % must be zero
		% RIP entry
		0, 2, % Address family
		0, 0, % route tag
		10, 0, 0, 0, % address
		255, 0, 0, 0, % mask
		192, 168, 1, 27, % next hop
		0, 0, 0, 2 % metric
		],
	gen_udp:send(Socket, Addr, Port, Packet),
	gen_udp:close(Socket).
