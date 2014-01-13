%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午9:00
%%%-------------------------------------------------------------------
-module(sc_element).
-author("ron").
-behaviour(gen_server).

%% API
-export([start_link/2,
        create/2,
        create/1,
        fetch/1,
        replace/2,
        delete/1]).



-export([init/1,
handle_call/3,
handle_cast/2,
handle_info/2,
terminate/2,
code_change/3]).


-define(SERVER,?MODULE).
-define(DEFAULT_LEAST_TIME,60*60*24).
-record(state,{value,least_time,start_time}).


start_link(Value,LeastTime)->
   gen_server:start_link(?MODULE,[Value,LeastTime],[]).


%%提供给外部的API
create(Value,LeastTime)->
  sc_sup:start_child(Value,LeastTime).


create(Value)->
  sc_sup:start_child(Value,?DEFAULT_LEAST_TIME).


fetch(Pid)->gen_server:call([Pid,fetch]).



replace(Pid,Value)->gen_server:cast(Pid,[replace,Value]).


delete(Pid)->gen_server:cast(Pid,delete).




%%gen_server 回调代码
init([Value,LeastTime])->
  Now=calendar:local_time(),
  StartTime=calendar:datetime_to_gregorian_seconds(Now),
  {ok,
    #state{value =Value,least_time = LeastTime,start_time = StartTime}
    ,time_left(StartTime,LeastTime)}
 .


time_left(StartTime,LeastTime)->
  Now=calendar:local_time(),
  Current=calendar:datetime_to_gregorian_seconds(Now),
  TimeEla=Current-StartTime,
  case  LeastTime -TimeEla of
    Time when Time =<0 -> 0;
    Time -> Time *1000
  end;

time_left(_Start,infinity)->infinity.

handle_call(fetch,_Form,State)->
  #state{value =Value,least_time = LeastTime,start_time =StartTime}=State,
  TimeLeft=time_left(StartTime,LeastTime),
  {reply,{ok,Value},State,TimeLeft}.


handle_cast({replace,Value},State)->
  #state{least_time = LeastTime,start_time = StartTime}=State,
  TimeLeft=time_left(StartTime,LeastTime),
  {noreply,State#state{value = Value},TimeLeft};

handle_cast(delete,State)->{stop,normal,State}.


handle_info(timeout,State)->{stop,normal,State}.


terminate(_Reson,_State)->sc_store:delete(self()).

code_change(_OldVsn,State,_Exta)->{ok,State}.







































