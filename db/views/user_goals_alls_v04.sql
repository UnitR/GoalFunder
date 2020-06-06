SELECT  g.id            goal_id,
        g.name          goal_name,
        g.target        goal_target,
        grp.id          group_id,
        grp.name        group_name,
        NULL            user_id,
        Sum(Coalesce(p.amount, 0))   contr_amount
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
    g.name, grp.id, grp.name, g.target, g.id
UNION ALL
SELECT  g.id,
        g.name,
        g.target,
        NULL,
        NULL,
        u.id,
        Sum(Coalesce(p.amount, 0))
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
    g.name, u.id, g.target, g.id;