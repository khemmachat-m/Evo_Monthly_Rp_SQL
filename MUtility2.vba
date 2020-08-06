'////////// Last Updated on 03/05/2015 by KCM ////////////////////

Public Function strContainSpace(ByRef rngCell As Range) As String
    ' --- Use to check space outside words
    '~~> Check if Cell is empty and has spaces
    'If Len(Trim(rngCell.Value)) = 0 And Len(rngCell.Value) <> 0 Then
    '    strContainedSpace = "Y"
    '~~> Check is cell is empty and doesn't have anything
    'ElseIf Len(Trim(rngCell.Value)) = 0 Then
    '    strContainedSpace = "N"
    'End If
    ' ---------------------------------

    ' --- Use to check space within text
    If WorksheetFunction.CountIf(rngCell, "* *") Then
        strContainSpace = "Yes"
    Else
        strContainSpace = "No"
    End If

End Function

Public Function myEquipSearch2(ByRef strEquipNo As String, ByRef rngIndexRng As Range, _
    Optional ByRef rngResultCol As Range, Optional ByRef strLookAt As String = "Exact") As Variant
'
' Create Date : 16/04/2012 by Khemmachat, Upd 26/06/2014 by Khemmachat
' Create Search Exact String and Return Value in Target Column and Row
'
  Dim cell As Range
'  Dim firstAddress As Variant
  Dim lngRow As Long, lngMaxSearch As Long

'  Dim strFloor As String, strNumber As String, strValue As String
'  Dim lngEquipLen As Long, lngFloorLen As Long, lngNumberLen As Long

'  lngMaxSearch = 500

  Dim varTemp As Variant


'  lngEquipLen = Len(strEquipNo)
'  lngNumberLen = 2
'  lngFloorLen = lngEquipLen - lngNumberLen
'  strFloor = Left(strEquipNo, lngFloorLen)
'  strNumber = Right(strEquipNo, lngNumberLen)

    '  Find the reference word
  On Error GoTo errhandler
  With rngIndexRng
'    Set cell = .Find(strFloor, LookIn:=xlValues)
    If strLookAt = "Exact" Then
        Set cell = .Find(strEquipNo, LookIn:=xlValues, lookat:=xlWhole)
    Else
        Set cell = .Find(strEquipNo, LookIn:=xlValues)
    End If 'strLookAt

    If Not cell Is Nothing Then
        lngRow = cell.Row
        varTemp = rngResultCol.Rows(lngRow).Value
        If Len(varTemp) > 0 Then
            myEquipSearch2 = varTemp
        Else
            myEquipSearch2 = ""
        End If
        Exit Function
    Else
        myEquipSearch2 = "Not Found"
        Exit Function
    End If ' Not Cell

  End With ' rngIndexCol

  Exit Function
errhandler:
  Exit Function

End Function


Public Function myEquipSearch3(ByRef strEquipNo As String, ByRef rngIndexRng As Range, _
    Optional ByRef rngResultRow As Range) As Variant
'
' Create Date : 6/02/2014 by Khemmachat
' Create Search Exact String and Return Value in Target Row
' Modify from myEquipSearch2

  Dim cell As Range
  Dim lngCol As Long, lngMaxSearch As Long, lngFirstCol As Long
  Dim varTemp As Variant


'Check strEquipNo for "", "" means no data to check, then exit function
    If strEquipNo = "" Then
        myEquipSearch3 = ""
        Exit Function
    End If 'cell = ""

'Find number of first column of selected range
'   if lngFirstCol = 1 means selected entire Row, if not equal to 1 means select a Range
    lngFirstCol = rngIndexRng.Column

'  Find the reference word
  On Error GoTo errhandler
  With rngIndexRng

    Set cell = .Find(strEquipNo, LookIn:=xlValues, lookat:=xlWhole)

    If Not cell Is Nothing Then

        lngCol = cell.Column 'Find which column of entire sheet that Text is
'        varTemp = rngResultRow.Columns(lngCol).Value
        varTemp = rngResultRow.Columns(lngCol - lngFirstCol + 1).Value
        If Len(varTemp) > 0 Then
            myEquipSearch3 = varTemp
        Else
            myEquipSearch3 = ""
        End If
        Exit Function
    Else
        myEquipSearch3 = "Not Found"
        Exit Function
    End If ' Not Cell

  End With ' rngIndexCol

  Exit Function
errhandler:
  Exit Function

End Function


Public Function varFindFirstText(ByRef rngIndexRng As Range) As Variant
'
' Create Date : 6/02/2014 by Khemmachat
' Modify Date : 26/02/2016 by Khemmachat
'Find and Return First Text in Range

    For Each cell In rngIndexRng.Cells
        If cell <> "" And cell <> " " Then
            varFindFirstText = cell.Value
            Exit Function
        End If 'Not Cell
    Next cell

   varFindFirstText = "" 'Return Null when found nothing
   Exit Function

