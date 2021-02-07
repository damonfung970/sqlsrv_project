select a.idm '_0',a.ypmc '名                           称',a.ypgg '规格',a.cjmc '产地',str(a.ylsj*a.zyxs/a.ykxs,14,4) '单价', a.zydw '单位',b.name '执行科室',a.ypdm '代码',a.py '拼音',a.wb '五笔', a.zyxs '_1',a.ykxs '_2',a.ksdm '_3',a.dxmdm '_4',c.name '_5',a.ypbz '_6',a.zfbz '_7',a.zfbl '_8',1 '_9', a.ybkzbz '医保控制标志',a.zyzfbz '住院自费标志',NULL '_21' ,0 '_22',0 '_23',0 '_24',NULL '_25',null '_26',0 '_27',null '_28'  ,a.ypmc '_29',0 '_30',null '_31',null  '_32',null '_33',null '_34','0' '_35'  ,null '_36' ,d.pp '品牌',d.memo '备注',e.xmdm '医保编码'  
from VW_ZYJGK a (nolock)  
left join YY_KSBMK b (nolock) 
    on a.ksdm=b.id  
left join YY_SFDXMK c (nolock) 
    on a.dxmdm=c.id  
left join YY_SFXXMK d (nolock) 
    on a.ypdm=d.id  
left join VW_YPXMMATCHED e(nolock) 
    on a.ypdm = e.ypdm and a.idm = e.idm 
where a.py like '%xybhdjc%'  
    and a.xmlb in (11,0,1,13) 
    and a.idm = 0  
    and ((a.ypbz=1 
            AND exists
                (select 1 
                    from YY_SFXXMSSYYK z2(nolock) 
                    where a.ypdm=z2.xxmid and z2.yydm='1'
                )
           ) 
           or (a.ypbz not in(1)) 
         ) and isnull(d.xxmbz,0) = 0  
-- union all 
select 0 ,a.name ,'1'+a.xmdw ,' ',str(a.xmdj,14,4) ,a.xmdw ,b.name ,a.id ,a.py ,a.wb ,1 ,1 ,a.zxks_id ,'0' ,'临床项目' ,1 ,0 ,0 ,1,0,0,NULL '_21' ,0 '_22',0 '_23',0 '_24',NULL '_25',null '_26',0 '_27',null '_28'  ,a.name '_29',0 '_30',null '_31',null  '_32',null '_33',null '_34','0' '_35'  ,null '_36' ,null '品牌',null '备注', null '医保编码' 
from YY_LCSFXMK a (nolock)  
    left join YY_KSBMK b (nolock) 
        on a.zxks_id=b.id  
where a.jlzt = 0 
    and a.py like '%xybhdjc%' 
    and a.xmlb in (11,0,1,13)  
    and a.yydm='1' 
order by a.dxmdm,a.ypdm,a.ypmc


sp_helptext VW_ZYJGK


create   view VW_ZYJGK(idm,gg_idm,lc_idm,ypdm,ypmc,py,wb,ksdm,ypgg,jxdm  
 ,fldm,cjmc,dxmdm,ylsj,mzdw,mzxs,zydw,zyxs,ykxs,yfcl  
 ,djcl,yhbl,zfbz,zfbl,zyzfbz,zyzfbl,gzbz,tsbz,ypbz,xmlb  
 ,yjqr,txbl,yzxm,yzgl,djs,zxdw,ggdw,ggxs,cgyzbz,dybz  
 ,yzbz,ybkzbz,zyflzfbz,bxbz,tsbjzbz,memo,syfw,czyzfw,czyzksdm,wtcomputedm  
 ,cfypbz,zbybz,ypdm1,sqddm,lcdw1,lcxs1,ssjsb,xmdm,cyfybz,id  
 ,ctzxks,tybz,kjsbz,lcxmdm,ssmemo,lcxmdj,lcxmmc,pos,zbbz,etjsbz  
 ,etjsb,etjsxmdm,ybfydj,cd  
 )  
as --集193927 2020-04-02 16:38:28 4.0标准版  
select a.cd_idm,a.gg_idm,a.lc_idm,c.ypdm  
 ,case d.ywmldj when 1 then '甲类'+c.ypmc when 2 then '乙类'+c.ypmc else ''+c.ypmc end ypmc  
 ,c.py,c.wb,a.ksdm,(case when c.zyflzfbz=1 then '[乙]' when c.zyzfbz=1 then '[丙]' else '[甲]' end)+c.ypgg,c.jxdm -- 0-9  
 ,c.fldm,c.cjmc,c.yplh,c.ylsj,c.mzdw,c.mzxs,c.zydw,c.zyxs,c.ykxs,a.kcsl2-a.djsl  
 ,a.djsl,0,c.zfbz,c.zfbl,c.zyzfbz,c.zyzfbl,a.gzbz,a.tsbz,0,-1  
 ,0,1,1,0,a.djs,c.zxdw,c.ggdw,c.ggxs,0,0  
 ,0,c.ybkzbz,c.zyflzfbz,c.bxbz,0,c.memo,isnull(c.syfw,0),0,'',e.wtcomputedm  
 ,c.cfyp,c.zbybz,c.ypdm1,0,isnull(c.lcdw1,c.mzdw),isnull(c.lcxs1,c.mzxs),isnull(e.ssjsb,1),c.ypdm,a.cyfybz,c.ypdm  
 ,a.ksdm,a.tybz,0,'0','',0.00,'',0,c.zbbz,0 as etjsbz  
 ,0.00 as etjsb,'' as etjsxmdm,c.ybfydj,e.cd  
