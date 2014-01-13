%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午9:00
%%%-------------------------------------------------------------------
-module(sc_app).
-author("ron").
-behaviour(application).


%% API
-export([start/2,stop/1]).
%%User API
-export([insert/2,delete/1,lookup/1]).

start(StartType,StartArgument)->
  io:format("su_app:start() executing"),
  sc_store:init(),
  case  sc_sup:start_link() of
    {ok,PId}-> {ok,PId};
    Other -> {error,Other}
  end.
  

stop(State)-> ok .


insert(Key,Value)->
  case sc_store:lookup(Key) of
    {ok,Pid} ->  sc_element:replace(Pid,Value);
    {error,not_found}->
      {ok,Pid}=sc_element:create(Value),
      sc_store:insert(Key,Pid)
  end.


lookup(Key)->
   try
     {ok,Pid}=sc_store:lookup(Key),
     {ok,Value}=sc_element:fetch(Pid),
     {ok,Value}
   catch
     _Class:_Exception ->{error,not_found}
   end.


delete(Key)->
   case sc_store:lookup(Key) of
     {ok,Pid} -> sc_element:delete(Pid);
     _ -> ok
   end.










