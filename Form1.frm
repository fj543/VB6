VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Redis����  ��By fj543��"
   ClientHeight    =   4800
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6915
   LinkTopic       =   "Form1"
   ScaleHeight     =   4800
   ScaleWidth      =   6915
   StartUpPosition =   1  '����������
   Begin VB.TextBox txtPass 
      Height          =   300
      IMEMode         =   3  'DISABLE
      Left            =   2160
      PasswordChar    =   "*"
      TabIndex        =   12
      Top             =   480
      Width           =   1455
   End
   Begin VB.CommandButton btnConn 
      Caption         =   "����Redis�������"
      Height          =   375
      Left            =   4560
      TabIndex        =   0
      Top             =   240
      Width           =   1815
   End
   Begin VB.TextBox txtPort 
      Height          =   300
      Left            =   3720
      TabIndex        =   2
      Text            =   "6379"
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox txtHost 
      Height          =   300
      Left            =   2160
      TabIndex        =   1
      Text            =   "127.0.0.1"
      Top             =   120
      Width           =   1455
   End
   Begin VB.CommandButton btnTestWrite 
      Caption         =   "дRedis���ܲ���"
      Height          =   495
      Left            =   120
      TabIndex        =   8
      Top             =   2160
      Width           =   1695
   End
   Begin VB.CommandButton btnPop 
      Caption         =   "��Redis����"
      Height          =   495
      Left            =   5160
      TabIndex        =   7
      Top             =   1680
      Width           =   1695
   End
   Begin VB.CommandButton btnPush 
      Caption         =   "д��Redis����"
      Height          =   495
      Left            =   3480
      TabIndex        =   6
      Top             =   1680
      Width           =   1695
   End
   Begin VB.TextBox txtData2 
      Height          =   1935
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   9
      Text            =   "Form1.frx":0000
      Top             =   2760
      Width           =   6735
   End
   Begin VB.CommandButton btnRead 
      Caption         =   "��Redis����"
      Height          =   495
      Left            =   1800
      TabIndex        =   5
      Top             =   1680
      Width           =   1695
   End
   Begin VB.TextBox txtData 
      Height          =   735
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   3
      Text            =   "Form1.frx":001A
      Top             =   840
      Width           =   6735
   End
   Begin VB.CommandButton btnWrite 
      Caption         =   "д���ݵ�Redis"
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   1680
      Width           =   1695
   End
   Begin VB.Label lblPass 
      AutoSize        =   -1  'True
      Caption         =   "����(������������)��"
      Height          =   180
      Left            =   120
      TabIndex        =   11
      Top             =   480
      Width           =   1800
   End
   Begin VB.Label lblRedisServer 
      AutoSize        =   -1  'True
      Caption         =   "Redis������IP���˿ڣ�"
      Height          =   180
      Left            =   120
      TabIndex        =   10
      Top             =   150
      Width           =   1890
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim R As RedisClass '�����Զ�����ı���

Private Sub btnConn_Click()
    R.Host = Trim(txtHost.Text)
    R.Port = Val(Trim(txtPort.Text))
    txtData2.Text = Now() & " ����״̬��" & R.RedisConn(, , txtPass.Text) & vbCrLf & "��״̬Ϊ7��ʾ�ɹ���"
End Sub

Private Sub btnPop_Click()
    txtData2.Text = R.rPop("urls") '��redis�������"urls"��ȡ��ĩβһ������
End Sub

Private Sub btnPush_Click()
    txtData2.Text = R.lPush("urls", txtData.Text) '��redis�������"urls"�Ŀ�ͷ����һ������
End Sub

Private Sub btnRead_Click()
    txtData2.Text = R.GetS("test") '��redis�ж�ȡ����test��ֵ
    If txtData2.Text = "" Then txtData2.Text = R.LastError
End Sub

Private Sub btnTestWrite_Click()
    Dim t As Single, re As String, i As Long
    If R.State <> 7 Then R.RedisConn
    If R.State = 7 Then
        t = Timer()
        For i = 0 To 99999
            re = R.SetS("test", txtData.Text)
        Next i
        txtData2.Text = "д��" & i & "�Σ���ʱ��" & FormatNumber(Timer() - t, 2, vbTrue) & "��"
    End If
End Sub

Private Sub btnWrite_Click()
    txtData2.Text = R.SetS("test", txtData.Text) '���ı�������д�뵽Redis�еı���test
    If txtData2.Text = "" Then txtData2.Text = R.LastError
End Sub

Private Sub Form_Load()
    Set R = New RedisClass '������ʵ����Ϊ���õĶ���
    'R.RedisConn "10.9.2.3", 6379
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set R = Nothing
End Sub