errhandler:
  Exit Function

End Function


Public Function varFindLastMDate(ByRef rngPMMasterPlan As Range, ByRef rngPMDate As Range) As Variant

'
' Create Date : 16/06/2014 by Khemmachat
' Modified Date : 3/05/2015 by Khemmachat
' Find Last Maintenance Plan and Return Last Maintenance Date
' Program search from left most cell to right most cell to find biggest maintenance code
' Then, return last maintenance date at biggest maintennace code
' and return Offset months

Dim strPMCode(1 To 6) As String 'for store valide PM Code of W M 2M Q H Y
Dim intLargePMCodeRank As Integer
Dim intLargePMCodePos As Integer
Dim intRank As Integer
Dim dateLargePMCodeDate As Date
Dim intOffsetMonth As Integer

'Dim strTypeofYear As String
Dim strOldYear As String, strNewYear As String
'Dim varNewDate As Variant
Dim varDay As Variant, varMonth As Variant, varYear As Variant

Dim intOffsetColofDateandPlan As Integer
Dim intColOffset As Integer ' Offset Column from first column in selected range that store Largest PM Plan.


'Dim intPMCode(1 To 6) As Integer

' assign initial value
intLargePMCodeRank = 0
intLargePMCodePos = 0
intRank = 0


For i = 1 To 6
    strPMCode(i) = ""
Next i 'for strPMCode

' Calculate number of column between rngDate and rngPlan
intOffsetColofDateandPlan = rngPMMasterPlan.Column - rngPMDate.Column

    For Each cell In rngPMMasterPlan.Cells
        Select Case cell 'assign ranking for each found PM Code
            Case "W"
                intRank = 1
                strPMCode(intRank) = "W"
            Case "M"
                intRank = 2
                strPMCode(intRank) = "M"
            Case "2M"
                intRank = 3
                strPMCode(intRank) = "2M"
            Case "Q"
                intRank = 4
                strPMCode(intRank) = "Q"
            Case "H"
                intRank = 5
                strPMCode(intRank) = "H"
            Case "Y"
                intRank = 6
                strPMCode(intRank) = "Y"
            Case Empty
                intRank = 0
        End Select 'rngPMMasterPlan.Cells

        'Store Largest PM Code
        If intRank > intLargePMCodeRank Then
            intLargePMCodeRank = intRank  'Store higher Rank
            intLargePMCodePos = cell.Column 'Store pos of higher Rank, Column Number of Sheet
            intColOffset = intLargePMCodePos - rngPMMasterPlan.Column + 1 'Store pos of higher Rank, Relative Column of range
        End If 'intRank

    Next cell 'of rngPMMasterPlan
    dateLargePMCodeDate = rngPMDate.Columns(1).Offset(0, intColOffset - 1).Value 'Store Largest PM Date
    intOffsetMonth = intColOffset 'intColOffset is equal to Offset Month, in case of no gap between start month and lastMdate

    ' This function is designed for Offset "MONTH" only, not for "WEEK"

   'Check type of year for A.D. or B.C.
   strOldYear = Right(dateLargePMCodeDate, 4)
   If Val(strOldYear) > 2500 Then ' for B.C.
        'strTypeofYear = "BC"
        'Change Year from BC to AD
        strNewYear = Str(Val(strOldYear) - 543)
        varDay = Format(Day(dateLargePMCodeDate), "##00")
        varMonth = Format(Month(dateLargePMCodeDate), "##00")
        varYear = Format(Year(dateLargePMCodeDate), "##0000")
        varFindLastMDate = varYear + varMonth + varDay + "," + Format(intOffsetMonth, "##00")
    Else ' for A.D.
        'strTypeofYear = "AD"
        varFindLastMDate = Format(dateLargePMCodeDate, "yyyymmdd") + "," + Format(intOffsetMonth, "##00")
   End If 'left(dateLargePMCodeDate)
   'Should Return Null when found nothing
   'varFindLastMDate = Format(dateLargePMCodeDate, "yyyymmdd") + "," + Format(intOffsetMonth, "##00")
   For i = 1 To 6
    varFindLastMDate = varFindLastMDate + "," + strPMCode(i)
   Next i 'for strPMCode

   Exit Function

errhandler:
  Exit Function

End Function


Public Function varPullLastMDateData(ByRef strLastMDateData As String, ByRef intPullIndex As Integer) As String

' Create Date : 23/06/2014 by Khemmachat
' Pull Desinated data from "varFindLastMDate" Function
' data in varFindLastMDate has 8 parameters

Dim varPullData(1 To 8) As String
Dim varTemp As String

If intPullIndex = 1 Then
    varPullData(1) = MyStrExtract(strLastMDateData, "<", ",") 'LastMDate
