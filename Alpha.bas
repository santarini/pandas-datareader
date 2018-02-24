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
'Call createSummaryPage
Set SummaryRng = Worksheets("Summary").Range("A4")

Worksheets("PathSet").Activate
Rng.Select

For FileNumber = 1 To Count 'you can change count to a constant for sample runs
    
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
    
    Call orderDataForGraphing
    Call manipulateData
    
    'POPULATE SUMMARY PAGE HERE
    Call populateSummary(SummaryRng)
    Worksheets("Summary").Activate
    SummaryRng.Offset(1, 0).Select
    Set SummaryRng = Selection
    
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
Function populateSummary(SummaryRng As Range)

    Dim WS As Worksheet
    Dim StartDate, EndDate As Date
    Dim Count, LastRow As Integer
    Dim VolNActual, VolMinimumActual, VolFirstQuintileActual, VolFirstDecileActual, VolLowerQuartileActual, VolMedianActual, VolUpperQuartileActual, VolLastDecileActual, VolLastQuintileActual, VolMaximumActual, VolModeActual, VolArithmeticMeanActual, VolVarianceActual, VolStandardDeviationActual, VolCoefficientOfVariationActual, VolKurtosisActual, VolSkewnessActual As Double
    Dim CtoCNActual, CtoCMinimumActual, CtoCFirstQuintileActual, CtoCFirstDecileActual, CtoCLowerQuartileActual, CtoCMedianActual, CtoCUpperQuartileActual, CtoCLastDecileActual, CtoCLastQuintileActual, CtoCMaximumActual, CtoCModeActual, CtoCArithmeticMeanActual, CtoCVarianceActual, CtoCStandardDeviationActual, CtoCCoefficientOfVariationActual, CtoCKurtosisActual, CtoCSkewnessActual, CtoCNPercent, CtoCMinimumPercent, CtoCFirstQuintilePercent, CtoCFirstDecilePercent, CtoCLowerQuartilePercent, CtoCMedianPercent, CtoCUpperQuartilePercent, CtoCLastDecilePercent, CtoCLastQuintilePercent, CtoCMaximumPercent, CtoCModePercent, CtoCArithmeticMeanPercent, CtoCVariancePercent, CtoCStandardDeviationPercent, CtoCCoefficientOfVariationPercent, CtoCKurtosisPercent, CtoCSkewnessPercent As Double
    Dim OtoONActual, OtoOMinimumActual, OtoOFirstQuintileActual, OtoOFirstDecileActual, OtoOLowerQuartileActual, OtoOMedianActual, OtoOUpperQuartileActual, OtoOLastDecileActual, OtoOLastQuintileActual, OtoOMaximumActual, OtoOModeActual, OtoOArithmeticMeanActual, OtoOVarianceActual, OtoOStandardDeviationActual, OtoOCoefficientOfVariationActual, OtoOKurtosisActual, OtoOSkewnessActual, OtoONPercent, OtoOMinimumPercent, OtoOFirstQuintilePercent, OtoOFirstDecilePercent, OtoOLowerQuartilePercent, OtoOMedianPercent, OtoOUpperQuartilePercent, OtoOLastDecilePercent, OtoOLastQuintilePercent, OtoOMaximumPercent, OtoOModePercent, OtoOArithmeticMeanPercent, OtoOVariancePercent, OtoOStandardDeviationPercent, OtoOCoefficientOfVariationPercent, OtoOKurtosisPercent, OtoOSkewnessPercent As Double
    Dim OtoCNActual, OtoCMinimumActual, OtoCFirstQuintileActual, OtoCFirstDecileActual, OtoCLowerQuartileActual, OtoCMedianActual, OtoCUpperQuartileActual, OtoCLastDecileActual, OtoCLastQuintileActual, OtoCMaximumActual, OtoCModeActual, OtoCArithmeticMeanActual, OtoCVarianceActual, OtoCStandardDeviationActual, OtoCCoefficientOfVariationActual, OtoCKurtosisActual, OtoCSkewnessActual, OtoCNPercent, OtoCMinimumPercent, OtoCFirstQuintilePercent, OtoCFirstDecilePercent, OtoCLowerQuartilePercent, OtoCMedianPercent, OtoCUpperQuartilePercent, OtoCLastDecilePercent, OtoCLastQuintilePercent, OtoCMaximumPercent, OtoCModePercent, OtoCArithmeticMeanPercent, OtoCVariancePercent, OtoCStandardDeviationPercent, OtoCCoefficientOfVariationPercent, OtoCKurtosisPercent, OtoCSkewnessPercent As Double
    Dim Rng As Range
    
    Set WS = ActiveSheet
    
    WS.Activate
    
    'get dates
    Set Rng = Range("A2")
    Rng.Select
    StartDate = Selection
    Selection.End(xlDown).Select
    EndDate = Selection

    'paste dates
    Worksheets("Summary").Activate
    SummaryRng.Value = WS.Name
    SummaryRng.Offset(0, 1).Value = StartDate
    SummaryRng.Offset(0, 2).Value = EndDate
    
    'define volume actual range
    WS.Activate
    Range("B2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate volume actual stats
    VolN = LastRow
    VolMinimumVal = Application.WorksheetFunction.Min(Rng)
    VolFirstQuintile = Application.WorksheetFunction.Percentile(Rng, 0.05)
    VolFirstDecile = Application.WorksheetFunction.Percentile(Rng, 0.1)
    VolLowerQuartile = Application.WorksheetFunction.Percentile(Rng, 0.25)
    VolMedian = Application.WorksheetFunction.Median(Rng)
    VolUpperQuartile = Application.WorksheetFunction.Percentile(Rng, 0.75)
    VolLastDecile = Application.WorksheetFunction.Percentile(Rng, 0.9)
    VolLastQuintile = Application.WorksheetFunction.Percentile(Rng, 0.95)
    VolMaximumVal = Application.WorksheetFunction.Max(Rng)
    VolModeVal = Application.WorksheetFunction.Mode(Rng)
    VolArithmeticMean = Application.WorksheetFunction.Average(Rng)
    VolStandardDeviation = Application.WorksheetFunction.StDev_P(Rng)
    VolVariance = VolStandardDeviation * VolStandardDeviation
    VolCoefficientOfVariation = VolStandardDeviation / VolArithmeticMean
    VolKurtosis = Application.WorksheetFunction.Kurt(Rng)
    VolSkewness = Application.WorksheetFunction.Skew_p(Rng)

    'paste volume actual stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 3).Value = VolN
    SummaryRng.Offset(0, 4).Value = VolMinimumVal
    SummaryRng.Offset(0, 5).Value = VolFirstQuintile
    SummaryRng.Offset(0, 6).Value = VolFirstDecile
    SummaryRng.Offset(0, 7).Value = VolLowerQuartile
    SummaryRng.Offset(0, 8).Value = VolMedian
    SummaryRng.Offset(0, 9).Value = VolUpperQuartile
    SummaryRng.Offset(0, 10).Value = VolLastDecile
    SummaryRng.Offset(0, 11).Value = VolLastQuintile
    SummaryRng.Offset(0, 12).Value = VolMaximumVal
    SummaryRng.Offset(0, 13).Value = VolModeVal
    SummaryRng.Offset(0, 14).Value = VolArithmeticMean
    SummaryRng.Offset(0, 15).Value = VolVariance
    SummaryRng.Offset(0, 16).Value = VolStandardDeviation
    SummaryRng.Offset(0, 17).Value = VolCoefficientOfVariation
    SummaryRng.Offset(0, 18).Value = VolKurtosis
    SummaryRng.Offset(0, 19).Value = VolSkewness


    
    
    
    'define Previous Close to Close actual Range
    WS.Activate
    Range("H3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Close to Close actual stats
    CtoCNActual = LastRow
    CtoCMinimumValActual = Application.WorksheetFunction.Min(Rng)
    CtoCFirstQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.05)
    CtoCFirstDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.1)
    CtoCLowerQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.25)
    CtoCMedianActual = Application.WorksheetFunction.Median(Rng)
    CtoCUpperQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.75)
    CtoCLastDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.9)
    CtoCLastQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.95)
    CtoCMaximumValActual = Application.WorksheetFunction.Max(Rng)
    CtoCModeValActual = Application.WorksheetFunction.Mode(Rng)
    CtoCArithmeticMeanActual = Application.WorksheetFunction.Average(Rng)
    CtoCStandardDeviationActual = Application.WorksheetFunction.StDev_P(Rng)
    CtoCVarianceActual = CtoCStandardDeviationActual * CtoCStandardDeviationActual
    CtoCCoefficientOfVariationActual = CtoCStandardDeviationActual / CtoCArithmeticMeanActual
    CtoCKurtosisActual = Application.WorksheetFunction.Kurt(Rng)
    CtoCSkewnessActual = Application.WorksheetFunction.Skew_p(Rng)

    'paste Previous Close to Close actual stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 20).Value = CtoCNActual
    SummaryRng.Offset(0, 21).Value = CtoCMinimumValActual
    SummaryRng.Offset(0, 22).Value = CtoCFirstQuintileActual
    SummaryRng.Offset(0, 23).Value = CtoCFirstDecileActual
    SummaryRng.Offset(0, 24).Value = CtoCLowerQuartileActual
    SummaryRng.Offset(0, 25).Value = CtoCMedianActual
    SummaryRng.Offset(0, 26).Value = CtoCUpperQuartileActual
    SummaryRng.Offset(0, 27).Value = CtoCLastDecileActual
    SummaryRng.Offset(0, 28).Value = CtoCLastQuintileActual
    SummaryRng.Offset(0, 29).Value = CtoCMaximumValActual
    SummaryRng.Offset(0, 30).Value = CtoCModeValActual
    SummaryRng.Offset(0, 31).Value = CtoCArithmeticMeanActual
    SummaryRng.Offset(0, 32).Value = CtoCVarianceActual
    SummaryRng.Offset(0, 33).Value = CtoCStandardDeviationActual
    SummaryRng.Offset(0, 34).Value = CtoCCoefficientOfVariationActual
    SummaryRng.Offset(0, 35).Value = CtoCKurtosisActual
    SummaryRng.Offset(0, 36).Value = CtoCSkewnessActual

    
    'define Previous Close to Close percent Range
    WS.Activate
    Range("I3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Close to Close percent stats
    CtoCNPercent = LastRow
    CtoCMinimumValPercent = Application.WorksheetFunction.Min(Rng)
    CtoCFirstQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.05)
    CtoCFirstDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.1)
    CtoCLowerQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.25)
    CtoCMedianPercent = Application.WorksheetFunction.Median(Rng)
    CtoCUpperQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.75)
    CtoCLastDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.9)
    CtoCLastQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.95)
    CtoCMaximumValPercent = Application.WorksheetFunction.Max(Rng)
    CtoCArithmeticMeanPercent = Application.WorksheetFunction.Average(Rng)
    CtoCStandardDeviationPercent = Application.WorksheetFunction.StDev_P(Rng)
    CtoCVariancePercent = CtoCStandardDeviationPercent * CtoCStandardDeviationPercent
    CtoCCoefficientOfVariationPercent = CtoCStandardDeviationPercent / CtoCArithmeticMeanPercent
    CtoCKurtosisPercent = Application.WorksheetFunction.Kurt(Rng)
    CtoCSkewnessPercent = Application.WorksheetFunction.Skew_p(Rng)

    'paste Previous Close to Close percent stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 37).Value = CtoCNPercent
    SummaryRng.Offset(0, 38).Value = CtoCMinimumValPercent
    SummaryRng.Offset(0, 39).Value = CtoCFirstQuintilePercent
    SummaryRng.Offset(0, 40).Value = CtoCFirstDecilePercent
    SummaryRng.Offset(0, 41).Value = CtoCLowerQuartilePercent
    SummaryRng.Offset(0, 42).Value = CtoCMedianPercent
    SummaryRng.Offset(0, 43).Value = CtoCUpperQuartilePercent
    SummaryRng.Offset(0, 44).Value = CtoCLastDecilePercent
    SummaryRng.Offset(0, 45).Value = CtoCLastQuintilePercent
    SummaryRng.Offset(0, 46).Value = CtoCMaximumValPercent
    SummaryRng.Offset(0, 47).Value = CtoCModeValPercent
    SummaryRng.Offset(0, 48).Value = CtoCArithmeticMeanPercent
    SummaryRng.Offset(0, 49).Value = CtoCVariancePercent
    SummaryRng.Offset(0, 50).Value = CtoCStandardDeviationPercent
    SummaryRng.Offset(0, 51).Value = CtoCCoefficientOfVariationPercent
    SummaryRng.Offset(0, 52).Value = CtoCKurtosisPercent
    SummaryRng.Offset(0, 53).Value = CtoCSkewnessPercent




    'define Previous Open to Open actual Range
    WS.Activate
    Range("J3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Open to Open actual stats
    OtoONActual = LastRow
    OtoOMinimumValActual = Application.WorksheetFunction.Min(Rng)
    OtoOFirstQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.05)
    OtoOFirstDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.1)
    OtoOLowerQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.25)
    OtoOMedianActual = Application.WorksheetFunction.Median(Rng)
    OtoOUpperQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.75)
    OtoOLastDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.9)
    OtoOLastQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.95)
    OtoOMaximumValActual = Application.WorksheetFunction.Max(Rng)
    OtoOModeValActual = Application.WorksheetFunction.Mode(Rng)
    OtoOArithmeticMeanActual = Application.WorksheetFunction.Average(Rng)
    OtoOVarianceActual = OtoOStandardDeviationActual * OtoOStandardDeviationActual
    OtoOCoefficientOfVariationActual = OtoOStandardDeviationActual / OtoOArithmeticMeanActual
    OtoOStandardDeviationActual = Application.WorksheetFunction.StDev_P(Rng)
    OtoOKurtosisActual = Application.WorksheetFunction.Kurt(Rng)
    OtoOSkewnessActual = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Previous Open to Open actual stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 54).Value = OtoONActual
    SummaryRng.Offset(0, 55).Value = OtoOMinimumValActual
    SummaryRng.Offset(0, 56).Value = OtoOFirstQuintileActual
    SummaryRng.Offset(0, 57).Value = OtoOFirstDecileActual
    SummaryRng.Offset(0, 58).Value = OtoOLowerQuartileActual
    SummaryRng.Offset(0, 59).Value = OtoOMedianActual
    SummaryRng.Offset(0, 60).Value = OtoOUpperQuartileActual
    SummaryRng.Offset(0, 61).Value = OtoOLastDecileActual
    SummaryRng.Offset(0, 62).Value = OtoOLastQuintileActual
    SummaryRng.Offset(0, 63).Value = OtoOMaximumValActual
    SummaryRng.Offset(0, 64).Value = OtoOModeValActual
    SummaryRng.Offset(0, 65).Value = OtoOArithmeticMeanActual
    SummaryRng.Offset(0, 66).Value = OtoOVarianceActual
    SummaryRng.Offset(0, 67).Value = OtoOStandardDeviationActual
    SummaryRng.Offset(0, 68).Value = OtoOCoefficientOfVariationActual
    SummaryRng.Offset(0, 69).Value = OtoOKurtosisActual
    SummaryRng.Offset(0, 70).Value = OtoOSkewnessActual


    'define Previous Open to Open percent Range
    WS.Activate
    Range("K3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Open to Open percent stats
    OtoONPercent = LastRow
    OtoOMinimumValPercent = Application.WorksheetFunction.Min(Rng)
    OtoOFirstQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.05)
    OtoOFirstDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.1)
    OtoOLowerQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.25)
    OtoOMedianPercent = Application.WorksheetFunction.Median(Rng)
    OtoOUpperQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.75)
    OtoOLastDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.9)
    OtoOLastQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.95)
    OtoOMaximumValPercent = Application.WorksheetFunction.Max(Rng)
    OtoOModeValPercent = Application.WorksheetFunction.Mode(Rng)
    OtoOArithmeticMeanPercent = Application.WorksheetFunction.Average(Rng)
    OtoOStandardDeviationPercent = Application.WorksheetFunction.StDev_P(Rng)
    OtoOVariancePercent = OtoOStandardDeviationPercent * OtoOStandardDeviationPercent
    OtoOCoefficientOfVariationPercent = OtoOStandardDeviationPercent / OtoOArithmeticMeanPercent
    OtoOKurtosisPercent = Application.WorksheetFunction.Kurt(Rng)
    OtoOSkewnessPercent = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Previous Open to Open percent stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 71).Value = OtoONPercent
    SummaryRng.Offset(0, 72).Value = OtoOMinimumValPercent
    SummaryRng.Offset(0, 73).Value = OtoOFirstQuintilePercent
    SummaryRng.Offset(0, 74).Value = OtoOFirstDecilePercent
    SummaryRng.Offset(0, 75).Value = OtoOLowerQuartilePercent
    SummaryRng.Offset(0, 76).Value = OtoOMedianPercent
    SummaryRng.Offset(0, 77).Value = OtoOUpperQuartilePercent
    SummaryRng.Offset(0, 78).Value = OtoOLastDecilePercent
    SummaryRng.Offset(0, 79).Value = OtoOLastQuintilePercent
    SummaryRng.Offset(0, 80).Value = OtoOMaximumValPercent
    SummaryRng.Offset(0, 81).Value = OtoOModeValPercent
    SummaryRng.Offset(0, 82).Value = OtoOArithmeticMeanPercent
    SummaryRng.Offset(0, 83).Value = OtoOVariancePercent
    SummaryRng.Offset(0, 84).Value = OtoOStandardDeviationPercent
    SummaryRng.Offset(0, 85).Value = OtoOCoefficientOfVariationPercent
    SummaryRng.Offset(0, 86).Value = OtoOKurtosisPercent
    SummaryRng.Offset(0, 87).Value = OtoOSkewnessPercent



    'define Previous Close to Open actual Range
    WS.Activate
    Range("L3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Close to Open actual stats
    CtoONActual = LastRow
    CtoOMinimumValActual = Application.WorksheetFunction.Min(Rng)
    CtoOFirstQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.05)
    CtoOFirstDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.1)
    CtoOLowerQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.25)
    CtoOMedianActual = Application.WorksheetFunction.Median(Rng)
    CtoOUpperQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.75)
    CtoOLastDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.9)
    CtoOLastQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.95)
    CtoOMaximumValActual = Application.WorksheetFunction.Max(Rng)
    CtoOModeValActual = Application.WorksheetFunction.Mode(Rng)
    CtoOArithmeticMeanActual = Application.WorksheetFunction.Average(Rng)
    CtoOStandardDeviationActual = Application.WorksheetFunction.StDev_P(Rng)
    CtoOVarianceActual = CtoOStandardDeviationActual * CtoOStandardDeviationActual
    CtoOCoefficientOfVariationActual = CtoOStandardDeviationActual / CtoOArithmeticMeanActual
    CtoOKurtosisActual = Application.WorksheetFunction.Kurt(Rng)
    CtoOSkewnessActual = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Previous Close to Open actual stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 88).Value = CtoONActual
    SummaryRng.Offset(0, 89).Value = CtoOMinimumValActual
    SummaryRng.Offset(0, 90).Value = CtoOFirstQuintileActual
    SummaryRng.Offset(0, 91).Value = CtoOFirstDecileActual
    SummaryRng.Offset(0, 92).Value = CtoOLowerQuartileActual
    SummaryRng.Offset(0, 93).Value = CtoOMedianActual
    SummaryRng.Offset(0, 94).Value = CtoOUpperQuartileActual
    SummaryRng.Offset(0, 95).Value = CtoOLastDecileActual
    SummaryRng.Offset(0, 96).Value = CtoOLastQuintileActual
    SummaryRng.Offset(0, 97).Value = CtoOMaximumValActual
    SummaryRng.Offset(0, 98).Value = CtoOModeValActual
    SummaryRng.Offset(0, 99).Value = CtoOArithmeticMeanActual
    SummaryRng.Offset(0, 100).Value = CtoOVarianceActual
    SummaryRng.Offset(0, 101).Value = CtoOStandardDeviationActual
    SummaryRng.Offset(0, 102).Value = CtoOCoefficientOfVariationActual
    SummaryRng.Offset(0, 103).Value = CtoOKurtosisActual
    SummaryRng.Offset(0, 104).Value = CtoOSkewnessActual



    'define Previous Close to Open percent Range
    WS.Activate
    Range("M3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Close to Open percent stats
    CtoONPercent = LastRow
    CtoOMinimumValPercent = Application.WorksheetFunction.Min(Rng)
    CtoOFirstQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.05)
    CtoOFirstDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.1)
    CtoOLowerQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.25)
    CtoOMedianPercent = Application.WorksheetFunction.Median(Rng)
    CtoOUpperQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.75)
    CtoOLastDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.9)
    CtoOLastQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.95)
    CtoOMaximumValPercent = Application.WorksheetFunction.Max(Rng)
    CtoOModeValPercent = Application.WorksheetFunction.Mode(Rng)
    CtoOArithmeticMeanPercent = Application.WorksheetFunction.Average(Rng)
    CtoOStandardDeviationPercent = Application.WorksheetFunction.StDev_P(Rng)
    CtoOVariancePercent = CtoOStandardDeviationPercent * CtoOStandardDeviationPercent
    CtoOCoefficientOfVariationPercent = CtoOStandardDeviationPercent / CtoOArithmeticMeanPercent
    CtoOKurtosisPercent = Application.WorksheetFunction.Kurt(Rng)
    CtoOSkewnessPercent = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Previous Close to Open percent stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 105).Value = CtoONPercent
    SummaryRng.Offset(0, 106).Value = CtoOMinimumValPercent
    SummaryRng.Offset(0, 107).Value = CtoOFirstQuintilePercent
    SummaryRng.Offset(0, 108).Value = CtoOFirstDecilePercent
    SummaryRng.Offset(0, 109).Value = CtoOLowerQuartilePercent
    SummaryRng.Offset(0, 110).Value = CtoOMedianPercent
    SummaryRng.Offset(0, 111).Value = CtoOUpperQuartilePercent
    SummaryRng.Offset(0, 112).Value = CtoOLastDecilePercent
    SummaryRng.Offset(0, 113).Value = CtoOLastQuintilePercent
    SummaryRng.Offset(0, 114).Value = CtoOMaximumValPercent
    SummaryRng.Offset(0, 115).Value = CtoOModeValPercent
    SummaryRng.Offset(0, 116).Value = CtoOArithmeticMeanPercent
    SummaryRng.Offset(0, 117).Value = CtoOVariancePercent
    SummaryRng.Offset(0, 118).Value = CtoOStandardDeviationPercent
    SummaryRng.Offset(0, 119).Value = CtoOCoefficientOfVariationPercent
    SummaryRng.Offset(0, 120).Value = CtoOKurtosisPercent
    SummaryRng.Offset(0, 121).Value = CtoOSkewnessPercent



    
    'define Intraday Open to Close actual Range
    WS.Activate
    Range("N3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Intraday Open to Close actual stats
    OtoCNActual = LastRow
    OtoCMinimumValActual = Application.WorksheetFunction.Min(Rng)
    OtoCFirstQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.05)
    OtoCFirstDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.1)
    OtoCLowerQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.25)
    OtoCMedianActual = Application.WorksheetFunction.Median(Rng)
    OtoCUpperQuartileActual = Application.WorksheetFunction.Percentile(Rng, 0.75)
    OtoCLastDecileActual = Application.WorksheetFunction.Percentile(Rng, 0.9)
    OtoCLastQuintileActual = Application.WorksheetFunction.Percentile(Rng, 0.95)
    OtoCMaximumValActual = Application.WorksheetFunction.Max(Rng)
    OtoCModeValActual = Application.WorksheetFunction.Mode(Rng)
    OtoCArithmeticMeanActual = Application.WorksheetFunction.Average(Rng)
    OtoCStandardDeviationActual = Application.WorksheetFunction.StDev_P(Rng)
    OtoCVarianceActual = OtoCStandardDeviationActual * OtoCStandardDeviationActual
    OtoCCoefficientOfVariationActual = OtoCStandardDeviationActual / OtoCArithmeticMeanActual
    OtoCKurtosisActual = Application.WorksheetFunction.Kurt(Rng)
    OtoCSkewnessActual = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Intraday Open to Close actual stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 122).Value = OtoCNActual
    SummaryRng.Offset(0, 123).Value = OtoCMinimumValActual
    SummaryRng.Offset(0, 124).Value = OtoCFirstQuintileActual
    SummaryRng.Offset(0, 125).Value = OtoCFirstDecileActual
    SummaryRng.Offset(0, 126).Value = OtoCLowerQuartileActual
    SummaryRng.Offset(0, 127).Value = OtoCMedianActual
    SummaryRng.Offset(0, 128).Value = OtoCUpperQuartileActual
    SummaryRng.Offset(0, 129).Value = OtoCLastDecileActual
    SummaryRng.Offset(0, 130).Value = OtoCLastQuintileActual
    SummaryRng.Offset(0, 131).Value = OtoCMaximumValActual
    SummaryRng.Offset(0, 132).Value = OtoCModeValActual
    SummaryRng.Offset(0, 133).Value = OtoCArithmeticMeanActual
    SummaryRng.Offset(0, 134).Value = OtoCVarianceActual
    SummaryRng.Offset(0, 135).Value = OtoCStandardDeviationActual
    SummaryRng.Offset(0, 136).Value = OtoCCoefficientOfVariationActual
    SummaryRng.Offset(0, 137).Value = OtoCKurtosisActual
    SummaryRng.Offset(0, 138).Value = OtoCSkewnessActual

    
    'define Intraday Open to Close percent Range
    WS.Activate
    Range("O3").Select
    Range(Selection, Selection.End(xlDown)).Select
    Set Rng = Selection
    LastRow = Selection.Rows.Count
    
    'calculate Previous Open to Close percent stats
    OtoCNPercent = LastRow
    OtoCMinimumValPercent = Application.WorksheetFunction.Min(Rng)
    OtoCFirstQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.05)
    OtoCFirstDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.1)
    OtoCLowerQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.25)
    OtoCMedianPercent = Application.WorksheetFunction.Median(Rng)
    OtoCUpperQuartilePercent = Application.WorksheetFunction.Percentile(Rng, 0.75)
    OtoCLastDecilePercent = Application.WorksheetFunction.Percentile(Rng, 0.9)
    OtoCLastQuintilePercent = Application.WorksheetFunction.Percentile(Rng, 0.95)
    OtoCMaximumValPercent = Application.WorksheetFunction.Max(Rng)
    OtoCModeValPercent = Application.WorksheetFunction.Mode(Rng)
    OtoCArithmeticMeanPercent = Application.WorksheetFunction.Average(Rng)
    OtoCStandardDeviationPercent = Application.WorksheetFunction.StDev_P(Rng)
    OtoCVariancePercent = OtoCStandardDeviationPercent * OtoCStandardDeviationPercent
    OtoCCoefficientOfVariationPercent = OtoCStandardDeviationPercent / OtoCArithmeticMeanPercent
    OtoCKurtosisPercent = Application.WorksheetFunction.Kurt(Rng)
    OtoCSkewnessPercent = Application.WorksheetFunction.Skew_p(Rng)

    
    'paste Intraday Open to Close percent stats
    Worksheets("Summary").Activate
    SummaryRng.Offset(0, 139).Value = OtoCNPercent
    SummaryRng.Offset(0, 140).Value = OtoCMinimumValPercent
    SummaryRng.Offset(0, 141).Value = OtoCFirstQuintilePercent
    SummaryRng.Offset(0, 142).Value = OtoCFirstDecilePercent
    SummaryRng.Offset(0, 143).Value = OtoCLowerQuartilePercent
    SummaryRng.Offset(0, 144).Value = OtoCMedianPercent
    SummaryRng.Offset(0, 145).Value = OtoCUpperQuartilePercent
    SummaryRng.Offset(0, 146).Value = OtoCLastDecilePercent
    SummaryRng.Offset(0, 147).Value = OtoCLastQuintilePercent
    SummaryRng.Offset(0, 148).Value = OtoCMaximumValPercent
    SummaryRng.Offset(0, 149).Value = OtoCModeValPercent
    SummaryRng.Offset(0, 150).Value = OtoCArithmeticMeanPercent
    SummaryRng.Offset(0, 151).Value = OtoCVariancePercent
    SummaryRng.Offset(0, 152).Value = OtoCStandardDeviationPercent
    SummaryRng.Offset(0, 153).Value = OtoCCoefficientOfVariationPercent
    SummaryRng.Offset(0, 154).Value = OtoCKurtosisPercent
    SummaryRng.Offset(0, 155).Value = OtoCSkewnessPercent


    
End Function
