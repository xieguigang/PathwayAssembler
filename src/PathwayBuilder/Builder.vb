Imports std = System.Math

Module Builder

    Public Function Similarity(a As Double(), b As Double()) As Double
        Dim vi As Double

        For i As Integer = 0 To a.Length - 1
            vi = std.Min(a(i), b(i))

            If vi = 0.0 Then
                a(i) = 0
            Else
                a(i) = vi / std.Max(a(i), b(i))
            End If
        Next

        Return a.Average
    End Function

End Module