ElseIf intPullIndex > 1 Then
    varTemp = MyStrExtract(strLastMDateData, ">", ",") 'Store Temp Text
    varPullData(2) = MyStrExtract(varTemp, "<", ",") 'Offset Month
    If intPullIndex > 2 Then
        varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
        varPullData(3) = MyStrExtract(varTemp, "<", ",") 'Week PM Code"
    End If
        If intPullIndex > 3 Then
            varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
            varPullData(4) = MyStrExtract(varTemp, "<", ",") 'Month PM Code"
        End If
            If intPullIndex > 4 Then
                varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
                varPullData(5) = MyStrExtract(varTemp, "<", ",") '2 Months PM Code"
            End If
                If intPullIndex > 5 Then
                    varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
                    varPullData(6) = MyStrExtract(varTemp, "<", ",") 'Quarter PM Code"
                End If
                    If intPullIndex > 6 Then
                        varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
                        varPullData(7) = MyStrExtract(varTemp, "<", ",") 'Half Year PM Code"
                    End If
                        If intPullIndex > 7 Then
                            varTemp = MyStrExtract(varTemp, ">", ",") 'Store next Temp Text
                            varPullData(8) = varTemp 'Year PM Code"
                        End If
End If 'intPullIndex = 1

varPullLastMDateData = varPullData(intPullIndex)

End Function



Public Function varFindLastMDate2(ByRef rngPMMasterPlan As Range, ByRef rngPMDate As Range) As Variant

'
' Create Date : 25/06/2014 by Khemmachat
' Find Last Maintenance Plan and Return Last Maintenance Date
' Program search from left most cell to right most cell to find biggest maintenance code
' Then, return last maintenance date at biggest maintennace code
' and return Offset months
' Start Date for SAP only

Dim strPMCode(1 To 6) As String 'for store valide PM Code of W M 2M Q H Y
Dim intLargePMCodeRank As Integer
Dim intLargePMCodePos As Integer
Dim intRank As Integer
Dim dateLargePMCodeDate As Date
Dim varOffsetMonth As Variant

Dim intOffsetColofDateandPlan As Integer
Dim intColOffset As Integer ' Offset Column from first column in selected range that store Largest PM Plan.

Dim intFirstPMCode As Integer
Dim intFirstPMCodePos As Integer
Dim dateFirstPMCodeDate As Date
Dim intFirstColOffset As Integer
Dim intIsFoundFirstPMCode As Integer
Dim bIsFoundFirstPMCode As Boolean
Dim intNoofPMCode As Integer
Dim intCountBlank As Integer

'Dim intPMCode(1 To 6) As Integer

' assign initial value
intLargePMCodeRank = 0
intLargePMCodePos = 0
intRank = 0
intIsFoundFirstPMCode = 0
bIsFoundFirstPMCode = False
intNoofPMCode = 0
intCountBlank = 0

For i = 1 To 6
    strPMCode(i) = ""
Next i 'for strPMCode

' Calculate number of column between rngDate and rngPlan
intOffsetColofDateandPlan = rngPMMasterPlan.Column - rngPMDate.Column

    For Each cell In rngPMMasterPlan.Cells
        Select Case cell 'assign ranking for each found PM Code
            Case "W"
                intRank = 1
                strPMCode(intRank) = "W"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case "M"
                intRank = 2
                strPMCode(intRank) = "M"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case "2M"
                intRank = 3
                strPMCode(intRank) = "2M"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case "Q"
                intRank = 4
                strPMCode(intRank) = "Q"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case "H"
                intRank = 5
                strPMCode(intRank) = "H"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case "Y"
                intRank = 6
                strPMCode(intRank) = "Y"
                intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1
            Case Empty
                intRank = 0
        End Select 'rngPMMasterPlan.Cells

        'Count number of blank cell from StartMonth to LastMDate for minus varOffsetMonth
        If intRank = 0 And intLargePMCodeRank = 0 Then
            intCountBlank = intCountBlank + 1
        End If 'intRank

        'Store Largest PM Code
        If intRank > intLargePMCodeRank Then
            intLargePMCodeRank = intRank  'Store higher Rank
            intLargePMCodePos = cell.Column 'Store pos of higher Rank, Column Number of Sheet
            intColOffset = intLargePMCodePos - rngPMMasterPlan.Column + 1 'Store pos of higher Rank, Relative Column of range
        End If 'intRank

        'Store first found month
        If intIsFoundFirstPMCode = 1 And bIsFoundFirstPMCode = False Then 'Found first intIsFoundFirstPMCode when its value equal to 1
            intFirstPMCode = intRank 'Store rank of first PM Code found
            intFirstPMCodePos = cell.Column 'Store pos of first found PM Code, Column Number of sheet
            intFirstColOffset = intFirstPMCodePos - rngPMMasterPlan.Column + 1 'Store pos of First Rank, Relative Column of range

            'intIsFoundFirstPMCode = intIsFoundFirstPMCode + 1 'Plus with 1, in order to make sure that will not go into this if loop
            bIsFoundFirstPMCode = True 'Change status from false to true when found first pm code
        End If 'intRank = 0

    Next cell 'of rngPMMasterPlan
    'dateLargePMCodeDate = rngPMDate.Columns(1).Offset(0, intColOffset - 1).Value 'Store Largest PM Date
    'intOffsetMonth = intColOffset 'intColOffset is equal to Offset Month
    ' This function is designed for Offset "MONTH" only, not for "WEEK"

   'Store First Found PM Date
    dateFirstPMCodeDate = rngPMDate.Columns(1).Offset(0, intFirstColOffset - 1).Value 'Store first found PM Date
    'Return Null when found a PM Code, and return offset month from largest PM Code when there are many PM Code
    For i = 1 To 6
        If strPMCode(i) <> "" Then
            intNoofPMCode = intNoofPMCode + 1 'Count No. of Registed PM Code
        End If 'strPMCode
    Next i ' for counting No. of PM Code from strPMCode
    If intNoofPMCode > 1 Then
        'intFirstColOffset is equal to Offset Month minus with 1
        ' and minus with intCountBlank to start counting offset at first month that has PM Code
        varOffsetMonth = intColOffset - 1 - intCountBlank
    ElseIf intNoofPMCode = 1 Then 'Equipments that have a PM Code such as Q, H, Y don't have Offset
        varOffsetMonth = ""
    Else
        varOffsetMonth = "Err"
    End If 'intNoofPMCode

   'Should Return Null when found nothing
   varFindLastMDate2 = Format(dateFirstPMCodeDate, "yyyymmdd") + "," + Format(varOffsetMonth, "##00")
   For i = 1 To 6
    varFindLastMDate2 = varFindLastMDate2 + "," + strPMCode(i)
   Next i 'for strPMCode

   Exit Function

