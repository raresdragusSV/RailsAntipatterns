# install sphinx search using apt-get

gem install thinking-sphinx

# index your data and run the daemon
rake ts:in
rake ts:start

# using pattern matching
rake ts:stop
rake ts:in
rake ts:start

# using delta_indexes
rake ts:stop
rake ts:in
rake ts:start
