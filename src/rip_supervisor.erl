-module(rip_supervisor).
-behaviour(supervisor).

-export([start/0,
		interactive/0,
		start_link/1,
		init/1]).


% Start "as daemon"
start() ->
	spawn(fun() ->
			supervisor:start_link({local, ?MODULE}, ?MODULE, _Arg = [])
		end).

% Interactive mode
interactive() ->
	{ok, Pid} = supervisor:start_link({local, ?MODULE}, ?MODULE, _Arg = []),
	unlink(Pid).

start_link(Args) ->
	supervisor:start_link({local, ?$MODULE}, ?MODULE, Args).

init([]) ->
	ok.
