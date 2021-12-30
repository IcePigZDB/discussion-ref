mysql> SELECT table_name, table_id, index_name, index_id, region_id, count(region_id) FROM INFORMATION_SCHEMA.TIDB_HOT_REGIONS_HISTORY
    -> WHERE update_time >'2021-08-18 21:40:00' and update_time <'2022-09-19 00:00:00'
    -> group by region_id, table_name, table_id, index_name, index_id order by region_id, index_name;
# 因为跑了3组 sysbench 命令，总共对同一批 region 热了3次，所以 count 为3，次结果与 TIKV_REGION_STATUS 的解析结果一致，每个 region 都包含一个 table 和一个 index。
+------------+----------+------------+----------+-----------+------------------+
| table_name | table_id | index_name | index_id | region_id | count(region_id) |
+------------+----------+------------+----------+-----------+------------------+
| SBTEST5    |       59 | NULL       |     NULL |        83 |                3 |
| SBTEST5    |       59 | K_5        |        1 |        83 |                3 |
| SBTEST3    |       62 | NULL       |     NULL |        85 |                3 |
| SBTEST3    |       62 | K_3        |        1 |        85 |                3 |
| SBTEST6    |       61 | NULL       |     NULL |        87 |                3 |
| SBTEST6    |       61 | K_6        |        1 |        87 |                3 |
| SBTEST8    |       63 | NULL       |     NULL |        89 |                3 |
| SBTEST8    |       63 | K_8        |        1 |        89 |                3 |
| SBTEST4    |       68 | NULL       |     NULL |        91 |                3 |
| SBTEST4    |       68 | K_4        |        1 |        91 |                3 |
| SBTEST7    |       69 | NULL       |     NULL |        93 |                3 |
| SBTEST7    |       69 | K_7        |        1 |        93 |                3 |
| SBTEST1    |       73 | NULL       |     NULL |        95 |                3 |
| SBTEST1    |       73 | K_1        |        1 |        95 |                3 |
| SBTEST2    |       75 | NULL       |     NULL |       100 |                3 |
| SBTEST2    |       75 | K_2        |        1 |       100 |                3 |
| SBTEST13   |       83 | NULL       |     NULL |       103 |                3 |
| SBTEST13   |       83 | K_13       |        1 |       103 |                3 |
| SBTEST16   |       86 | NULL       |     NULL |       105 |                3 |
| SBTEST16   |       86 | K_16       |        1 |       105 |                3 |
| SBTEST14   |       88 | NULL       |     NULL |       107 |                3 |
| SBTEST14   |       88 | K_14       |        1 |       107 |                3 |
| SBTEST11   |       92 | NULL       |     NULL |       110 |                3 |
| SBTEST11   |       92 | K_11       |        1 |       110 |                3 |
| SBTEST12   |       95 | NULL       |     NULL |       114 |                3 |
| SBTEST12   |       95 | K_12       |        1 |       114 |                3 |
| SBTEST15   |       98 | NULL       |     NULL |       117 |                3 |
| SBTEST15   |       98 | K_15       |        1 |       117 |                3 |
| SBTEST9    |      101 | NULL       |     NULL |       119 |                3 |
| SBTEST9    |      101 | K_9        |        1 |       119 |                3 |
| SBTEST10   |      104 | NULL       |     NULL |       122 |                3 |
| SBTEST10   |      104 | K_10       |        1 |       122 |                3 |
| SBTEST21   |      107 | NULL       |     NULL |       125 |                3 |
| SBTEST21   |      107 | K_21       |        1 |       125 |                3 |
| SBTEST24   |      110 | NULL       |     NULL |       127 |                3 |
| SBTEST24   |      110 | K_24       |        1 |       127 |                3 |
| SBTEST22   |      113 | NULL       |     NULL |       130 |                3 |
| SBTEST22   |      113 | K_22       |        1 |       130 |                3 |
| SBTEST19   |      116 | NULL       |     NULL |       134 |                3 |
| SBTEST19   |      116 | K_19       |        1 |       134 |                3 |
| SBTEST20   |      119 | NULL       |     NULL |       136 |                3 |
| SBTEST20   |      119 | K_20       |        1 |       136 |                3 |
| SBTEST23   |      122 | NULL       |     NULL |       140 |                3 |
| SBTEST23   |      122 | K_23       |        1 |       140 |                3 |
| SBTEST17   |      125 | NULL       |     NULL |       143 |                3 |
| SBTEST17   |      125 | K_17       |        1 |       143 |                3 |
| SBTEST18   |      128 | NULL       |     NULL |       145 |                3 |
| SBTEST18   |      128 | K_18       |        1 |       145 |                3 |
| SBTEST29   |      131 | NULL       |     NULL |       147 |                3 |
| SBTEST29   |      131 | K_29       |        1 |       147 |                3 |
| SBTEST32   |      134 | NULL       |     NULL |       149 |                3 |
| SBTEST32   |      134 | K_32       |        1 |       149 |                3 |
| SBTEST30   |      137 | NULL       |     NULL |       152 |                3 |
| SBTEST30   |      137 | K_30       |        1 |       152 |                3 |
| SBTEST27   |      140 | NULL       |     NULL |       154 |                3 |
| SBTEST27   |      140 | K_27       |        1 |       154 |                3 |
| SBTEST28   |      143 | NULL       |     NULL |       157 |                3 |
| SBTEST28   |      143 | K_28       |        1 |       157 |                3 |
| SBTEST31   |      146 | NULL       |     NULL |       159 |                3 |
| SBTEST31   |      146 | K_31       |        1 |       159 |                3 |
| SBTEST25   |      149 | NULL       |     NULL |       163 |                3 |
| SBTEST25   |      149 | K_25       |        1 |       163 |                3 |
| SBTEST26   |      152 | NULL       |     NULL |       183 |                3 |
| SBTEST26   |      152 | K_26       |        1 |       183 |                3 |
+------------+----------+------------+----------+-----------+------------------+
64 rows in set (0.02 sec)