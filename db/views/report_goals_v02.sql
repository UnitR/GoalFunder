SELECT  g.name goal_name,
        g.created_at goal_created_at,
        g.target goal_target,
        Sum(p.amount) goal_funded,
        u.last_name user_last_name,
        u.first_name user_first_name,
        u.email user_email,
        g.keywords
FROM    goals g
INNER JOIN  goal_owners go on g.id = go.goal_id
INNER JOIN  payments p on g.id = p.goal_id
INNER JOIN  users u on go.user_id = u.id
GROUP BY g.name, g.created_at, g.target, u.last_name, u.first_name, u.email, g.keywords;