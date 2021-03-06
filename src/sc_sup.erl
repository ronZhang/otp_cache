%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午8:59
%%%-------------------------------------------------------------------
-module(sc_sup).
-author("ron").
-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([init/1]).

start_link()->
     supervisor:start_link({local,?MODULE},?MODULE,[]).

init([])->
  Element={
    sc_element_sup,
    {sc_element_sup,start_link,[]},
    permanent,
	2000,
    worker,
    [sc_element_sup]
  },
  Event={sc_event,
		 {sc_event,start_link,[]},
		 permanent,
		 2000,
		 worker,
		 [sc_event]
		 },
  
  
  
  Child=[Element,Event],
  Strategy={one_for_one,4,36000},
  {ok,{Strategy,Child}}
.



