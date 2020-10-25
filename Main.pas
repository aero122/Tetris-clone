unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Draw();
  private
    procedure Loc(l1, t1, l2, t2, l3, t3, l4, t4: byte);
    procedure Gen;
    procedure Rot;
    procedure Lines;
    { Private declarations }
  public
    { Public declarations }
  end;

type
  fig=record
    l1:byte;
    t1:byte;
    l2:byte;
    t2:byte;
    l3:byte;
    t3:byte;
    l4:byte;
    t4:byte;
    vid:byte;
  end;

var
  Form1: TForm1;
  //������� ����
  field:array[1..20,1..10] of byte;
  //������
  figure:fig;
  //���������� �����
  lin:integer=0;
implementation

{$R *.dfm}

{���:
���� ������ ������ - ������� 30�30
���� 10�20
������ ���� ����� ����� � ����� �������
Gen - ��������� �������� ������
Loc - ���������� ������ ���������
Draw - ��������� �����
Rot - ������� ������}

//�������� ����������
procedure TForm1.Button1Click(Sender: TObject);
begin
  field[1,1]:=1;
  field[1,3]:=3;
  field[2,2]:=2;
  field[1,2]:=2;
end;

Procedure TForm1.Loc(l1,t1,l2,t2,l3,t3,l4,t4:byte);
//������� ��������� ������
begin
  figure.t1:=t1;
  figure.t2:=t2;
  figure.t3:=t3;
  figure.t4:=t4;
  figure.l1:=l1;
  figure.l2:=l2;
  figure.l3:=l3;
  figure.l4:=l4;
end;

Procedure TForm1.Rot;
//������� ������
Begin
  case figure.vid of
    1:exit;
    2:begin
      //������ �������
      if figure.l1<figure.l2 then begin
        Loc(figure.l2,figure.t2-1,figure.l2,figure.t2,figure.l2,figure.t2+1,figure.l2-1,figure.t2-1);
        exit;
      end;
      //������ �������
      if figure.t1<figure.t2 then begin
        Loc(figure.l2+1,figure.t2,figure.l2,figure.t2,figure.l2-1,figure.t2,figure.l2+1,figure.t2-1);
        exit;
      end;
      //������ �������
      if figure.l1>figure.l2 then begin
        Loc(figure.l2,Figure.t2+1,figure.l2,figure.t2,figure.l2,figure.t2-1,figure.l2+1,figure.t2+1);
        exit;
      end;
      //��������� �������
      if figure.t1>figure.t2 then begin
        Loc(figure.l2-1,figure.t2,figure.l2,figure.t2,figure.l2+1,figure.t2,figure.l2-1,figure.t2+1);
        exit;
      end;
    end;
    3:begin
      //������ �������
      if figure.l1<figure.l2 then begin
        Loc(figure.l2,figure.t2-1,figure.l2,figure.t2,figure.l2,figure.t2+1,figure.l2-1,figure.t2+1);
        exit;
      end;
      //������ �������
      if figure.t1<figure.t2 then begin
        Loc(figure.l2+1,figure.t2,figure.l2,figure.t2,figure.l2-1,figure.t2,figure.l2-1,figure.t2-1);
        exit;
      end;
      //������ �������
      if figure.l1>figure.l2 then begin
        Loc(figure.l2,Figure.t2+1,figure.l2,figure.t2,figure.l2,figure.t2-1,figure.l2+1,figure.t2-1);
        exit;
      end;
      //��������� �������
      if figure.t1>figure.t2 then begin
        Loc(figure.l2-1,figure.t2,figure.l2,figure.t2,figure.l2+1,figure.t2,figure.l2+1,figure.t2+1);
        exit;
      end;
    end;
    4:begin
      //������ �������
      if figure.l1<figure.l2 then begin
        Loc(figure.l2,figure.t2-1,figure.l2,figure.t2,figure.l2,figure.t2+1,figure.l2+1,figure.t2);
        exit;
      end;
      //������ �������
      if figure.t1<figure.t2 then begin
        Loc(figure.l2+1,figure.t2,figure.l2,figure.t2,figure.l2-1,figure.t2,figure.l2,figure.t2-1);
        exit;
      end;
      //������ �������
      if figure.l1>figure.l2 then begin
        Loc(figure.l2,figure.t2+1,figure.l2,figure.t2,figure.l2,figure.t2-1,figure.l2-1,figure.t2);
        exit;
      end;
      //��������� �������
      if figure.t1>figure.t2 then begin
        Loc(figure.l2-1,figure.t2,figure.l2,figure.t2,figure.l2+1,figure.t2,figure.l2,figure.t2+1);
        exit;
      end;
    end;
    5:begin //Z
      //������ �������
      if figure.l2>figure.l1 then begin
        Loc(figure.l1,figure.t1,figure.l1,figure.t1+1,figure.l1-1,figure.t1-1,figure.l1-1,figure.t1);
        exit;
      end;
      //������ �������
      if (figure.t2>figure.t1) then begin
        Loc(figure.l1,figure.t1,figure.l1+1,figure.t1,figure.l1-1,figure.t1+1,figure.l1,figure.t1+1);
        exit;
      end;
    end;
    6:begin //S
      //������ �������
      if figure.l1<figure.l2 then begin
        Loc(figure.l2,figure.t2-1,figure.l2,figure.t2,figure.l2-1,figure.t2,figure.l2-1,figure.t2+1);
        exit;
      end;
      //������ �������
      if figure.t1<figure.t2 then begin
        Loc(figure.l2-1,figure.t2,figure.l2,figure.t2,figure.l2,figure.t2+1,figure.l2+1,figure.t2+1);
        exit;
      end;
    end;
    7:begin //�����
      //������ �������
      if figure.t1<figure.t2 then begin
        Loc(figure.l2+1,figure.t2,figure.l2,figure.t2,figure.l2-1,figure.t2,figure.l2-2,figure.t2);
        exit;
      end;
      //������ �������
      if figure.l1>figure.l2 then begin
        Loc(figure.l2,figure.t2-1,figure.l2,figure.t2,figure.l2,figure.t2+1,figure.l2,figure.t2+2);
        exit;
      end;
    end;
  end;
