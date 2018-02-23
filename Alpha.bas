Sub compileByPath()

Dim FolderPath As String
Dim PathCountCondition As String
Dim FileName As String
Dim Count As Integer
Dim FileNumber As Integer
Dim MainWB As Workbook
Dim WB As Workbook
Dim Rng As Range
Dim RngNoPath As String
Dim StartTime As Double
Dim SecondsElapsed As Double
Dim tickersPerSec As Double
Dim SummaryRng As Range

StartTime = Timer

'set this workbook as the main workbook

Set MainWB = ActiveWorkbook
MainWB.Sheets.Add.Name = "PathSet"
Set Rng = Range("A1")

Application.DisplayAlerts = False

'define folder path
FolderPath = "C:\Users\m4k04\Desktop\stock_dfs"

'count number of CSVs in folder

PathCountCondition = FolderPath & "\*.csv"

FileName = Dir(PathCountCondition)

Do While FileName <> ""
    Count = Count + 1
    FileName = Dir()
    Rng.Value = FileName
    Rng.Offset(1, 0).Select
    Set Rng = ActiveCell
Loop

Worksheets("PathSet").Activate
Set Rng = Range("A1")
Rng.Select
Range(Selection, Selection.End(xlDown)).Select
Count = Selection.Rows.Count

'create summary page
MainWB.Sheets.Add.Name = "Summary"
Call createSummaryPage
SummaryRng = Worksheets("Summary").Range("A3")

MainWB.Activate
Rng.Select

For FileNumber = 1 To 10 'you can change count to a constant for sample runs
    
    'open the file
    
    FileName = FolderPath & "\" & Rng
    
    Set WB = Workbooks.Open(FileName)
    
    'copy its contents
    
    WB.Activate
    Range("A1").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy

    'create new sheet, and paste it into the main workbook
    
    MainWB.Activate
    RngNoPath = Left(Rng, Len(Rng) - 4)
    MainWB.Sheets.Add.Name = RngNoPath
    Range("A1").Select
    ActiveSheet.Paste
    Selection.Columns.AutoFit
    Range("A1").Select
    
    'close file
    WB.Close
    
    Call manipulateData
    
    ''
    'POPULATE SUMMARY PAGE HERE
    Worksheets("Summary").Activate
    '
    
    
    'Worksheets("PathSet").Activate
    
    Worksheets("PathSet").Activate
    Rng.Offset(1, 0).Select
    Set Rng = ActiveCell
    
Next FileNumber
                                        
'tell me how long it took
SecondsElapsed = Round(Timer - StartTime, 2)
tickersPerSec = Round(Count / SecondsElapsed, 2)
MsgBox "This code ran successfully in " & SecondsElapsed & " seconds" & vbCrLf & "Approximately " & tickersPerSec & "per second", vbInformation
                                        
End Sub

Function createSummaryPage()
    Dim Rng As Range

