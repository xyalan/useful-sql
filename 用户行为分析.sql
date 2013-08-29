with lost_user as (select count(*) 流失用户
  from (select a.sequence_id, max(ull.login_time) last_login_time
          from t_account a, t_user_login_log ull
         where a.sequence_id = ull.user_id
         group by a.sequence_id)
 where last_login_time < (sysdate - 90)),
 activef_user as(select count(*) 活跃用户
  from (select a.sequence_id, max(ull.login_time) last_login_time
          from t_account a, (select * from t_user_login_log where login_time >= (sysdate - 90)) ull
         where a.sequence_id = ull.user_id
         group by a.sequence_id having count(*) >= 2)
 ),
 total_user as(select count(*) 总用户 from t_account a where a.user_status = 1
 )

 select * from total_user,activef_user,lost_user


