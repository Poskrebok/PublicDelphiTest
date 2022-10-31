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
    Memo: TDBMemo;
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
    FgoodsTakenByMignon: integer;
    FThreadNumber: integer;
    { Private declarations }
  protected
    procedure PickOneStuff;
    procedure Execute; override;
  end;

 Tcart = class(TObject)
  private
    Fcapacity : integer;
    FhowDoesCartFilled : integer;
    FisItAdded: boolean;
  protected
    procedure Filling;
  public
    constructor Create(fCap: integer);
    property Filled : integer read FhowDoesCartFilled write FhowDoesCartFilled;
    property Weight : integer read Fcapacity;
    property isItAdded: boolean read FisItAdded;
  end;

var
  Form1: TForm1;
  Cart: Tcart;
  NumberOfThreads: integer;
implementation

{$R *.dfm}

procedure TForm1.onStartClick(Sender: TObject);
begin
  var i : integer;
  var percentage : integer;
  Form1.Memo.lines.Clear;
  NumberOfThreads:=0;
  if (nmbOfMignon.Text<>'') and (nmbOfMignon.Text<>'0') and (StrToInt(nmbOfMignon.Text)>0) then
      FnumberOfMignons := StrToInt(nmbOfMignon.Text)
  else
    begin
      ShowMessage('number of bananas is empty.');
      exit;
    end;
  if (capacityWeight.Text<>'') and (capacityWeight.Text<>'0') and (StrToInt(capacityWeight.Text)>0) then
      Cart := Tcart.Create(StrToInt(capacityWeight.Text))
  else
    begin
      ShowMessage('Capacity is empty.');
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
  NumberOfThreads:=NumberOfThreads+1;
  FThreadNumber:=NumberOfThreads;
  FillTheCart;
end;

procedure TMignonShopping.FillTheCart;
begin
randomize();
FgoodsTakenByMignon:= 0;
Form1.Memo.Lines.Add('');
while Cart.Filled<Cart.Weight do
  begin
    Synchronize(PickOneStuff);
    Sleep(1000 - random(10)*10);
  end;
self.Terminate;
self:= nil;
end;
procedure TMignonShopping.PickOneStuff;
begin
    Cart.Filling;
    if Cart.isItAdded = true then
      begin
        FgoodsTakenByMignon:=FgoodsTakenByMignon+1;
      end;
    Form1.Memo.Lines[FThreadNumber]:='Mignon No '+IntToStr(FThreadNumber)+' took goods =  '+IntToStr(FgoodsTakenByMignon);
end;

{ Tcart }

constructor Tcart.Create(fCap: integer);
begin
  Fcapacity :=fCap;
  FhowDoesCartFilled :=0;
  FisItAdded := false;
end;

procedure Tcart.Filling;
begin
  var LineNumberMemo: integer;
  if FhowDoesCartFilled<Fcapacity then
  begin
    FhowDoesCartFilled:= FhowDoesCartFilled + 1;
    Form1.cartProgressBar.position:= (FhowDoesCartFilled*100)div Fcapacity;
    FisItAdded:= true;
  end
  else
    FisItAdded:= false;
end;

end.
