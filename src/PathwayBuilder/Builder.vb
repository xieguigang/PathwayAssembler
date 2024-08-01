Imports Microsoft.VisualBasic.CommandLine.Reflection
Imports Microsoft.VisualBasic.ComponentModel.DataSourceModel
Imports Microsoft.VisualBasic.Math.DataFrame
Imports Microsoft.VisualBasic.Scripting.MetaData
Imports SMRUCC.Rsharp.Runtime.Vectorization
Imports rdataframe = SMRUCC.Rsharp.Runtime.Internal.[Object].dataframe
Imports std = System.Math

<Package("Builder")>
Module Builder

    Public Function Similarity(a As Double(), b As Double()) As (Double, Double)
        Dim vi As Double

        For i As Integer = 0 To a.Length - 1
            vi = std.Min(a(i), b(i))

            If vi = 0.0 Then
                a(i) = 0
            Else
                a(i) = vi / std.Max(a(i), b(i))
            End If
        Next

        Return (a.Average, 0)
    End Function

    <ExportAPI("small_network")>
    Public Function SmallNetwork(x As rdataframe) As DataMatrix
        Dim metabolites = x.forEachRow() _
            .Select(Function(v)
                        Return New NamedCollection(Of Double)(v.name, CLRVector.asNumeric(v.value))
                    End Function) _
            .ToArray
        Dim mat = metabolites.MatrixBuilder(
            vector:=Function(v) v.value,
            eval:=AddressOf Similarity,
            type:=DataType.Similarity
        )

        Return mat
    End Function
End Module
