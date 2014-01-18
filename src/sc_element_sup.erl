%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午8:59
%%%-------------------------------------------------------------------
-module(sc_element_sup).
-author("ron").
-behaviour(supervisor).

%% API
-export([start_link/0,start_child/2]).
-export([init/1]).

start_link()->
     supervisor:start_link({local,?MODULE},?MODULE,[]).

start_child(Value,LastTime)->
  supervisor:start_child(?MODULE,[Value,LastTime]).


init([])->
  Element={
    sc_element,
    {sc_element,start_link,[]},
    temporary,
    brutal_kill,
    worker,
    [sc_element]
  },
  Child=[Element],
  Strategy={simple_one_for_one,0,1},
  {ok,{Strategy,Child}}
.



