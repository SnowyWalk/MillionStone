; DB 다운로더

/*
1 하루카
2 
3 미키
4 유키호
13 히비키
19 미나코
21 마츠리
22 세리카
24 안나
31 토모카
39 코노미
42 미야
47 스바루
11종 
*/


detail_url := "https://imas.gamedbs.jp/mlth/chara/show/"
log := ""

return


Downlaod()
{
    characterIdList := [3, 4, 13, 19, 21, 22, 24, 31, 39, 42, 47]

    p := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    len := 0
    for i, e in characterIdList
    {
        p.Open("GET", detail_url e, true)
        p.Send()
        p.WaitForResponse()

        cardIndexList := []
        while(true)
        {
            len := RegExMatch(p.responseText, "<a href=""https://imas.gamedbs.jp/mlth/chara/show/\d+/(\d+)""", out, len+1)
            if(!len)
                break
            cardIndexList.Push(out1)
        }

        log .= "Character ID : " e "`n"
        log .= "Card Index (" cardIndexList.MaxIndex() ") : " 
        for i,e2 in cardIndexList
            log .= e2 " "
        log .= "`n"

        for i, cardIndex in cardIndexList
        {
            p.Open("GET", detail_url e "/" cardIndex, true)
            p.Send()
            p.WaitForResponse()

            len := 0
            loop, 4
            {
                len := RegExMatch(p.responseText, "original=""(https://imas.gamedbs.jp/mlth/image/card/img/.*?)""", out, len+1)
                imageUrl%A_Index% := out1
            }
            
            log .= cardIndex " -> " imageUrl2 " , " imageUrl4 "`n"

            UrlDownloadToFile, % imageUrl2, % GetRandomFileName()
            UrlDownloadToFile, % imageUrl4, % GetRandomFileName()
        }

    }
    FileAppend, % log, log.txt
    msgbox, finished.
}


GetRandomFileName()
{
    loop
    {
        Random, r, 10000000, 99999999
        if(!FileExist(r ".png"))
            break
    }
    return r ".png"
}


home::reload