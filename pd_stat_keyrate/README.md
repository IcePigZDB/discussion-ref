* Discussion in [TiDB_Hot_Regions_History PR](https://github.com/pingcap/tidb/pull/30500)
* Observation: KeyRate is always 0.
` KeyRate: (float64) 0,`

* log code `server/handler.go/packHotRegions`:
```go
func (h *Handler) packHotRegions(hotPeersStat statistics.StoreHotPeersStat, hotRegionType string) (historyHotRegions []core.HistoryHotRegion, err error) {
	c, err := h.GetRaftCluster()
	if err != nil {
		return nil, err
	}
	for _, hotPeersStat := range hotPeersStat {
		stats := hotPeersStat.Stats
		for _, hotPeerStat := range stats {
			region := c.GetRegion(hotPeerStat.RegionID)
			if region == nil {
				continue
			}
			meta := region.GetMeta()
			meta, err := encryption.EncryptRegion(meta, h.s.encryptionKeyManager)
			if err != nil {
				return nil, err
			}
			var peerID uint64
			var isLearner bool
			for _, peer := range meta.Peers {
				if peer.StoreId == hotPeerStat.StoreID {
					peerID = peer.Id
					isLearner = core.IsLearner(peer)
					break
				}
			}
			stat := core.HistoryHotRegion{
				// store in ms.
				UpdateTime:     hotPeerStat.LastUpdateTime.UnixNano() / int64(time.Millisecond),
				RegionID:       hotPeerStat.RegionID,
				StoreID:        hotPeerStat.StoreID,
				PeerID:         peerID,
				IsLeader:       peerID == region.GetLeader().Id,
				IsLearner:      isLearner,
				HotDegree:      int64(hotPeerStat.HotDegree),
				FlowBytes:      hotPeerStat.ByteRate,
				KeyRate:        hotPeerStat.KeyRate,
				QueryRate:      hotPeerStat.QueryRate,
				StartKey:       string(region.GetStartKey()),
				EndKey:         string(region.GetEndKey()),
				EncryptionMeta: meta.GetEncryptionMeta(),
				HotRegionType:  hotRegionType,
			}
			// log logical
			file := "/log_keyrate.txt"
			logFile, err := os.OpenFile(file, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0766)
			if err != nil {
				panic(err)
			}
			llog.SetOutput(logFile) // 将文件设置为log输出的文件
			llog.SetPrefix("[qSkipTool]")
			llog.SetFlags(llog.LstdFlags | llog.Lshortfile | llog.LUTC)
			llog.Println(spew.Sdump(stat))
			// log logical
			historyHotRegions = append(historyHotRegions, stat)
		}
	}
	return
}
```