End;

Procedure TForm1.Gen;
//�������� ����� ������
begin
  Randomize();
  figure.vid:=Random(7)+1;
  case figure.vid of
    1:Loc(4,1,5,1,4,2,5,2);
    2:Loc(4,1,5,1,6,1,4,2);
    3:Loc(4,1,5,1,6,1,6,2);
    4:Loc(4,1,5,1,6,1,5,2);
    5:Loc(5,1,6,1,4,2,5,2);
    6:Loc(4,1,5,1,5,2,6,2);
    7:Loc(5,1,5,2,5,3,5,4);
  end;
  Draw();
end;

Procedure TForm1.Lines;
var
  I: Integer;
  j: Integer;
  r: Integer; //��������� �������� ������
  x: Integer; //���������� �����, ������� ������� ���������
  i2: Integer;
  j2: Integer;
Begin
  x:=19;
  i:=1;
  while i<=x do begin
    r:=0;
    for j:=1 to 10 do
      if field[i,j]=0 then
        r:=1;
    if r=0 then begin
      for i2:= i to x do
        for j2:=1 to 10 do
          field[i2,j2]:=field[i2+1,j2];
      x:=x-1; //�������� ���������� ����������� ����� �� ����
      i:=i-1; //�.�. ������ ������� ���� �� ����, ������������� ������� ������ �����
      Draw(); //���������������� ����
      Lin:=Lin+1;
      Label1.Caption:='�����: '+IntToStr(lin);
      if timer1.Interval>20 then timer1.interval:=timer1.Interval-20; //����������� �������� ����
    end;
    i:=i+1;
  end;

End;

//������ ������
procedure TForm1.Button2Click(Sender: TObject);
begin
  gen();
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;//��� ������� ������ ����������
  Shift: TShiftState);
