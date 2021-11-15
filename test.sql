--FLAT
select --A.*,
CASE WHEN A.TYPE_RATE = 'BATAS' THEN NULL ELSE CAST(NVL(B.FLAT_RATE ,0) AS DECIMAL(19,2)) END RATE 
from PARAM_KREDIT_602 A
LEFT JOIN
(select aa.JENIS, aa.KURS, aa.TYPE_RATE,
  (case when aa.sum_flat_cbalrprate <> 0 THEN aa.sum_flat_cbalrprate/aa.sum_flat_cbalrp end) as 
 flat_rate, 
(case when aa.sum_eff_cbalrprate <> 0 THEN aa.sum_eff_cbalrprate/aa.sum_eff_cbalrp end) as 
 eff_rate
from (
select JENIS, trim(CURRENCY) as KURS, TYPE_RATE, SUM(FLAT_CBALRP) as sum_flat_cbalrp,
  SUM(EFEKTIF_CBALRP) as sum_eff_cbalrp, SUM(FLAT_CBALRP_RATE) as sum_flat_cbalrprate,
  SUM(EFEKTIF_CBALRP_RATE) as sum_eff_cbalrprate
from (
select
--LNTNEW Bisa Macem2, bisa Flat ataupun Efektif
/*a.ACCTNO, a.CIFNO,*/ 
(case when a.PENGGUNAAN  in (10,16,18,20,25,26,28,29,32,36,38,
39) THEN 'KREDIT MODAL KERJA'
when a.PENGGUNAAN  in (71,72,73,77,78,80,81,82,83,84,85,86,87,88,89) THEN 'KREDIT KONSUMSI'
when a.PENGGUNAAN  in (40,42,45,46,47,48,49,50,51,52,53,54,55,56,57,59,60,62,63,64,67,74,75,76,
79) THEN 'KREDIT INVESTASI' end) as JENIS,
(case when a.IFREQ = 'F' THEN 'FLAT' 
when a.IFREQ <> 'F' THEN 'EFEKTIF' end) as TYPE_RATE,
trim(a.CURRENCY) as CURRENCY, b.JFXDCR,
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP, 
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP_RATE, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP_RATE 
from USRSYSLHBU.LNTNEW_H0 a
INNER JOIN USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
select 
-- LNTNEW UNTUK H-1 SETELAH JAM 12 SIANG
-- Bisa Macem2, bisa Flat ataupun Efektif
/*a.ACCTNO, a.CIFNO, */
(case when a.PENGGUNAAN  in (10,16,18,20,25,26,28,29,32,36,38,
39) THEN 'KREDIT MODAL KERJA'
when a.PENGGUNAAN  in (71,72,73,77,78,80,81,82,83,84,85,86,87,88,89) THEN 'KREDIT KONSUMSI'
when a.PENGGUNAAN  in (40,42,45,46,47,48,49,50,51,52,53,54,55,56,57,59,60,62,63,64,67,74,75,76,
79) THEN 'KREDIT INVESTASI' end) as JENIS,
(case when a.IFREQ = 'F' THEN 'FLAT' 
when a.IFREQ <> 'F' THEN 'EFEKTIF' end) as TYPE_RATE,
trim(a.CURRENCY) as CURRENCY, b.JFXDCR,
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP, 
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP_RATE, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_LNTNEW a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,actda7 as actda71, count(*) from (
select TIME_SK, acctno,cifno,count(*),max(actda7) as actda7 from h1_lntnew group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by actda7,cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1 and A.actda7 = B.actda71) a
INNER JOIN USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- BMPDPME KMK, efektif
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE  
from USRSYSLHBU.BMPDPME_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
--H-1 BMPDPME 
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE  
from (select distinct * from USRSYSLHBU.H1_BMPDPME a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_bmpdpme group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
--FORFAITING H0
SELECT 'KREDIT MODAL KERJA' as JENIS, 'FLAT' as TYPE_RATE, A.curtyp as CURRENCY,
  b.JFXDCR,  A.amount*b.JFXDCR as FLAT_CBALRP, 0 as EFEKTIF_CBALRP,  A.amount*b.JFXDCR*a.rate as FLAT_CBALRP_RATE,
 0 as EFEKTIF_CBALRP_RATE
from USRSYSLHBU.forfeiting_h0 a
inner join USRSYSLHBU.JHFXDT_h0 b
on trim(a.CURtyp) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURtyp) in ('IDR', 'USD')
UNION ALL
--- FORFAITITNG H1
SELECT 'KREDIT MODAL KERJA' as JENIS, 'FLAT' as TYPE_RATE, A.curtyp as CURRENCY,
  b.JFXDCR,  A.amount*b.JFXDCR as FLAT_CBALRP, 0 as EFEKTIF_CBALRP,  A.amount*b.JFXDCR*a.rate as FLAT_CBALRP_RATE,
 0 as EFEKTIF_CBALRP_RATE
from (select * from USRSYSLHBU.h1_forfeiting a join (select MAX(TIME_SK) AS TIME_SK1,no_rek AS acctno1,cif_benef AS CIFNO1,count(*) from (
select TIME_SK, no_rek,cif_benef,count(*) from h1_forfeiting group by TIME_SK,  no_rek,cif_benef having count(*) >= 1)
 group by  no_rek,cif_benef having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.no_rek = B.ACCTNO1) a
inner join USRSYSLHBU.h1_JHFXDT b
on trim(a.CURtyp) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURtyp) in ('IDR', 'USD')
UNION ALL
-- BMTRPME KMK, efektif
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE
from USRSYSLHBU.BMTRPME_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- H-1 BMTRPME
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE
from (select distinct * from USRSYSLHBU.H1_BMTRPME a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_bmtrpme group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- CAP Konsumsi, efektif
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE
from USRSYSLHBU.CAP_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- H-1 CAP
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE
from (select distinct * from USRSYSLHBU.H1_CAP a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_cap group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- IIFMPME KMK, efektif
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
from USRSYSLHBU.IIFMPME_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- H-1 IIFMPME
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_IIFMPME a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_iifmpme group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- MUF Konsumsi, efektif
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
from USRSYSLHBU.MUF_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- H-1 MUF
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_MUF a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_muf group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- ICS Konsumsi, efektif,
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'FLAT' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, a.CBAL*b.JFXDCR as FLAT_CBALRP, 0 as EFEKTIF_CBALRP,
  a.CBAL*b.JFXDCR*a.RATE*12 as FLAT_CBALRP_RATE,
--- a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
0 as EFEKTIF_CBALRP_RATE 
from USRSYSLHBU.ICS_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.CBAL is not null
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- H-1 ICS
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'FLAT' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, a.CBAL*b.JFXDCR as FLAT_CBALRP, 0 as EFEKTIF_CBALRP,
  a.CBAL*b.JFXDCR*a.RATE*12 as FLAT_CBALRP_RATE,
-- a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
0 as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_ICS a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_ics group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.CBAL is not null
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL 
-- H-1 ODMAST
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE,  trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
-- a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_ODMAST a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_odmast group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.CBAL is not null
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL 
-- H-1 KLN
select /*a.ACCTNO, a.CIFNO,*/ (case when a.PENGGUNAAN  in (10,16,18,20,25,26,28,29,32,36,38,
39) THEN 'KREDIT MODAL KERJA'
when a.PENGGUNAAN  in (71,72,73,77,78,80,81,82,83,84,85,86,87,88,89) THEN 'KREDIT KONSUMSI'
when a.PENGGUNAAN  in (40,42,45,46,47,48,49,50,51,52,53,54,55,56,57,59,60,62,63,64,67,74,75,76,
79) THEN 'KREDIT INVESTASI' end) as JENIS,
(case when a.IFREQ = 'F' THEN 'FLAT' 
when a.IFREQ <> 'F' THEN 'EFEKTIF' end) as TYPE_RATE,
a.CURRENCY, b.JFXDCR,
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP, 
(case when a.IFREQ = 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ <> 'F' THEN 0 end) as FLAT_CBALRP_RATE, 
(case when a.IFREQ <> 'F' THEN a.CBAL*b.JFXDCR*a.RATE*100 
when a.IFREQ = 'F' THEN 0 end) as EFEKTIF_CBALRP_RATE 
from (select distinct * from USRSYSLHBU.H1_KLN a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_kln group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
INNER JOIN USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- SCM_H0
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE,  trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE  
from USRSYSLHBU.SCM_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- SCM_H-1
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE  
from (select distinct * from USRSYSLHBU.H1_SCM a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_scm group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1 and A.CIFNO = B.CIFNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
-- CAYMAN_H0
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT MODAL KERJA' as JENIS, 'EFEKTIF' as TYPE_RATE, trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, cast(a.CBAL as number)*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  cast(a.CBAL as number)*b.JFXDCR*cast(a.RATE as number) as EFEKTIF_CBALRP_RATE  
from USRSYSLHBU.CAYMAN_H0 a
inner join USRSYSLHBU.JHFXDT_H0 b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
AND a.ACCTNO is not null
AND trim(a.ACCTNO) <> ''
AND trim(a.CURRENCY) in ('IDR', 'USD')
UNION ALL
select  /*a.ACCTNO, a.CIFNO,*/ 'KREDIT KONSUMSI' as JENIS, 'EFEKTIF' as TYPE_RATE,  trim(a.CURRENCY) as CURRENCY,
  b.JFXDCR, 0 as FLAT_CBALRP, a.CBAL*b.JFXDCR as EFEKTIF_CBALRP, 0 as FLAT_CBALRP_RATE,
  a.CBAL*b.JFXDCR*a.RATE as EFEKTIF_CBALRP_RATE
from (select distinct * from USRSYSLHBU.H1_CANALIS a join (select MAX(TIME_SK) AS TIME_SK1,acctno AS acctno1,cifno AS CIFNO1,count(*) from (
select TIME_SK, acctno,cifno,count(*) from h1_canalis group by TIME_SK, cifno, acctno having count(*) >= 1)
 group by cifno,acctno having count(*) >= 1) B
ON A.TIME_SK = B.TIME_SK1 AND A.ACCTNO = B.ACCTNO1) a
inner join USRSYSLHBU.H1_JHFXDT b
on trim(a.CURRENCY) = trim(b.JFXDCD)
where b.JFXDRN = 10
AND a.RATE is not null
--AND a.RATE <> 0
AND trim(a.CURRENCY) in ('IDR', 'USD')
)
group by JENIS, trim(CURRENCY), TYPE_RATE )aa) B
ON A.JENIS = B.JENIS AND A.KURS = B.KURS AND A.TYPE_RATE = B.TYPE_RATE
WHERE A.TYPE_RATE = 'FLAT' OR A.TYPE_RATE = 'BATAS'
ORDER BY A.NO

'11000007521','16000106232','14000206194','16000170243','16000039083','1002566555','1000001267','16000511446','4002911435',
'16000514713','16000126345','2000243416','2000951095','1002708321','7000054735','19005638102','16000209137','16000071272',
'8000021100','16000454058'

-- gross loan
-- 202012
'16000041901','14001197637','16000012919','2000124445','11000007521','800025','11000574200','1000020050',
'10000025243','9001954133','20000151269','9000077884','8000036097','16000106232','2000039307','1004549304',
'9001665482','16000340598','11000071029','23000028468'
-- 202103
'16000041901','14001197637','16000012919','2000124445','11000007521','800025','10000025243','20000151269',
'11000574200','1000020050','16000106232','9001954133','8000036097','23000028468','16000246736','18000000081',
'2000039307','9000077884','11000071029','9001665482'

-- gross loan versi bisekt8
-- 2012
'16000041901','14001197637','16000012919','2000124445','11000007521','800025','10000025243','9001954133','20000151269',
'1000020050','9000077884','8000036097','16000106232','2000039307','1004549304','9001665482','16000340598','11000071029',
'23000028468','18000000081'
bisekt8 :
'5401002','3132030','10671002','4151440','4271000','12752000','6452212','7522200','9643000','9633000','4153190','6452120',
'1011340','11701009','3101000','5401002','9643000','9601000','6452130','12751000'

BISEKT8 in ('5401002','3132030','10671002','4151440','4271000','12752000','6452212','7522200','9643000','9633000','4153190','6452120',
'1011340','11701009','3101000','5401002','9643000','9601000','6452130','12751000')

-- 202103
'5401002','3132030','10671001','4151440','4271000','12752000','6452212','9643000','1011340','9633000','7522200','6452120',
'5402000','12751000','11701009','9601000','5401002','9643000','9642000','3101000'
'16000041901','14001197637','16000012919','2000124445','11000007521','800025','10000025243','20000151269','16000106232',
'1000020050','9001954133','8000036097','16000246736','18000000081','2000039307','11000071029','9001665482','16000340598',
'4000437903','1004549304'
,


-- performance restru
-- 202012
'11000007521','16000106232','14000206194','16000170243','16000039083','1002566555','1000001267','16000511446','4002911435',
'16000514713','16000126345','2000243416','2000951095','1002708321','7000054735','19005638102','16000209137','16000071272',
'8000021100','16000454058'

-- 202103
'11000007521','16000106232','14000206194','16000039083','16000170243','1000001267','16000511446','4002911435','16000514713',
'2000243416','16000126345','11000307444','2000951095','7000054735','19005638102','16000209137','16000071272','8000021100',
'16000454058','7000236909'
