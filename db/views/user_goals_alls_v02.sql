SELECT  g.name          goal_name,
        g.target        goal_target,
        grp.id          group_id,
        grp.name        group_name,
        NULL            user_id,
        Sum(p.amount)   contr_amount
FROM    goals g
LEFT JOIN
    goal_owners go on g.id = go.goal_id
LEFT JOIN
    groups grp on grp.id = go.group_id
LEFT JOIN
    user_group_memberships ugm on grp.id = ugm.group_id
LEFT JOIN
    users u on ugm.user_id = u.id
LEFT JOIN
    payments p on u.id = p.user_id
WHERE
    go.group_id is not null
AND go.user_id is null
GROUP BY
    g.name, grp.id, grp.name, g.target
UNION ALL
SELECT  g.name,
        g.target,
        NULL,
        NULL,
        u.id,
        Sum(p.amount)
FROM    goals g
LEFT JOIN
    goal_owners go on g.id = go.goal_id
LEFT JOIN
    users u on u.id = go.user_id
LEFT JOIN
    payments p on p.user_id = u.id
WHERE
    go.user_id is not null
AND go.group_id is null
GROUP BY
    g.name, u.id, g.target;