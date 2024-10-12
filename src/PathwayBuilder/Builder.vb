Imports Microsoft.VisualBasic.CommandLine.Reflection
Imports Microsoft.VisualBasic.ComponentModel.DataSourceModel
Imports Microsoft.VisualBasic.DataMining.AprioriRules
Imports Microsoft.VisualBasic.Math.DataFrame
Imports Microsoft.VisualBasic.Scripting.MetaData
Imports SMRUCC.Rsharp.Runtime.Internal.[Object]
Imports SMRUCC.Rsharp.Runtime.Vectorization
Imports rdataframe = SMRUCC.Rsharp.Runtime.Internal.[Object].dataframe
Imports std = System.Math

<Package("Builder")>
Module Builder

    <ExportAPI("sort_groups")>
    Public Function sort_groups(x As rdataframe) As list
        Dim atom_groups = x.colnames
        Dim encoding As New Encoding(atom_groups)
        Dim metabolites As Dictionary(Of String, Object) = x _
            .forEachRow(atom_groups) _
            .AsParallel _
            .Select(Function(a)
                        Dim v As Integer() = CLRVector.asInteger(a.value)
                        Dim seq As New List(Of Char)
                        Dim groups = atom_groups.Zip(second:=v) _
                            .OrderByDescending(Function(i) i.Second) _
                            .ToArray

                        For Each atom In groups
                            Call seq.AddRange(Replicate(encoding.Encoding(atom.First).UnicodeChar, atom.Second))
                        Next

                        Return (a.name, New String(seq.ToArray))
                    End Function) _
            .ToDictionary(Function(a) a.name,
                          Function(a)
                              Return CObj(a.Item2)
                          End Function)

        Return New list With {.slots = metabolites}
    End Function

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
