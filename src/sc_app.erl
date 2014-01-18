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
-export([load_application/0]).
start(StartType,StartArgument)->
  sc_store:init(),
   error_logger:info_report("cache starting"),
  case  sc_sup:start_link() of
    {ok,PId}-> {ok,PId};
    Other -> {error,Other}
  end
 
.

  stop(State)-> ok .


load_application()->
	application:start(simple_cache).





