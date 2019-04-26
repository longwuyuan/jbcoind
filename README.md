# jbcoind
Dockerization of https://github.com/JBcoin-JBC/JBcoin


- TCP port 5005 and UDP port 50235 mapped exposed and mapped to same host ports

- Look in Dockerfile for other exposed ports as firewall needs to be opened for peer connection and client connection

- TODO - Add prometheus for exporting metrics

- TODO - Storage configuration for persistence of any data

- TODO - Fix `CMAKE_INSTALL_PREFIX` not working. Did not work for me yet.


```
2019-Apr-26 04:42:22.656035473 ValidatorList:WRN New quorum of 18446744073709551615 exceeds the number of trusted validators (0)
2019-Apr-26 04:42:22.656045527 LedgerConsensus:NFO Entering consensus process, watching, synced=yes
2019-Apr-26 04:42:22.656055114 LedgerConsensus:NFO Consensus mode change before=observing, after=observing
2019-Apr-26 04:42:28.018195888 ValidatorSite:WRN Request for validator list at https://vl.jbcoin.io returned bad status: 403
2019-Apr-26 04:42:38.718654088 Application:NFO Transaction DB pathname: /var/lib/jbcoind/db/transaction.db; file size: 4096 bytes; SQLite page size: 4096 bytes; Free pages: 2147483638; Free space: 8796092981248 bytes; Note that this does not take into account available disk space.
2019-Apr-26 04:42:42.661544188 LedgerConsensus:NFO Converge cutoff (0 participants)
2019-Apr-26 04:42:42.662000189 LedgerConsensus:NFO CNF buildLCL DF53165F9BE63CC2F8A1D2A31C2679A36D81E5B5B9BC94750EDC7D05A4603F9E
2019-Apr-26 04:42:42.662070458 LedgerConsensus:NFO We closed at 609568960
2019-Apr-26 04:42:42.662091136 LedgerConsensus:NFO Our close offset is estimated at 0 (1)
2019-Apr-26 04:42:42.662122427 NetworkOPs:NFO Consensus time for #313 with LCL DF53165F9BE63CC2F8A1D2A31C2679A36D81E5B5B9BC94750EDC7D05A4603F9E
2019-Apr-26 04:42:42.662142996 ValidatorList:WRN New quorum of 18446744073709551615 exceeds the number of trusted validators (0)
2019-Apr-26 04:42:42.662172515 LedgerConsensus:NFO Entering consensus process, watching, synced=yes
2019-Apr-26 04:42:42.662183291 LedgerConsensus:NFO Consensus mode change before=observing, after=observing
2019-Apr-26 04:42:58.105065117 ValidatorSite:WRN Request for validator list at https://vl.jbcoin.io returned bad status: 403
2019-Apr-26 04:43:02.667081464 LedgerConsensus:NFO Converge cutoff (0 participants)
2019-Apr-26 04:43:02.667440655 LedgerConsensus:NFO CNF buildLCL 09800E7F1B5AF670D561FAA3BBC8E847FD8D14C41E2CD20F4A1012EE0C505FAF
2019-Apr-26 04:43:02.667494195 LedgerConsensus:NFO We closed at 609568980
2019-Apr-26 04:43:02.667504675 LedgerConsensus:NFO Our close offset is estimated at 0 (1)
2019-Apr-26 04:43:02.667530404 NetworkOPs:NFO Consensus time for #314 with LCL 09800E7F1B5AF670D561FAA3BBC8E847FD8D14C41E2CD20F4A1012EE0C505FAF

```

```

root@jbcoind:~/jbcoind# docker exec -ti jbcoind bash
root@b2d98cccd677:~# cd jbcoin/my_build/
root@b2d98cccd677:~/jbcoin/my_build# ls   
CMakeCache.txt             Makefile             jbcoind             libjbcl_core.a  librocksdb.a    libsoci.a     proto_gen
CMakeFiles                 cmake_install.cmake  jbcoind.cfg         liblz4.a        libsecp256k1.a  libsqlite3.a  sqlite3
JBCoinConfigVersion.cmake  db                   libed25519-donna.a  libpbufs.a      libsnappy.a     lz4           validators.txt
root@b2d98cccd677:~/jbcoin/my_build# jbcoind server_info | grep seq
bash: jbcoind: command not found
root@b2d98cccd677:~/jbcoin/my_build# ./jbcoind server_info | grep seq
Loading: "/root/jbcoin/my_build/jbcoind.cfg"
2019-Apr-26 04:48:06.281628850 HTTPClient:NFO Connecting to 127.0.0.1:15005

            "seq" : 328
root@b2d98cccd677:~/jbcoin/my_build# ./jbcoind server_info | grep ledger
Loading: "/root/jbcoin/my_build/jbcoind.cfg"
2019-Apr-26 04:48:16.517620745 HTTPClient:NFO Connecting to 127.0.0.1:15005

         "closed_ledger" : {
         "complete_ledgers" : "empty",
         "published_ledger" : "none",
root@b2d98cccd677:~/jbcoin/my_build# 


```
