Network=192.168.122.0/24
Server=10.0.0.40
route -n add -net $Network $Server
