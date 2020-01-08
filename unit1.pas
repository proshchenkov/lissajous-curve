unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Spin,
  ComCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Panel1: TPanel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    FRunning: boolean;
    function SignalX: single;
    function SignalY: single;
    procedure Draw;
  public
    t: single;
    Scale: TPoint;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Scale.x := TrackBar1.Position;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not FRunning then
  begin
    Button1.Caption := 'Stop';
    Image1.Canvas.Brush.Color := clWhite;
    Image1.Canvas.FillRect(Image1.ClientRect);
  end
  else
  begin
    Button1.Caption := 'Start';
    t := 0;
  end;
  FRunning := not FRunning;
  Timer1.Enabled := FRunning;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Scale := Point(TrackBar1.Position, TrackBar2.Position);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  t := t + 0.05;
  draw;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  Scale.Y := TrackBar2.Position;
end;

procedure TForm1.Draw;
var
  center: TPoint;
  pt: TPoint;
begin
  center := Point(Image1.Width div 2, Image1.Height div 2);
  pt.X := center.X + Round(scale.X * signalX());
  pt.Y := center.Y + Round(scale.Y * signalY());
  Image1.Canvas.Brush.Color := clGreen;
  Image1.Canvas.Rectangle(pt.X - 2, pt.Y - 2, pt.X + 2, pt.Y + 2);
end;

function TForm1.SignalX: single;
begin
  Result := Sin(SpinEdit1.Value * t);
end;

function TForm1.SignalY: single;
begin
  Result := Sin(SpinEdit2.Value * t);
end;

end.

