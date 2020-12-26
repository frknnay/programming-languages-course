fun max(l:int list)=
    if null l
    then 0
    else if null (tl l)
    then hd l
    else
        let 
            val x = max(tl l)
        in
            if x > hd l
            then x
            else hd l
        end

fun count_up(from:int ,to: int)=
    if from = to
    then to::[]
    else
        from::count_up(from+1,to)