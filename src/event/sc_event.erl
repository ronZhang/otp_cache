%% @author ron
%% @doc @todo Add description to sc_event.


-module(sc_event).
-define(SERVER,?MODULE).
-record(state,{}).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/0,
		 addHandler/2,
		 insert/2,
		 lookup/1,
		 replace/2,
		 delete/1,
		 deleteHandler/2]).



%% ====================================================================
%% Internal functions
%% ====================================================================




start_link()->
	gen_event:start_link({local,?SERVER}).


addHandler(Handler,Args)->
	gen_event:add_handler(?SERVER,Handler,Args).


deleteHandler(Handler,Args)->
	gen_event:delete_handler(?SERVER,Handler,Args).




delete(Key)->
	gen_event:notify(?SERVER,{delete,Key}).

lookup(Key)->
	gen_event:notify(?SERVER,{lookup,Key}).

insert(Key,Value)->
	gen_event:notify(?SERVER,{insert,{Key,Value}}).

replace(Key,Value)->
	gen_event:notify(?SERVER,{replace,{Key,Value}}).
