errhandler:
  Exit Function

End Function


Function RegExCheck(objCell As Range, strPattern As String) As Variant
'formula from http://superuser.com/questions/660692/is-there-an-excel-formula-to-identify-special-characters-in-a-cell
'   [] stands for a group of expressions
'   ^ is a logical NOT
'   [^ ] Combine them to get a group of signs which should not be included
'   A-Z matches every character from A to Z (upper case)
'   a-z matches every character from a to z (lower case)
'   0-9 matches every digit
'   _ matches a _
'   - matches a - (This sign breaks your pattern if it's at the wrong position)

'
' Create Date : 29/04/2015 by Superuser.com
' Find Special Characters in Cell
' Use to identify Special Char in Equipment Code
' Return "No" if no special charactor found, and "Yes" if special char found

    Dim RegEx As Object
    Set RegEx = CreateObject("VBScript.RegExp")
    RegEx.Global = True
    RegEx.Pattern = strPattern

    If RegEx.Replace(objCell.Value, "") = objCell.Value Then
        RegExCheck = "No"
    Else
        RegExCheck = "Yes"
    End If

End Function



'Created by https://www.ablebits.com/office-addins-blog/2013/12/12/count-sort-by-color-excel/
'20150520
Function GetCellColor(xlRange As Range)
    Dim indRow, indColumn As Long
    Dim arResults()

    Application.Volatile

    If xlRange Is Nothing Then
        Set xlRange = Application.ThisCell
    End If

    If xlRange.Count > 1 Then
      ReDim arResults(1 To xlRange.Rows.Count, 1 To xlRange.Columns.Count)
       For indRow = 1 To xlRange.Rows.Count
         For indColumn = 1 To xlRange.Columns.Count
           arResults(indRow, indColumn) = xlRange(indRow, indColumn).Interior.Color
         Next
       Next
     GetCellColor = arResults
    Else
     GetCellColor = xlRange.Interior.Color
    End If
End Function

Function GetCellFontColor(xlRange As Range)
    Dim indRow, indColumn As Long
    Dim arResults()

    Application.Volatile

    If xlRange Is Nothing Then
        Set xlRange = Application.ThisCell
    End If

    If xlRange.Count > 1 Then
      ReDim arResults(1 To xlRange.Rows.Count, 1 To xlRange.Columns.Count)
       For indRow = 1 To xlRange.Rows.Count
         For indColumn = 1 To xlRange.Columns.Count
           arResults(indRow, indColumn) = xlRange(indRow, indColumn).Font.Color
         Next
       Next
     GetCellFontColor = arResults
    Else
     GetCellFontColor = xlRange.Font.Color
    End If

End Function