from YF_YFZKC a (nolock)  
 inner join YK_YPCDMLK c (nolock) on a.cd_idm=c.idm  and c.tybz=0  
 left join YB_JBML d(nolock) on c.dydm=d.xmbm  
 left join YY_SFXXMK e(nolock) on c.ypdm=e.id and e.sybz=1 and e.zybz=1  
where a.kzbz=0 and isnull(a.jbdyfw,0) in (0, 2)    
 ----药品是否取同规格最大库存 start   
 --and (  exists(select 1 from YY_CONFIG(nolock) where id='0219' and config='否')   
 --      or   
 --     ( exists(select 1 from YY_CONFIG(nolock) where id='0219' and config='是') and   
 --      a.cd_idm = (select top 1 w1.cd_idm from YF_YFZKC w1(nolock) where a.ksdm=w1.ksdm and a.gg_idm=w1.gg_idm  order by w1.kcsl3 desc)   
 --     )   
 --    )   
 ----药品是否取同规格最大库存 end   
-- union all  
select a.cd_idm,a.gg_idm,a.lc_idm,d.ypdm  
 ,case e.ywmldj when 1 then '甲类'+d.bmmc when 2 then '乙类'+d.bmmc else ''+d.bmmc end ypmc  
 ,d.py,d.wb,a.ksdm,(case when c.zyflzfbz=1 then '[乙]' when c.zyzfbz=1 then '[丙]' else '[甲]' end)+c.ypgg,c.jxdm  
 ,c.fldm,c.cjmc,c.yplh,c.ylsj,c.mzdw,c.mzxs,c.zydw,c.zyxs,c.ykxs,a.kcsl2-a.djsl  
 ,a.djsl,0,c.zfbz,c.zfbl,c.zyzfbz,c.zyzfbl,a.gzbz,a.tsbz,0,-1  
 ,0,1,1,0,a.djs,c.zxdw,c.ggdw,c.ggxs,0,0  
 ,0,c.ybkzbz,c.zyflzfbz,c.bxbz,0,c.memo,isnull(c.syfw,0),0,'',f.wtcomputedm  
 ,c.cfyp,c.zbybz,c.ypdm1,0,isnull(c.lcdw1,c.mzdw),isnull(c.lcxs1,c.mzxs),isnull(f.ssjsb,1),d.ypdm,a.cyfybz,d.ypdm  
 ,a.ksdm,a.tybz,0,'0','',0.00,'',0,c.zbbz,0 as etjsbz  
 ,0.00 as etjsb,'' as etjsxmdm,c.ybfydj,f.cd  
from YF_YFZKC a (nolock)  
 inner join YK_YPCDMLK c (nolock) on a.cd_idm=c.idm and c.tybz=0   
 inner join YK_YPBMK d(nolock) on c.idm=d.idm   
 left join YB_JBML e(nolock) on  c.dydm=e.xmbm  
 left join YY_SFXXMK f(nolock) on   d.ypdm=f.id  and f.sybz=1 and f.zybz=1  
where a.kzbz=0 and isnull(a.jbdyfw,0) in (0, 2)  
 ----药品是否取同规格最大库存 start   
 --and (  exists(select 1 from YY_CONFIG(nolock) where id='0219' and config='否')   
 --      or   
 --     ( exists(select 1 from YY_CONFIG(nolock) where id='0219' and config='是') and   
 --      a.cd_idm = (select top 1 w1.cd_idm from YF_YFZKC w1(nolock) where a.ksdm=w1.ksdm and a.gg_idm=w1.gg_idm  order by w1.kcsl3 desc)   
 --     )   
 --    )   
 ----药品是否取同规格最大库存 end   
