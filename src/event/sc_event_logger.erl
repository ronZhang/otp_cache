%% @author ron
%% @doc @todo Add description to sc_event_logger.


-module(sc_event_logger).
-behavior(gen_event).
-record(state,{value=0}).

%% ====================================================================
%% API functions
%% ====================================================================
-export([init/1,
		 handle_call/2,
		 handle_event/2,
		 handle_info/2,
		 code_change/3,
		 terminate/2
		]).

-export([add_handler/0,delete_handler/0]).





init(Argu)->
	{ok,#state{}}.

%% ====================================================================
%% Internal functions
%% ====================================================================

add_handler()->
	sc_event:addHandler(?MODULE,[]).
delete_handler()->
	sc_event:deleteHandler(?MODULE,[]).


handle_event({delete,Key},State)->
	error_logger:info_msg("delete (~w) ~n",[Key]),
	{ok,State};

handle_event({lookup,Key},State)->
	error_logger:info_msg("lookup (~w) ~n",[Key]),
	{ok,State};



handle_event({insert,{Key,Value}},State)->
	error_logger:info_msg("insert (~w,~w) ~n",[Key,Value]),
	{ok,State};


handle_event({replace,{Key,Value}},State)->
	error_logger:info_msg("replace  (~w,~w,~w) ~n",[Key,Value]),
	{ok,State}.



handle_call(Any,State)->
	{reply,{ok},State,0}.

handle_info(Any,State)->
{ok,State}.

code_change(_OldVsn,State,_Exta)->{ok,State}.

terminate(_Reson,_State)->{ok,_State}.
  