Function CountCellsByColor(rData As Range, cellRefColor As Range) As Long
    Dim indRefColor As Long
    Dim cellCurrent As Range
    Dim cntRes As Long

    Application.Volatile
    cntRes = 0
    indRefColor = cellRefColor.Cells(1, 1).Interior.Color
    For Each cellCurrent In rData
        If indRefColor = cellCurrent.Interior.Color Then
            cntRes = cntRes + 1
        End If
    Next cellCurrent

    CountCellsByColor = cntRes
End Function

Function SumCellsByColor(rData As Range, cellRefColor As Range)
    Dim indRefColor As Long
    Dim cellCurrent As Range
    Dim sumRes

    Application.Volatile
    sumRes = 0
    indRefColor = cellRefColor.Cells(1, 1).Interior.Color
    For Each cellCurrent In rData
        If indRefColor = cellCurrent.Interior.Color Then
            sumRes = WorksheetFunction.Sum(cellCurrent, sumRes)
        End If
    Next cellCurrent

    SumCellsByColor = sumRes
End Function

Function CountCellsByFontColor(rData As Range, cellRefColor As Range) As Long
    Dim indRefColor As Long
    Dim cellCurrent As Range
    Dim cntRes As Long

    Application.Volatile
    cntRes = 0
    indRefColor = cellRefColor.Cells(1, 1).Font.Color
    For Each cellCurrent In rData
        If indRefColor = cellCurrent.Font.Color Then
            cntRes = cntRes + 1
        End If
    Next cellCurrent

    CountCellsByFontColor = cntRes
End Function

Function SumCellsByFontColor(rData As Range, cellRefColor As Range)
    Dim indRefColor As Long
    Dim cellCurrent As Range
    Dim sumRes

    Application.Volatile
    sumRes = 0
    indRefColor = cellRefColor.Cells(1, 1).Font.Color
    For Each cellCurrent In rData
        If indRefColor = cellCurrent.Font.Color Then
            sumRes = WorksheetFunction.Sum(cellCurrent, sumRes)
        End If
    Next cellCurrent

    SumCellsByFontColor = sumRes
End Function


Function bIsCheckTolerant(dblLastData As Double, dblAvgData As Double, dblStdTolerant As Double)
'
' Create Date : 16/06/2014 by Khemmachat
' Modified Date : 3/05/2015 by Khemmachat

    Dim dblDataTolerant As Double

    'Reset Std Tolerant (%) to value that less than 1
    If dblStdTolerant > 1 Then
        dblStdTolerant = dblStdTolerant / 100
    End If

    'Check Is lngAvgData equal to Zero?
    If dblAvgData <> 0 Then
        dblDataTolerant = (dblLastData - dblAvgData) / dblAvgData
    ElseIf dblAvgData = 0 And dblLastData <> 0 Then 'dblAvgData is Zero, but dblLastData isn't Zero
        dblDataTolerant = (dblLastData - 0) / dblLastData
    ElseIf dblLastData = 0 And dblLastData = 0 Then
        dblDataTolerant = 0
    Else
        MsgBox ("Err")
    End If 'dblAvgData


    If Abs(dblDataTolerant) <= dblStdTolerant Then
        bIsCheckTolerant = "Pass"
    Else
        bIsCheckTolerant = "Fail"
    End If 'dblDataTolerant


End Function


Function strConvertToLetter(iCol As Integer) As String
'Created by https://support.microsoft.com/en-us/kb/833402/
'Created date : 20150525

   Dim iAlpha As Integer
   Dim iRemainder As Integer

   iAlpha = Int(iCol / 27)
   iRemainder = iCol - (iAlpha * 26)
   If iAlpha > 0 Then
      strConvertToLetter = Chr(iAlpha + 64)
   End If
   If iRemainder > 0 Then
      strConvertToLetter = strConvertToLetter & Chr(iRemainder + 64)
   End If
End Function


Public Function MyStrExtract(strTmp As String, strLorR As String, strKeyword As String) As String

    Dim lngNumofWord As Long, lngNumofKeyword As Long
    Dim lngPosofkeyword As Long

    lngNumofWord = Len(strTmp)
    lngNumofKeyword = Len(strKeyword)
    ' lngPosofkeyword = InStr(1, strTmp, strKeyword, vbTextCompare)

    If InStr(1, strLorR, "<", vbTextCompare) > 0 Or InStr(1, strLorR, "L", vbTextCompare) > 0 Then
        lngPosofkeyword = InStr(1, strTmp, strKeyword, vbTextCompare)
        MyStrExtract = Mid(strTmp, 1, lngPosofkeyword - 1)
    ElseIf InStr(1, strLorR, ">", vbTextCompare) > 0 Or InStr(1, strLorR, "R", vbTextCompare) > 0 Then
        lngPosofkeyword = InStr(1, strTmp, strKeyword, vbTextCompare) + lngNumofKeyword - 1
        MyStrExtract = Mid(strTmp, lngPosofkeyword + 1, lngNumofWord)
    End If

End Function




