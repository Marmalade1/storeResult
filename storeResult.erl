-module(list).
-compile(export_all).

connect_riak()->
        riakc_pb_socket:start_link("129.16.155.22",8087).

store([H|T])->
	
	case T of
		[]->io:format("done");
		_->
		{ok,Pid} = connect_riak(),
		{K,V} = hd([H|T]),
		Key = list_to_binary(K),
		Value = list_to_binary(integer_to_list(V)),
		Object = riakc_obj:new(<<"result">>,Key,Value),
		riakc_pb_socket:put(Pid, Object),
%		io:format("Key is ~p~n",[K]),
%		io:format("Value is ~p~n",[V]),
		store(T)
		
	end.
	
