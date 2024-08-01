Imports std = System.Math

Module Builder

    Public Function Similarity(a As Double(), b As Double()) As Double
        For i As Integer = 0 To a.Length - 1
            a(i) = std.Min(a(i), b(i)) / std.Max(a(i), b(i))
        Next

        Return a.Average
    End Function

End Module