Public Function varFindLastMDate3(ByRef rngPMMasterPlan As Range, ByRef rngPMDate As Range, ByRef strPMYear As String, _
    Optional ByRef bShowPMPlan As Boolean = False) As Variant

' Find MajorPMDate for Genedia
' Create Date : 16/06/2014 by Khemmachat
' Modified Date : 26/02/2016 by Khemmachat
' Find Major PM Plan and Return that Major PM Month
' Program search from Jan to Dec to find Major PM Code
' Then, return No. of Month that have Major PM Plan
' and combine with PM Date

Dim strPMCode(1 To 7) As String 'for store valide PM Code of W M 2M Q H Y
Dim intLargePMCodeRank As Integer
Dim intLargePMCodePos As Integer
Dim intRank As Integer
Dim intLargePMCodeDate As Integer
Dim intOffsetMonth As Integer
Dim intPMPlanFirstColumn As Integer

'Dim strTypeofYear As String
Dim strOldYear As String, strNewYear As String
'Dim varNewDate As Variant
Dim varDay As Variant, varMonth As Variant, varYear As Variant

Dim intOffsetColofDateandPlan As Integer
Dim intColOffset As Integer ' Offset Column from first column in selected range that store Largest PM Plan.


'Dim intPMCode(1 To 6) As Integer

' assign initial value
intLargePMCodeRank = 0
intLargePMCodePos = 0
intRank = 0


For i = 1 To 7
    strPMCode(i) = ""
Next i 'for strPMCode

' Store number of first column as Jan
intPMPlanFirstColumn = rngPMMasterPlan.Column

    For Each cell In rngPMMasterPlan.Cells
        Select Case cell 'assign ranking for each found PM Code
            Case "W"
                intRank = 1
                strPMCode(intRank) = "W"
            Case "M"
                intRank = 2
                strPMCode(intRank) = "M"
            Case "2M"
                intRank = 3
                strPMCode(intRank) = "2M"
            Case "Q"
                intRank = 4
                strPMCode(intRank) = "Q"
            Case "4M"
                intRank = 5
                strPMCode(intRank) = "4M"
            Case "H"
                intRank = 6
                strPMCode(intRank) = "H"
            Case "Y"
                intRank = 7
                strPMCode(intRank) = "Y"
            Case Empty
                intRank = 0
        End Select 'rngPMMasterPlan.Cells

        'Store Largest PM Code
        If intRank > intLargePMCodeRank Then
            intLargePMCodeRank = intRank  'Store higher Rank
            intLargePMCodePos = cell.Column 'Store pos of higher Rank, Column Number of Sheet
            intColOffset = intLargePMCodePos - rngPMMasterPlan.Column + 1 'Store pos of higher Rank, Relative Column of range
        End If 'intRank

    Next cell 'of rngPMMasterPlan
'    dateLargePMCodeDate = rngPMDate.Columns(1).Offset(0, intColOffset - 1).Value 'Store Largest PM Date
    intLargePMCodeDate = rngPMDate.Value 'Store Largest PM Date
    intOffsetMonth = intColOffset 'intColOffset is equal to Offset Month, in case of no gap between start month and lastMdate

    ' This function is designed for Offset "MONTH" only, not for "WEEK"

   'Check type of year for A.D. or B.C.
   strOldYear = strPMYear
   If Val(strOldYear) > 2500 Then ' for B.C.
        'strTypeofYear = "BC"
        'Change Year from BC to AD
        strNewYear = Str(Val(strOldYear) - 543)
        varDay = Format(intLargePMCodeDate, "##00")
        varMonth = Format(intColOffset, "##00")
        varYear = Format(strNewYear, "##0000")
        varFindLastMDate3 = varDay + "/" + varMonth + "/" + varYear
    Else ' for A.D.
        'strTypeofYear = "AD"
        strNewYear = Str(Val(strOldYear))
        varDay = Format(intLargePMCodeDate, "##00")
        varMonth = Format(intColOffset, "##00")
        varYear = Format(strNewYear, "##0000")
        varFindLastMDate3 = varDay + "/" + varMonth + "/" + varYear
   End If 'left(dateLargePMCodeDate)
   'Should Return Null when found nothing
   'varFindLastMDate = Format(dateLargePMCodeDate, "yyyymmdd") + "," + Format(intOffsetMonth, "##00")
   For i = 1 To 7
'    varFindLastMDate3 = varFindLastMDate3 + "," + strPMCode(i)
    varFindLastMDate3 = varFindLastMDate3
   Next i 'for strPMCode

   'Show PM Code when bShowPMPlan is True
   If bShowPMPlan = True Then
        For i = 1 To 7
            If i = 1 Then
                varFindLastMDate3 = varFindLastMDate3 + ";" + strPMCode(i)
            Else
                varFindLastMDate3 = varFindLastMDate3 + "," + strPMCode(i)
            End If 'i
        Next i 'for strPMCode
   End If 'bShowPMPlan

   Exit Function

