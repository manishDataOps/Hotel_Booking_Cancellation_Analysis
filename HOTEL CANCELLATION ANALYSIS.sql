-- HOTEL BOOKING CANCELLATION ANALYSIS

--(1) Overall Booking & Cancellation Analysis;

	SELECT 
	COUNT(*) AS total_booking ,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking ;

--(2) Cancellation Rate by Hotel Type;

	SELECT
	hotel,
	COUNT(*) AS total_booking,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS  total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY hotel
	ORDER BY total_cancellation DESC ;

--(3) Lead Time-wise Booking Cancellation Analysis;
	
	SELECT
	CASE
		WHEN lead_time <= 30 THEN 'below 30 days'
		WHEN lead_time BETWEEN 31 AND 60 THEN '31 to 60 days'
		ELSE 'above 60 days' end AS lead_time_group,
	COUNT(*) AS total_booking,
		SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
		CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY 
		CASE
		WHEN lead_time <= 30 THEN 'below 30 days'
		WHEN lead_time BETWEEN 31 AND 60 THEN '31 to 60 days'
		ELSE 'above 60 days' end
		ORDER BY total_cancellation DESC ;

--(4) Market Segment-wise Booking & Cancellation Analysis;

	SELECT
	market_segment,
	COUNT(*) AS total_booking,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY market_segment
	ORDER BY total_booking DESC, cancellation_rate DESC ;

--(5) Repeat vs New Customer Cancellation Behavior;
	
	SELECT
	CASE WHEN is_repeated_guest = 1 THEN 'repeted_customer' ELSE 'unique_customer' END AS customer_type,
	COUNT(*) AS total_booking,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY CASE WHEN is_repeated_guest = 1 THEN 'repeted_customer' ELSE 'unique_customer' END ;

--(6) Year-wise Booking Cancellation Analysis;

	SELECT
	FORMAT(reservation_status_date,'yyyy') AS year,
	COUNT(*) AS total_booking,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY FORMAT(reservation_status_date,'yyyy') ;

--(7) Monthly Booking Cancellation Rate ;

	SELECT
	MONTH(reservation_status_date) AS month_num,
	FORMAT(reservation_status_date,'MMM') AS month,
	COUNT(*) AS total_booking,
	SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS total_cancellation,
	CONCAT(CAST(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS decimal(5,2)),'%') AS cancellation_rate
	FROM hotel_booking
	GROUP BY MONTH(reservation_status_date), FORMAT(reservation_status_date,'MMM') 
	ORDER BY MONTH(reservation_status_date) ASC ;
	