-- union all  
select 0,0,0,id,name,py,wb,zxks_id,(case when zyflzfbz=1 then '[乙]' when zyzfbz=1 then '[丙]' else '[甲]' end)+xmgg,''  
 ,'','',dxmdm,xmdj,xmdw,1,xmdw,1,1,999999  
 ,0,yhbl,mzzfbz,mzzfbl,zyzfbz,zyzfbl,0,0,1,xmlb  
 ,yjqrbz,txbl,yzxm,yzgl,0,xmdw,xmdw,1,cgyzbz,dybz  
 ,yzbz,ybkzbz,zyflzfbz,0,tsbjzbz,memo,isnull(syfw,0),0,'',wtcomputedm  
 ,0,0,'',0,xmdw,1,isnull(ssjsb,1),id,1,id  
 ,zxks_id,0,0,'0',ssmemo,0.00,'',0,0 as zbbz,isnull(etjsbz,0)  
 ,etjsb,etjsxmdm,'' ybfydj,cd  
from YY_SFXXMK (nolock)  
where sybz=1 and zybz=1 and ysjfxm=0  
-- union all  
select 0,0,0,a.id,c.bmmc,c.py,c.wb,a.zxks_id,(case when a.zyflzfbz=1 then '[乙]' when a.zyzfbz=1 then '[丙]' else '[甲]' end)+a.xmgg,''  
 ,'','',a.dxmdm,a.xmdj,a.xmdw,1,a.xmdw,1,1,999999  
 ,0,a.yhbl,a.mzzfbz,a.mzzfbl,a.zyzfbz,a.zyzfbl,0,0,1,a.xmlb  
 ,a.yjqrbz,a.txbl,a.yzxm,a.yzgl,0,a.xmdw,a.xmdw,1,a.cgyzbz,a.dybz  
 ,a.yzbz,a.ybkzbz,a.zyflzfbz,0,a.tsbjzbz,a.memo,isnull(a.syfw,0),0,'',wtcomputedm  
 ,0,0,'',0,a.xmdw,1,isnull(a.ssjsb,1),a.id,1,a.id  
 ,a.zxks_id,0,0,'0',a.ssmemo,0.00,'',0,0 as zbbz,isnull(a.etjsbz,0)  
 ,a.etjsb,a.etjsxmdm,'' ybfydj,a.cd  
from YY_SFXXMK a (nolock), YY_SFXXMBMK c (nolock)  
where a.sybz=1 and a.zybz=1 and a.id=c.id and a.ysjfxm=0  
-- union all  
select xh,0,0,'',CASE yzfw WHEN '0' THEN '全-' + name WHEN '1' THEN '科-' +name WHEN '2' THEN '区-' +name WHEN '3' THEN '个-' +name WHEN '4' THEN '方-' +name end name,py,wb,bqdm,'成套医嘱',''  
 ,'','','',0,'',1,'',1,1,999999  
 ,0,0,0,0,0,0,0,0,2,-1  
 ,0,0,0,0,0,'','',1,0,0  
 ,0,0,0,0,0,'',0,isnull(yzfw,0),(case isnull(yzfw,0) when 1 then ksdm when 3 then ysgh else '' end),''  
 ,0,0,'',0,'',1,1,'',1,''  
 ,zxks,0,isnull(kjsbz,0),'0','',0.00,'',0,0 as zbbz,0 as etjsbz  
 ,0.00 as etjsb,'' as etjsxmdm,'' ybfydj,'' as cd  
from BQ_CZYZK (nolock)   
where yzlb=0  
-- union all  
select 0,0,0,a.id,a.name,a.py,a.wb,'','手术项目',''  
 ,'','','',0,'次',1,'次',1,1,999999  
 ,0,0,0,0,0,0,0,0,3,-1  
 ,0,0,0,0,0,'次','次',1,0,0  
 ,0,0,0,0,0,'',0,0,'',b.wtcomputedm  
 ,0,0,'',0,'次',1,isnull(b.ssjsb,1),a.id,1,a.id  
 ,'',0,0,'0','',0.00,'',0,0 as zbbz,0 as etjsbz  
 ,0.00 as etjsb,'' as etjsxmdm,'' ybfydj,b.cd  
from SS_SSMZK a(nolock)  
 left join YY_SFXXMK b(nolock) on a.id=b.id and b.sybz=1 and b.zybz=1 and b.ysjfxm=0  
where a.lb=0  and a.tybz=0  
-- union all  
select 0,0,0,convert(varchar(12),config),a.name,a.py,a.wb,'','医技申请单',''  
 ,'','','',0,'次',1,'次',1,1,999999  
 ,0,0,0,0,0,0,0,0,1,-1  
 ,0,0,1,0,0,'次','次',1,0,0  
 ,0,0,0,0,0,'',0,0,'','0'  
 ,0,0,'',0,'次',1,1,convert(varchar(12),config),1,convert(varchar(12),config)  
 ,'',0,0,'0','',0.00,'',0,0 as zbbz,0 as etjsbz  
 ,0.00 as etjsb,'' as etjsxmdm,'' ybfydj,'' as cd  
from YJ_YS_SQDMBK a(nolock),YY_CONFIG b(nolock)  
where a.xtfw=0 and a.jlzt=0 and b.id='G030'  
  
  