%%%-------------------------------------------------------------------
%%% @author ron
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 十二月 2013 下午9:00
%%%-------------------------------------------------------------------
-module(sc_store).
-author("ron").

%% API
-export([init/0,
  insert/2,
  delete/1,
  lookup/1]).


-define(TABLE_ID,?MODULE).

init()->ets:new(?TABLE_ID,[public,named_table]),
  ok.

insert(Key,Pid)->ets:insert(?TABLE_ID,{Key,Pid}).


delete(Pid)->ets:match_delete(?TABLE_ID,{'_',Pid}).


lookup(Key)->
  case  ets:lookup(?TABLE_ID,Key) of

    [{Key,Pid}] -> {ok,Pid};
    [] -> {error,not_found}
  end.







