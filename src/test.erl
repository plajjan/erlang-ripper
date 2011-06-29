-module(test).

-include("records.hrl").

-export([open/2,start/0]).
-export([stop/1,receiver/0]).

fmt(X) ->
    [F|T] = X,
    lists:flatten(io_lib:format(F, T)).

debug(P, X) ->
        io:format("~p> DEBUG ~p ~n", [P,fmt(X)]).

open(Addr,Port) ->
   {ok,S} = gen_udp:open(Port,[{reuseaddr,true}, {ip,Addr}, {multicast_ttl,4}, {multicast_loop,false}, binary]),
   inet:setopts(S,[{add_membership,{Addr,{0,0,0,0}}}]),
   S.

close(S) -> gen_udp:close(S).

start() ->
   S=open({224,0,0,9},520),
   Pid=spawn(?MODULE,receiver,[]),
   gen_udp:controlling_process(S,Pid),
   {S,Pid}.

stop({S,Pid}) ->
   close(S),
   Pid ! stop.

receiver() ->
   receive
       {udp, _Socket, IP, InPortNo, Packet} ->
           parse_packet(Packet),
           io:format("~n~nFrom: ~p~nPort: ~p~nData: ~p~n",[IP,InPortNo,Packet]),
           receiver();
       stop -> true;
       AnythingElse -> io:format("RECEIVED: ~p~n",[AnythingElse]),
           receiver()
   end.

parse_packet(Packet) ->
    ?RIP_PACKET = Packet,
    debug("RIP", ["RIP Command ~p", _RIP_Command]),
    debug("RIP", ["RIP Version ~p", _RIP_Version]),
    debug("RIP", ["RIP Entries ~p", _RIP_Entries]),
    parse_entry(_RIP_Entries),
    ok.

parse_entry(Entries) ->
    ?RIP_ENTRY = Entries,
    debug("RIP Entry", ["  AF ~p", _RIP_Entry_AddressFamily]),
    debug("RIP Entry", ["  Route tag ~p", _RIP_Entry_RouteTag]),
    debug("RIP Entry", ["  IP Address ~p", _RIP_Entry_IpAddress]),
    debug("RIP Entry", ["  netmask ~p", _RIP_Entry_Netmask]),
    debug("RIP Entry", ["  next-hop ~p", _RIP_Entry_NextHop]),
    debug("RIP Entry", ["  metric ~p", _RIP_Entry_Metric]),
    [ok|parse_entry(_RIP_Rest)].

parse_entry_ipv4(Bin) ->
    <<A:8,B:8,C:8,D:8>> = Bin,
    { ipv4, (((256 * A + B) * 256 + C) * 256 + D)}.