errhandler:
  Exit Function

End Function



'Const SpecialCharacters As String = "!,@,#,$,%,^,&,*,(,),{,[,],1,2,3,4,5,6,7,8,9,0,}"  'modify as needed
Public Function varClearNumSpecChar(ByRef myString As Variant, ByRef SpecialCharacters As Variant)
'Dim myString As String3
Dim newString As Variant
Dim char As Variant
'myString = "!p#*@)k{kdfhouef3829J"
newString = myString
For Each char In Split(SpecialCharacters, ",")
    newString = Replace(newString, char, " ")
Next
varClearNumSpecChar = newString
End Function


Function AlphaNumericOnly(strSource As String) As String
    Dim i As Integer
    Dim strResult As String

    For i = 1 To Len(strSource)
        Select Case Asc(Mid(strSource, i, 1))
            Case 48 To 57: ', 65 To 90, 97 To 122: 'include 32 if you want to include space
                strResult = strResult & Mid(strSource, i, 1)
        End Select
    Next
    AlphaNumericOnly = strResult
End Function


Public Function myFindColumnNo(ByRef strFindText As String, ByRef rngIndexRng As Range, _
    Optional ByRef varDate As Variant = "") As Variant
'
' Create Date : 27/06/2018 by Khemmachat, Upd 27/06/2018 by Khemmachat
'
'

  Dim cell As Range
  Dim lngCol As Long, lngFirstColInRange As Long
  Dim lngSearchCol As Long
  Dim intSearchDirection As Integer


' Find Column Number of first cell in Range
  lngFirstColInRange = rngIndexRng.Cells(1, 1).Column

' Default search direction is left to right
  intSearchDirection = 1 'xlNext

' Find last column in rngIndexRng
' Set default search column to start with last cell in range
' Because Find formula start searching at second cell, then set start cell to last and roll back
  lngSearchCol = rngIndexRng.Count

' Optional if varDate has value (start searching date) then define lngSearchCol to Week of varDate
  If varDate <> "" Then
    lngSearchCol = myFindWeekNo(varDate) + 1 ' Plus with 1 to let search in its week too
    intSearchDirection = 2 'xlPrevious
  End If 'varDate

'  Find the column that contain the reference word
  On Error GoTo errhandler
  With rngIndexRng
        Set cell = .Find(what:=strFindText, LookIn:=xlValues, after:=.Cells(1, lngSearchCol), searchdirection:=intSearchDirection)

    If Not cell Is Nothing Then
        lngCol = cell.Column

        myFindColumnNo = lngCol - lngFirstColInRange + 1
        Exit Function
    Else
        myFindColumnNo = "Not Found"
        Exit Function
    End If ' Not Cell

  End With ' rngIndexCol

  Exit Function
errhandler:
  Exit Function

End Function


Public Function myFindWeekNo(ByRef varDate As Variant) As Variant
'
' Create Date : 27/06/2018 by Khemmachat, Upd 27/06/2018 by Khemmachat
'
'

  Dim intDate As Integer, intMonth As Integer
  Dim intWeekNo As Integer, intWeekNofromDate As Integer

'  Find Date, Month and Year
  intDate = Day(varDate)
  intMonth = Month(varDate)
'  intYear = Year(varDate)

  If intDate < 28 Then
    intWeekNofromDate = intDate / 7
  Else
    intWeekNofromDate = 4
  End If 'intDate

  intWeekNo = (intMonth - 1) * 4 + intWeekNofromDate

  myFindWeekNo = intWeekNo


End Function



Public Function varFindEvoLastMDate(ByRef strFindText As String, ByRef rngIndexRng As Range, _
    Optional ByRef varCurrentDate As Variant = "", Optional ByRef intPMDate As Integer = 0) As Variant
'
' Create Date : 27/06/2018 by Khemmachat, Upd 27/06/2018 by Khemmachat
'
'

  Dim intDate As Integer, intMonth As Integer, intYear As Integer
  Dim intWeekNoYear As Integer, intWeekNofromDate As Integer
  Dim intWeekNoMonth As Integer
  Dim intCurrentWeek As Integer

' Find Week Number of first searching PM Plan from right to left
  intWeekNoYear = myFindColumnNo(strFindText, rngIndexRng, varCurrentDate)

' Calculate Month
  intMonth = WorksheetFunction.Ceiling(intWeekNoYear / 4, 1)

' Find Week Number of Month
  intWeekNoMonth = intWeekNoYear - (intMonth - 1) * 4

' Calculate PM Date by using Week Number of Month
  If intPMDate = 0 Then 'No Predefine PM Date then Assume PM Date
    Select Case intWeekNoMonth
      Case 1
        intDate = 1
      Case 2
        intDate = 8
      Case 3
        intDate = 15
      Case 4
        intDate = 22
    End Select
  Else
    intDate = intPMDate
  End If 'intPMDate

