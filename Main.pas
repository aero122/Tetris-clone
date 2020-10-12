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
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Draw();
  private
    procedure Loc(l1, t1, l2, t2, l3, t3, l4, t4: byte);
    procedure Gen;
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
implementation

{$R *.dfm}

{����� �� ������:
���� ������ ������ - ������� 30�30
���� 10�20
Gen - ��������� �������� ������
Loc - ���������� ������ ���������}

procedure TForm1.Button1Click(Sender: TObject);//�������� ����������
var
  i: Integer;
  j: Integer;
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
end;

procedure TForm1.Button2Click(Sender: TObject);//������ ������
begin
  figure.vid:=1;
  loc(4,1,5,1,4,2,5,2);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;//��� ������� ������ ����������
  Shift: TShiftState);
begin
  //ShowMessage(IntToStr(key));
  case key of                      { TODO : �������� �������� �� ������ ������-����� }
    65:if figure.l1>1 then figure.l1:=figure.l1-1;//�������� ����� ��� ������� A
    68:if figure.l1<10 then figure.l1:=figure.l1+1;//�������� ������ ��� ������� D
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
  Image1.Picture:=nil;
  Image1.Canvas.Brush.Color:=clWhite;
  Image1.Canvas.FillRect(Image1.BoundsRect);
  for i:=1 to 20 do
    for j:= 1 to 10 do
      if field[i,j]<>0 then
        Image1.Canvas.Rectangle(j*30-30,630-i*30,j*30,600-i*30);
//������������ ������� ������
  {case figure.vid of
  1:
    )
  end;}
  Image1.Canvas.Rectangle(figure.l1*30-30,figure.t1*30-30,figure.l1*30,figure.t1*30);
  Image1.Canvas.Rectangle(figure.l2*30-30,figure.t2*30-30,figure.l2*30,figure.t2*30);
  Image1.Canvas.Rectangle(figure.l3*30-30,figure.t3*30-30,figure.l3*30,figure.t3*30);
  Image1.Canvas.Rectangle(figure.l4*30-30,figure.t4*30-30,figure.l4*30,figure.t4*30);
end;

procedure TForm1.FormShow(Sender: TObject);//��� ������ ����� ������������ ����� ���
begin
  Image1.Canvas.Brush.Color:=clWhite;
  Image1.Canvas.FillRect(Image1.BoundsRect);
end;

procedure TForm1.Timer1Timer(Sender: TObject);//�� ������ �������
var
  i: Integer;
  j: Integer;
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
      //�������� ������
      gen();
    end;
//�������� ������ �� ���� ������ ����
  Figure.t1:=figure.t1+1;
  figure.t2:=figure.t2+1;
  figure.t3:=figure.t3+1;
  figure.t4:=figure.t4+1;
end;

end.
