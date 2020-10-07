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
    { Private declarations }
  public
    { Public declarations }
  end;

type
  fig=record
    left:byte;
    top:byte;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  field[1,1]:=1;
  field[1,3]:=3;
  field[2,2]:=2;
  field[1,2]:=2;

end;

procedure TForm1.Button2Click(Sender: TObject);//������ ������
begin
  figure.vid:=1;
  figure.left:=5;
  figure.top:=1;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;//��� ������� ������ ����������
  Shift: TShiftState);
begin
  //ShowMessage(IntToStr(key));
  case key of
    65:if figure.left>1 then figure.left:=figure.left-1;//�������� ����� ��� ������� A
    68:if figure.left<10 then figure.left:=figure.left+1;//�������� ������ ��� ������� D
  end;
  //�������� �������������
  Draw();
end;


procedure TForm1.Draw();//��������� �������������
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
  case figure.vid of
  1:
    Image1.Canvas.Rectangle(figure.left*30-30,figure.top*30-30,figure.left*30,figure.top*30)
  end;
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
  if (figure.top=20) or (field[20-figure.top,figure.left]<>0) then
    begin
      field[20-figure.top+1,figure.left]:=figure.vid;
      figure.top:=0;
    end;
//�������� ������ �� ���� ������ ����
  Figure.top:=figure.top+1;
end;

end.
