fun old_max(l:int list)=
    if null l
    then 0
    else if null (tl l)
    then hd l
    else
        let 
            val x = old_max(tl l)
        in
            if x > hd l
            then x
            else hd l
        end

fun max1 (xs: int list)=
    if null xs
    then NONE
    else
        let 
            val x = max1(tl xs)
        in
            if isSome x andalso valOf x > hd xs
            then x
            else SOME (hd xs)
        end