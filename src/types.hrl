-ifndef(TYPES_HRL).
-define(TYPES_HRL, true).

-type uint8() :: 0..256.
-type uint16() :: 0..65535.
-type uint32() :: 0..4294967295.
-type ipv4_address() :: {byte(), byte(), byte(), byte()}.
-type ipv6_address() :: {byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte(), byte()}.
-type ipv4_prefix_len() :: 0..32.
-type ipv6_prefix_len() :: 0..128.
-type ipv4_prefix() :: {uint32(), prefix_len()}.
-type rib() :: dict().

-endif.
