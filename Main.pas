unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Win.TaskbarCore, Vcl.Taskbar, Vcl.DBCtrls;

type
 TForm1 = class(TForm)
    nmbOfMignon: TEdit;
    onStart: TButton;
    capacityWeight: TEdit;
    cartProgressBar: TProgressBar;
    Memo1: TDBMemo;
    procedure onStartClick(Sender: TObject);
  private
    FnumberOfMignons : integer;
  public
    { Public declarations }
  end;

 TMignonShopping = class(TThread)
  public
    procedure FillTheCart;
  private
    FthreadNum: integer;
    FgoodsTakenByMignon: integer;
    { Private declarations }
  protected
    procedure WriteRes;
    procedure GetNumber;
    procedure Execute; override;
  end;

 Tcart = class(TObject)
  private
    Fcapacity : integer;
    FhowDoesCartFilled : integer;
    FisCartFilled: boolean;
  protected
    procedure Filling;
  public
    constructor Create(fCap: integer);
    property Filled : integer read FhowDoesCartFilled write FhowDoesCartFilled;
    property Weight : integer read Fcapacity;
    property IsCartFilled: boolean read FisCartFilled;
  end;

var
  Form1: TForm1;
  Cart: Tcart;

implementation

{$R *.dfm}

procedure TForm1.onStartClick(Sender: TObject);
begin
  var i : integer;
  var percentage : integer;
  if (nmbOfMignon.Text<>'') then
      FnumberOfMignons := StrToInt(nmbOfMignon.Text)
  else
    begin
      ShowMessage('The field for number of bananas is empty.');
      exit;
    end;
  if (capacityWeight.Text<>'') then
      Cart := Tcart.Create(StrToInt(capacityWeight.Text))
  else
    begin
      ShowMessage('The field for Capacity is empty.');
      exit
    end;
  var MignonShopp:TMignonShopping;
  for i := 0 to FnumberOfMignons-1 do
  begin
    MignonShopp:= TMignonShopping.Create(False);
    MignonShopp.Priority:=tpNormal;
  end;

end;

{ TMignonShopping }

procedure TMignonShopping.Execute;
begin
  FillTheCart
end;

procedure TMignonShopping.FillTheCart;
begin
var i:integer;
var SpeedOfBuing:integer;
//var GoodsTakenByMignon: integer;
randomize();
Synchronize(GetNumber);
while Cart.Filled<Cart.Weight do
  begin
    Synchronize(Cart.Filling);
    if Cart.IsCartFilled = false then
      FgoodsTakenByMignon:=FgoodsTakenByMignon+1;
    Sleep(1000 - random(100)*10);
    Synchronize(WriteRes);
  end;
self.Terminate;
self:= nil;
end;


procedure TMignonShopping.GetNumber;
begin
  Form1.Memo1.Lines.Add(' ');
  FthreadNum:=Form1.Memo1.Lines.Count;
end;
procedure TMignonShopping.WriteRes;
begin
  Form1.Memo1.Lines[FthreadNum]:='Mignon No '+IntToStr(FthreadNum)+' took goods =  '+IntToStr(FgoodsTakenByMignon);
end;

{ Tcart }

constructor Tcart.Create(fCap: integer);
begin
  Fcapacity :=fCap;
  FhowDoesCartFilled :=0;
  FisCartFilled := false;
end;

procedure Tcart.Filling;
begin
  var LineNumberMemo: integer;
  if FhowDoesCartFilled<Fcapacity then
  begin
    FhowDoesCartFilled:= FhowDoesCartFilled + 1;
    Form1.cartProgressBar.position:= (FhowDoesCartFilled*100)div Fcapacity;
    FisCartFilled:= false;
  end
  else
    FisCartFilled:= true;
end;

end.
