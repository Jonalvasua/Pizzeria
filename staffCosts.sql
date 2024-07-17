/* Dashboard 3 - Staff

By far the simplest part of the requirements, we want to be able to monitor who was working on any given day or shift and what our overall staff costs are.
	1. Total staff costs
	2. Total hours worked
	3. Hours worked by staff members
	4. Cost per staff member

*/


SELECT
	r.date,
	s.first_name,
	s.last_name,
	s.hourly_rate,
    sh.start_time,
    sh.end_time,
    TIMESTAMPDIFF(MINUTE, sh.start_time, sh.end_time)/60 AS hours_in_shift,
    TIMESTAMPDIFF(MINUTE, sh.start_time, sh.end_time)/60 * s.hourly_rate AS staff_cost
FROM rota r
LEFT JOIN staff s ON r.staff_id = s.staff_id
LEFT JOIN shift sh ON r.shift_id = sh.shift_id;
