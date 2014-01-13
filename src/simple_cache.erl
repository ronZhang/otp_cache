%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午8:58
%%%-------------------------------------------------------------------
-module(simple_cache).
-author("ron").

%% API
-export([insert/2,lookup/1,delete/1,load_applications/0]).


insert(Key,Value)->
  case sc_store:lookup(Key) of
    {ok,Pid}->sc_element:replace(Pid,Value);
    {error,_}-> {ok,Pid}=sc_element:create(Value),
     sc_store:insert(Key,Pid)
  end .

lookup(Key)->
  case sc_store:lookup(Key) of

    {ok,Pid} -> {ok,Value}=sc_element:fetch(Pid),
      {ok,Value};
    {_,_} -> {error,not_found}
  end.



delete(Key)->
  case sc_store:lookup(Key) of
    {ok,Pid} ->sc_element:delete(Pid);
    {error,_Reason}-> ok
  end.

load_applications()->
	application:start(log4erl),
	application:start(simple_cache)
.