'top headers
    Range("A1:D1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Description"

    Range("E1:G1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Volume"
    
    Range("H1:M1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Previous Close to Close"
    
    Range("N1:S1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Previous Open to Open"
    
    Range("T1:Y1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Previous Close to Open"
        
    Range("Z1:AE1").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Intraday Open to Close"
    
'Sub headers
    Range("E2:G2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Actual"
    
    Range("H2:J2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Actual"
    
    Range("K2:M2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Percent"
    
    Range("N2:P2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Actual"
    
    Range("Q2:S2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Percent"
    
    Range("T2:V2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Actual"
    
    Range("W2:Y2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Percent"
    
    Range("Z2:AB2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Actual"
    
    Range("AC2:AE2").Select
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Percent"
    
'Line headers

    Set Rng = Range("A3")
    Rng.Value = "Symbol"
    Rng.Offset(0, 1) = "Date Data Start"
    Rng.Offset(0, 2) = "Date Data End"
    Rng.Offset(0, 3) = "Sample Size"
    Rng.Offset(0, 4) = "Minimum"
    Rng.Offset(0, 5) = "Maximum"
    Rng.Offset(0, 6) = "Average"
    Rng.Offset(0, 7) = "Minimum"
    Rng.Offset(0, 8) = "Maximum"
    Rng.Offset(0, 9) = "Average"
    Rng.Offset(0, 10) = "Minimum"
    Rng.Offset(0, 11) = "Maximum"
    Rng.Offset(0, 12) = "Average"
    Rng.Offset(0, 13) = "Minimum"
    Rng.Offset(0, 14) = "Maximum"
    Rng.Offset(0, 15) = "Average"
    Rng.Offset(0, 16) = "Minimum"
    Rng.Offset(0, 17) = "Maximum"
    Rng.Offset(0, 18) = "Average"
    Rng.Offset(0, 19) = "Minimum"
    Rng.Offset(0, 20) = "Maximum"
    Rng.Offset(0, 21) = "Average"
    Rng.Offset(0, 22) = "Minimum"
    Rng.Offset(0, 23) = "Maximum"
    Rng.Offset(0, 24) = "Average"
    Rng.Offset(0, 25) = "Minimum"
    Rng.Offset(0, 26) = "Maximum"
    Rng.Offset(0, 27) = "Average"
    Rng.Offset(0, 28) = "Minimum"
    Rng.Offset(0, 29) = "Maximum"
    Rng.Offset(0, 30) = "Average"

'center and auto-width those three rows
    
    Range("A1:AE3").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
    End With
    Selection.Columns.AutoFit
    
'big borders
    Range("D:D,G:G,M:M,S:S,Y:Y,AE:AE").Select
    Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    Selection.Borders(xlEdgeLeft).LineStyle = xlNone
    Selection.Borders(xlEdgeTop).LineStyle = xlNone
    Selection.Borders(xlEdgeBottom).LineStyle = xlNone
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = xlAutomatic
        .TintAndShade = 0
        .Weight = xlMedium
    End With
    Selection.Borders(xlInsideVertical).LineStyle = xlNone
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone

Range("A1").Select

    
End Function
Function orderDataForGraphing()
    
    'order the columns for graphing

    Columns("A:A").Select
    Selection.Delete Shift:=xlToLeft
    Columns("B:B").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Columns("K:K").Select
    Selection.Cut
    Columns("B:B").Select
    ActiveSheet.Paste
    Columns("J:J").Select
    Selection.Cut
    Columns("C:C").Select
    ActiveSheet.Paste
    Columns("H:H").Select
    Selection.Cut
    Columns("D:D").Select
    ActiveSheet.Paste
    Columns("I:I").Select
    Selection.Cut
    Columns("E:E").Select
    ActiveSheet.Paste
    Columns("G:G").Select
    Application.CutCopyMode = False
    Selection.Cut
    Columns("F:F").Select
    ActiveSheet.Paste
    
    'add commas and dollar signs
    
    Range("B2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Style = "Comma"
    Selection.NumberFormat = "_(* #,##0.0_);_(* (#,##0.0);_(* ""-""??_);_(@_)"
    Selection.NumberFormat = "_(* #,##0_);_(* (#,##0);_(* ""-""??_);_(@_)"
    Range("C2").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Style = "Currency"
    Range("A1").Select
    
End Function
Function manipulateData()
    Dim Rng As Range
    Dim LastRow As Integer
    
    'find the last row
    
    Range("A1").Select
    Range(Selection, Selection.End(xlDown)).Select
    LastRow = Selection.Rows.Count
    
    'day average average
    Range("G1").Select
    ActiveCell.FormulaR1C1 = "Day Average"
    Range("G2").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=AVERAGE(RC[-4]:RC[-1])"
    Range("G2").Select
    Selection.AutoFill Destination:=Range("G2:G" & LastRow)
    
    'data manipulations
    Range("H1").Value = "Previous Close to Close"
    Range("H3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-2]-R[-1]C[-2]"
    Range("I3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]/R[-1]C[-3]"
    Range("J1").Value = "Previous Open to Open"
    Range("J3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-7]-R[-1]C[-7]"
    Range("K3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]/R[-1]C[-8]"
    Range("L1").Value = "Previous Close to Open"
    Range("L3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-9]-R[-1]C[-6]"
    Range("M3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]/R[-1]C[-7]"
    Range("N1").Value = "Intraday Open to Close"
    Range("N3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-8]-RC[-11]"
    Range("O3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]/RC[-9]"
    Range("H3:O3").Select
    Selection.AutoFill Destination:=Range("H3:O" & LastRow)
    Range("I:I,K:K,M:M,O:O").Select
    Selection.Style = "Percent"
    Selection.NumberFormat = "0.000%"
   
End Function