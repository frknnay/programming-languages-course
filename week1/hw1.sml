fun is_older(d1:(int * int * int), d2:(int * int * int)) = 
    let
        val y1 = #1 d1
        val m1 = #2 d1
        val d1 = #3 d1
        val y2 = #1 d2
        val m2 = #2 d2
        val d2 = #3 d2
    in
        y1 < y2 orelse (y1 = y2 andalso m1 < m2) orelse
        (y1 = y2 andalso m1 = m2 andalso d1 < d2)
    end

fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else if #2(hd dates) = month
    then number_in_month(tl dates,month) + 1
    else
        number_in_month(tl dates, month)

fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null dates orelse null months
    then 0
    else
        let
            val month_in_d = number_in_month(dates, hd months) 
        in 
            month_in_d + number_in_months(dates, tl months)
        end

fun dates_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months(dates: (int * int * int) list, months: int list) =
    if null dates orelse null months
    then []
    else 
        let
            val dates_has_month = dates_in_month(dates, hd months)
        in
            dates_has_month @ dates_in_months(dates,tl months)
        end

fun get_nth(strings: string list, n: int) =
   if n = 1
   then hd strings
   else get_nth(tl strings, n - 1)

fun date_to_string(date:(int * int * int)) = 
    let
        val months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ]

        val month = get_nth(months, #2 date);
    in
        month ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum(sum: int, numbers: int list) = 
    if hd numbers < sum
    then 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)
    else 0


fun what_month(day: int) =
    let 
        val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day,months) + 1
    end

fun month_range(day1: int, day2: int) = 
    if day1 > day2
    then []
    else 
        what_month(day1) :: month_range(day1 + 1, day2) 

fun oldest(dates: (int * int * int) list) = 
    if null dates
    then NONE
    else 
        let 
            val tl_oldest = oldest(tl dates);
        in 
            if isSome tl_oldest andalso is_older(valOf tl_oldest,hd dates)
            then tl_oldest
            else SOME(hd dates)
        end



val test1 = is_older((1998, 12, 13), (1998, 12, 14)) andalso not (is_older((1111, 1, 11), (1111, 1, 11)));

val test2 = number_in_month([(1888, 12, 31), (1999, 9, 25), (2099, 7, 15), (2008, 9, 25)], 9) = 2;

val test3 = number_in_months([(1888, 12, 31), (1999, 9, 25), (2099, 7, 15), (2008, 9, 25)], [7, 9]) = 3 andalso (number_in_months([(1,2,25),(3,5,26),(1,12,29),(3,2,28),(1,2,27),(1,2,25),(6,7,8)], []) = 0)

val test4 = dates_in_month([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], 2) = [(22,2,1997), (25,2,1088)] andalso (null (dates_in_month([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], 4)))

val test5 = dates_in_months([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], [2, 3]) = [(22,2,1997), (25,2,1088), (23,3,1997)] andalso (null (dates_in_months([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], [10, 11, 12]))) andalso (dates_in_months ([(1,2,25),(3,5,26),(1,12,29),(3,2,28),(1,2,27),(1,2,25),(6,7,8)], []) = [])

val test6 = get_nth(["AB","CD", "EF", "GH"], 3) = "EF";

val test7 = date_to_string(2018, 12, 31) = "December 31, 2018";

val test8 = number_before_reaching_sum(15, [1, 2, 3, 4, 5, 6]) = 4 andalso (number_before_reaching_sum(15, [1, 2, 3, 4, 4, 5, 6]) = 5);

val test9 = what_month(60) = 3;

val test10 = month_range(30, 33) = [1, 1, 2, 2];

val test11 = oldest([(2018, 10, 30), (2018, 10, 25), (2018, 10, 31), (1995, 11, 31)]) = SOME (1995,11,31) andalso (oldest [] = NONE);