begin
  //ShowMessage(IntToStr(key));
  case key of
    //�������� ����� ��� ������� A
    65:if (figure.l1>1) and (field[20-figure.t1,figure.l1-1]=0)
    and (figure.l2>1) and (field[20-figure.t2,figure.l2-1]=0)
    and (figure.l3>1) and (field[20-figure.t3,figure.l3-1]=0)
    and (figure.l4>1) and (field[20-figure.t4,figure.l4-1]=0) then
    begin
      figure.l1:=figure.l1-1;
      figure.l2:=figure.l2-1;
      figure.l3:=figure.l3-1;
      figure.l4:=figure.l4-1;
    end
    else exit;
    //�������� ������ ��� ������� D
    68:if (figure.l1<10) and (field[20-figure.t1,figure.l1+1]=0)
    and (figure.l2<10) and (field[20-figure.t1,figure.l1+1]=0)
    and (figure.l3<10) and (field[20-figure.t1,figure.l1+1]=0)
    and (figure.l4<10) and (field[20-figure.t1,figure.l1+1]=0) then
    begin
      figure.l1:=figure.l1+1;
      figure.l2:=figure.l2+1;
      figure.l3:=figure.l3+1;
      figure.l4:=figure.l4+1;
    end
    else exit;
    //�������� ������ ���� ��� ������� S
    83:begin
        timer1timer(self);
        exit;
      end;
    //��������
    87:begin
        Rot();
    end;
  end;
  //�������� �������������
  Draw();
end;


procedure TForm1.Draw();//��������� ������������� ����
var
  i: Integer;
  j: Integer;
begin
//������������ ������� ����, �������������� �������
  Image1.Canvas.Brush.Color:=clWhite;
  Image1.Picture:=nil;
  Image1.Canvas.FillRect(Image1.BoundsRect);
  for i:=1 to 20 do
    for j:= 1 to 10 do
      if field[i,j]<>0 then
      begin
        case field[i,j] of
          1:Image1.Canvas.Brush.Color:=clRed;
          2:Image1.Canvas.Brush.Color:=clOlive;
          3:Image1.Canvas.Brush.Color:=clYellow;
          4:Image1.Canvas.Brush.Color:=clGreen;
          5:Image1.Canvas.Brush.Color:=clAqua;
          6:Image1.Canvas.Brush.Color:=clBlue;
          7:Image1.Canvas.Brush.Color:=clFuchsia;
        end;
        Image1.Canvas.Rectangle(j*30-30,630-i*30,j*30,600-i*30);
      end;
//������������ ������� ������
  case figure.vid of
    1:Image1.Canvas.Brush.Color:=clRed;
    2:Image1.Canvas.Brush.Color:=clOlive;
    3:Image1.Canvas.Brush.Color:=clYellow;
    4:Image1.Canvas.Brush.Color:=clGreen;
    5:Image1.Canvas.Brush.Color:=clAqua;
    6:Image1.Canvas.Brush.Color:=clBlue;
    7:Image1.Canvas.Brush.Color:=clFuchsia;
  end;
  Image1.Canvas.Rectangle(figure.l1*30-30,figure.t1*30-30,figure.l1*30,figure.t1*30);
  Image1.Canvas.Rectangle(figure.l2*30-30,figure.t2*30-30,figure.l2*30,figure.t2*30);
  Image1.Canvas.Rectangle(figure.l3*30-30,figure.t3*30-30,figure.l3*30,figure.t3*30);
  Image1.Canvas.Rectangle(figure.l4*30-30,figure.t4*30-30,figure.l4*30,figure.t4*30);
end;

//��� ������ ����� ������������ ����� ���
procedure TForm1.FormShow(Sender: TObject);
begin
  Image1.Canvas.Brush.Color:=clWhite;
  Image1.Canvas.FillRect(Image1.BoundsRect);
end;

//�� ������ �������
procedure TForm1.Timer1Timer(Sender: TObject);
begin
//������������ ������� ����, �������������� �������
  Draw();
//���� ������ �������� "����" ��� ������ ������, �� ���������� ���������
  if (figure.t1=20)
  or (figure.t2=20)
  or (figure.t3=20)
  or (figure.t4=20)
  or (field[20-figure.t1,figure.l1]<>0)
  or (field[20-figure.t2,figure.l2]<>0)
  or (field[20-figure.t3,figure.l3]<>0)
  or (field[20-figure.t4,figure.l4]<>0) then
    begin
      //��������� ���� ������� �������
      field[20-figure.t1+1,figure.l1]:=figure.vid;
      field[20-figure.t2+1,figure.l2]:=figure.vid;
      field[20-figure.t3+1,figure.l3]:=figure.vid;
      field[20-figure.t4+1,figure.l4]:=figure.vid;
      //�������� ���� �� ��������� �����
      lines();
      //�������� ��������� ������
      gen();
    end;
//�������� ������ �� ���� ������ ����
  Figure.t1:=figure.t1+1;
  figure.t2:=figure.t2+1;
  figure.t3:=figure.t3+1;
  figure.t4:=figure.t4+1;
end;

end.