'  Find Current Year
  intCurrentWeek = myFindWeekNo(varCurrentDate)
  If intWeekNoYear > intCurrentWeek Then
    intYear = Year(varCurrentDate) - 1
  Else
    intYear = Year(varCurrentDate)
  End If 'intWeekNoYear


  varFindEvoLastMDate = intDate & "/" & intMonth & "/" & intYear

End Function




Public Function varFindMonthlyPMdate(ByRef strFindText As String, ByRef rngIndexRng As Range, _
    Optional ByRef intPMDate As Integer = 0) As Variant


  Dim cell As Range
  Dim lngCol As Long, lngFirstColInRange As Long
  Dim lngSearchCol As Long
  Dim intSearchDirection As Integer


' Find Column Number of first cell in Range
  lngFirstColInRange = rngIndexRng.Cells(1, 1).Column

' Default search direction is left to right
  intSearchDirection = 1 'xlNext

' Find last column in rngIndexRng
' Set default search column to start with last cell in range
' Because Find formula start searching at second cell, then set start cell to last and roll back
  lngSearchCol = rngIndexRng.Count

'  Find the column that contain the reference word
  On Error GoTo errhandler
  With rngIndexRng
        Set cell = .Find(what:=strFindText, LookIn:=xlValues, after:=.Cells(1, lngSearchCol), searchdirection:=lngSearchDirection)

    If Not cell Is Nothing Then
        lngCol = cell.Column

        varFindMonthlyPMdate = lngCol - lngFirstColInRange + 1
        Exit Function
    Else
        varFindMonthlyPMdate = "Not Found"
        Exit Function
    End If ' Not Cell

  End With ' rngIndexCol

Exit Function

errhandler:
  Exit Function


End Function


Public Function varFindFloorFromString(ByRef strFloor As String, Optional ByRef strLeft As String = "", _
Optional ByRef strRight As String = "", Optional ByRef strReplace As String = "") As Variant
' Modify by Khemmachat at 2/6/2020

Dim strTemp As String

If IsNumeric(strFloor) Then
    strTemp = strFloor
Else
    If strLeft = "" And strRight = "" Then
        strTemp = strFloor
    ElseIf strLeft = "" And strRight <> "" Then
        strTemp = MyStrExtract(strFloor, "<", strRight)
    ElseIf strLeft <> "" And strRight = "" Then
        strTemp = MyStrExtract(strFloor, ">", strLeft)
    ElseIf strLeft <> "" And strRight <> "" Then
        strTemp = MyStrExtract(MyStrExtract(strFloor, ">", strLeft), "<", strRight)
    End If

End If 'IsNumeric(strFloor)

If Len(strTemp) = 1 Or InStr(strTemp, "oof") <> 0 Or InStr(strTemp, "B") <> 0 Then  'Roof,B
    strTemp = Trim(strTemp)
    Else
    L = Len(strTemp)
    temp = ""
    For i = 1 To L
        c = Mid(strTemp, i, 1)
        If c Like "[0-9]" Then
            temp = temp & c
        Else
            temp = temp & " "
        End If
    Next i
    strTemp = temp
End If 'len

If strReplace <> "" Then
    strTemp = Replace(strTemp, strReplace, "")
End If 'strReplace <> ""

If IsNumeric(strTemp) Then
    varFindFloorFromString = Val(Trim(strTemp))
ElseIf Len(strTemp) = 1 Or InStr(strTemp, "oof") <> 0 Or InStr(strTemp, "B") <> 0 Then
    varFindFloorFromString = Trim(strTemp)
Else
    varFindFloorFromString = "Not Number"
End If 'IsNumeric(strTemp)


errhandler:
  Exit Function

End Function


Sub subFormatPMCode()
'
' Macro1 Macro
'

'
    Selection.FormatConditions.Add Type:=xlTextString, String:="M", _
        TextOperator:=xlContains
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .Color = 65535
        .TintAndShade = 0
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlTextString, String:="2M", _
        TextOperator:=xlContains
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent6
        .TintAndShade = 0.799981688894314
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlTextString, String:="Q", _
        TextOperator:=xlContains
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent5
        .TintAndShade = 0.799981688894314
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlTextString, String:="H", _
        TextOperator:=xlContains
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent4
        .TintAndShade = 0.799981688894314
    End With
    Selection.FormatConditions(1).StopIfTrue = False
    Selection.FormatConditions.Add Type:=xlTextString, String:="Y", _
        TextOperator:=xlContains
    Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
    With Selection.FormatConditions(1).Interior
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent3
        .TintAndShade = 0.799981688894314
    End With
    Selection.FormatConditions(1).StopIfTrue = False
End Sub



'////////// Last Updated on 28/05/2019 by KCM ////////////////////
