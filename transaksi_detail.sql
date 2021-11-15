select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200101 and 20200131
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200201 and 20200228
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200301 and 20200331
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200401 and 20200430
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200501 and 20200531
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200601 and 20200630
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200701 and 20200731
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200801 and 20200831
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20200901 and 20200930
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20201001 and 20201031
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20201101 and 20201130
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC
union all
select
cast(tlbf01 as string) as rekening_sumber, 
cast(sumber as string) as nama_rekening_sumber, 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end as tanggal_transaksi, 
cast(tlbtmi as string) as jam_transaksi, 
cast(tlbcud as string) as lokasi_transaksi, --channel,
cast(tlbid as string) as user,
cast(C.tltxcd as string) as kode_transaksi, 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn) as remark,
--credit atau debut
cast(tlbcur as string) as mata_uang,
cast(nomdb as decimal(19,2)) as nominal_debet,
cast(nomcd as decimal(19,2)) as nominal_kredit,
cast(tlbf15 as string) as rekening_penerima,
cast(penerima as string) as nama_penerima,
cast(bank as string) as bank_koresponden,
RMCKC
from bm_bda_tlhist_pst.tfd_tlhist A
join zz_rkarchive.kotran_financial C ON cast(A.tlbtcd as string) =  cast(C.tltxcd as string)
where a.time_pr between 20201201 and 20201231
--cast(a.time_pr as string) like '"+((String)globalMap.get("tForeach_6_CURRENT_VALUE"))+"%' 
and
tlbaft in ('MO', 'A1')
and
(tlbf01 in (1420014246382)
or tlbf15 in (1420014246382))
group by 
cast(tlbf01 as string), 
cast(sumber as string), 
case when length(cast(tlbtdt as string)) = 6 
then from_unixtime(unix_timestamp(cast(tlbtdt as string), 'ddMMyy'), 'yyyy-MM-dd')
else from_unixtime(unix_timestamp(concat('0',cast(tlbtdt as string)), 'ddMMyy'), 'yyyy-MM-dd') end, 
cast(tlbtmi as string), 
cast(tlbcud as string), --channel,
cast(tlbid as string),
cast(C.tltxcd as string), 
concat(tlbds1,' | ',tlbds2,' | ',tlbds3,' | ',tlbtpn),
cast(tlbcur as string),
cast(nomdb as decimal(19,2)),
cast(nomcd as decimal(19,2)),
cast(tlbf15 as string),
cast(penerima as string),
cast(bank as string),
RMCKC