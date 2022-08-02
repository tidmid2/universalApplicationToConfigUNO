unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IniFiles,ShellApi,WinSvc,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    FDConnection1: TFDConnection;
    tbsmenyinactive: TFDQuery;
    tbsmenyactive: TFDQuery;
    documentsinactive: TFDQuery;
    documentsactive: TFDQuery;
    dlinesinactive: TFDQuery;
    dlinesactive: TFDQuery;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Button14: TButton;
    Button15: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExecuteStartService(ServiceName: String);
    procedure ExecuteControlService(ServiceName: String; ServiceControlCode : DWORD);
    procedure StatusService(ServiceName: String;TypeStart: DWORD);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
var ini: Tinifile; REGNUM,srvkeyoncreate : String;
  //aa:cardinal;ess:TEnumServiceStatus;
procedure TForm3.FormCreate(Sender: TObject);
begin
//проверка на включен ли телега или выключена и кнопка название
  ini:= TIniFile.Create('C:\UNO\bin\config.ini');
  srvkeyoncreate:= ini.ReadString('DATABASE','SRVKEY','');
  if srvkeyoncreate='' then
      begin
        if (ini.ReadString('REGISTRY','REGNUM','')='') then
        begin
            ShowMessage('Регистрационный код неизвестен, сначала активируйте программу!') ;
            Application.Destroy;
        end
        else
        begin
           button1.Caption:='Включить Телеграм';
        end;

        if ini.ReadString('DATABASE','SRVKEY','')='' then
        begin
          button2.Caption:='Включить WsClnt';
        end
        else button2.Caption:='Выключить WsClnt';
      end
      else
      begin
         button1.Caption:='Выключить Телеграм';
      end;
       //кюар код длл
      if FileExists('C:\UNO\bin\Moduls\qrcode.dll') then
       begin
          button4.Caption:='Выключить QR-Код';
       end
       else
       begin
          button4.Caption:='Включить QR-Код';
       end;
       //Касса длл
       if FileExists('C:\UNO\bin\Moduls\Kassa.dll') then
       begin
          button3.Caption:='Выключить Кассу';
       end
       else
       begin
          button3.Caption:='Включить Кассу';
       end;

       if ini.ReadString('DATABASE','HIDEOTLOZH','')='1'  then
       begin
         button5.Caption:='Включить Отложку';
       end
       else
       begin
         button5.caption:='Отключить Отложку';
       end;

       if ini.ReadString('DATABASE','ONEENTER','')='1' then
       begin
         label5.Caption:='ON';
       end
       else
       begin
         label5.Caption:='OFF';
       end;


       if ini.ReadString('DATABASE','PREDOP','')='1' then
       begin
         button7.Caption:='Выключить Предоплату';
       end
       else
       begin
         button7.Caption:='Включить Предоплату';
       end;

       if ini.ReadString('DATABASE','NOHIDEFRM','')='1' then
       begin
         button8.Caption:='Выключить Бездействие';
       end
       else
       begin
         button8.Caption:='Включить Бездействие';
       end;

       if ini.ReadString('DATABASE','PRINTCOPIES','')='0' then
       begin
         label7.Caption:='ON';
         button14.Caption:='Выключить';
         label7.Visible:=True;
         Edit1.Visible:=True;
       end
       else
       begin
         label7.Caption:='OFF';
         button14.Caption:='Включить';
         Edit1.Text:=ini.ReadString('DATABASE','PRINTCOPIES','');
       end;


end;

procedure TForm3.Button10Click(Sender: TObject);
begin
  if panel2.Visible=False then
    begin
      panel2.Visible:=True;
    end
  else
  begin
    panel2.Visible:=False;
  end;
end;

procedure TForm3.Button11Click(Sender: TObject);
begin
     if (Label2.Caption='Включение') then
        begin
            Label2.Caption:='Отключение';
            tbsmenyactive.Execute(1);
        end
    else
    begin
        Label2.Caption:='Включение';
        tbsmenyinactive.Execute(1);
    end;

end;

procedure TForm3.Button12Click(Sender: TObject);
begin
    if (Label2.Caption='Включение') then
        begin
            Label2.Caption:='Отключение';
            documentsactive.Execute(1);
        end
    else
    begin
        Label2.Caption:='Включение';
        documentsinactive.Execute(1);
    end;

end;

procedure TForm3.Button13Click(Sender: TObject);
begin
    if (Label1.Caption='Включение') then
        begin
            Label1.Caption:='Отключение';
            dlinesactive.Execute(1);
        end
    else
    begin
        Label1.Caption:='Включение';
        dlinesinactive.Execute(1);
    end;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
       //button14.Caption:='Выключить';
        //ini.WriteInteger('DATABASE','PRINTCOPIES',ToInteger(Edit1.Text));
        edit1.Visible:=True;
        if (label7.Caption='OFF') and (Edit1.Text<>'') then
        begin
          label7.Caption:='ON';
        end
        else if (label7.Caption='OFF') and (Edit1.Text='') then
        begin
           ShowMessage('Сначала введите количество копии');
        end
        else if (label7.Caption='ON') and (Edit1.Text='')   then
        begin
          ShowMessage('Недопустимое количество копии');
        end
        else if (label7.Caption='ON') and (Edit1.Text>'0') then
        begin

            ini.WriteString('DATABASE','PRINTCOPIES',(Edit1.Text));
        end;

end;

procedure TForm3.Button15Click(Sender: TObject);
begin
     if (label7.Caption='OFF') then
        begin
          ShowMessage('Уже выключена');
        end
      else
      begin
        label7.Caption:='OFF';
        edit1.Visible:=false;
        ini.WriteInteger('DATABASE','PRINTCOPIES',1);
      end;
end;

procedure TForm3.Button1Click(Sender: TObject);   //включение или выключение телеги
begin
    if button1.caption='Включить Телеграм' then
    begin
      button1.Caption:='Выключить Телеграм';
      if ini.ReadString('DATABASE','SRVKEY','')='' then
      begin
        REGNUM:=ini.ReadString('REGISTRY','REGNUM','');
        Ini.WriteString('DATABASE','SRVKEY',REGNUM);
      end;
      if ini.ReadString('WS','IDSRV','')='' then
      begin
         Ini.WriteString('WS','IDSRV',REGNUM);
      end;
        documentsactive.Execute(1);
        dlinesactive.Execute(1);
        tbsmenyactive.Execute(1);
        StatusService('Telegram_grd',SERVICE_AUTO_START);
        ExecuteStartService('Telegram_grd');

        StatusService('telegram_srv',SERVICE_AUTO_START);
        ExecuteStartService('telegram_srv');
        showmessage('Телеграм Включен');

    end
    else
    begin
      button1.Caption:='Включить Телеграм';
      documentsinactive.Execute(1);
      dlinesinactive.Execute(1);
      tbsmenyinactive.Execute(1);
      StatusService('Telegram_grd',SERVICE_DISABLED);
      ExecuteControlService('Telegram_grd',SERVICE_CONTROL_STOP);

      StatusService('telegram_srv',SERVICE_DISABLED);
      ExecuteControlService('telegram_srv',SERVICE_CONTROL_STOP);
      showmessage('Телеграм Отключен');
     end;

end;

procedure TForm3.Button2Click(Sender: TObject);
var // ini: Tinifile;
reg: String;
begin
     if button2.Caption='Включить WsClnt'  then
     begin

         button2.Caption:='Выключить WsClnt';
        if (ini.ReadString('REGISTRY','REGNUM','')='') then
            begin
                ShowMessage('Регистрационный код неизвестен, сначала активируйте программу!') ;
                Application.Destroy;
            end
        else
        begin
           reg:=ini.ReadString('REGISTRY','REGNUM','');
           if (ini.ReadString('DATABASE','SRVKEY','')='') then
            begin
              Ini.WriteString('DATABASE','SRVKEY',reg);
            end;
            //else ShowMessage('ID заведения указан');

            if ini.ReadString('WS','IDSRV','')='' then
            begin
               Ini.WriteString('WS','IDSRV',reg);
            end;
            //else  ShowMessage('ID заведения в службу указан');
            StatusService('WebWSClnt',SERVICE_AUTO_START);
            ExecuteControlService('WebWSClnt',SERVICE_CONTROL_STOP);
            ExecuteStartService('WebWSClnt');

        end;
     end
     else
     begin
       button2.Caption:='Включить WsClnt';
       StatusService('WebWSClnt',SERVICE_DISABLED);
       ExecuteControlService('WebWSClnt',SERVICE_CONTROL_STOP);
     end;
  {   }
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  if button4.Caption='Включить QR-Код' then
   begin
      if FileExists('C:\UNO\bin\Moduls\qrcode.dll') then
      begin
          ShowMessage('Уже включена.');
      end
      else
      begin
          button4.Caption:='Выключить QR-Код';
          RenameFile('C:\UNO\bin\Moduls\qrcode.dll1', 'C:\UNO\bin\Moduls\qrcode.dll');
      end;
   end
  else
  begin
      if FileExists('C:\UNO\bin\Moduls\qrcode.dll1') then
      begin
          ShowMessage('Уже выключена.');
      end
      else
      begin
          button4.Caption:='Включить QR-Код';
          RenameFile('C:\UNO\bin\Moduls\qrcode.dll', 'C:\UNO\bin\Moduls\qrcode.dll1');
      end;
  end;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
    if button5.caption='Включить Отложку' then
    begin
        button5.Caption:='Отключить Отложку';
        ini.WriteInteger('DATABASE','HIDEOTLOZH',0);
    end
    else
    begin
        button5.caption:='Включить Отложку';
        ini.WriteInteger('DATABASE','HIDEOTLOZH',1);
    end;

end;

procedure TForm3.Button6Click(Sender: TObject);
begin
    if Label5.caption='OFF' then
    begin
        Label5.Caption:='ON';
        ini.WriteInteger('DATABASE','ONEENTER',1);
    end
    else
    begin
        Label5.caption:='OFF';
        ini.WriteInteger('DATABASE','ONEENTER',0);
    end;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
    if button7.caption='Включить Предоплату' then
    begin
        button7.Caption:='Выключить Предоплату';
        ini.WriteInteger('DATABASE','PREDOP',1);
    end
    else
    begin
        button7.caption:='Включить Предоплату';
        ini.WriteInteger('DATABASE','PREDOP',0);
    end;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
    if button8.caption='Включить Бездействие' then
    begin
        button8.Caption:='Выключить Бездействие';
        ini.WriteInteger('DATABASE','NOHIDEFRM',1);
    end
    else
    begin
        button8.caption:='Включить Бездействие';
        ini.WriteInteger('DATABASE','NOHIDEFRM',0);
    end;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
    if Label7.caption='OFF' then
    begin
        label7.Visible:=True;
        Edit1.Visible:=True;

    end;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
    if button3.Caption='Включить Кассу' then
   begin
      if FileExists('C:\UNO\bin\Moduls\Kassa.dll') then
      begin
          ShowMessage('Уже включена.');

      end
      else
      begin
          button3.Caption:='Выключить Кассу';
          RenameFile('C:\UNO\bin\Moduls\Kassa.dll1', 'C:\UNO\bin\Moduls\Kassa.dll');
      end;
   end
  else
  begin
      if FileExists('C:\UNO\bin\Moduls\Kassa.dll1') then
      begin
          ShowMessage('Уже выключена.');

      end
      else
      begin
          button3.Caption:='Включить Кассу';
          RenameFile('C:\UNO\bin\Moduls\Kassa.dll', 'C:\UNO\bin\Moduls\Kassa.dll1');
      end;
  end;
end;

procedure TForm3.ExecuteControlService(ServiceName: String; ServiceControlCode : DWORD);
var
 SCManagerHandle, SCHandle  : THandle;
 ServiceStatus : TServiceStatus;
begin
 SCManagerHandle := OpenSCManager(nil, nil, GENERIC_READ);
 SCHandle := OpenService(SCManagerHandle, PChar(ServiceName), SERVICE_ALL_ACCESS);
 ControlService(SCHandle, ServiceControlCode, ServiceStatus);
 CloseServiceHandle(SCHandle);
 CloseServiceHandle(SCManagerHandle);
end;

procedure TForm3.StatusService(ServiceName: String;TypeStart: DWORD);
  var
    SCManager, Service: SC_HANDLE;
  begin
    SCManager := OpenSCManager(nil, nil, GENERIC_READ);
    Service := OpenService(SCManager, PChar(ServiceName), SERVICE_ALL_ACCESS);
    ChangeServiceConfig(Service, SERVICE_NO_CHANGE,TypeStart, SERVICE_NO_CHANGE, nil, nil, nil, nil,nil, nil, nil);
    CloseServiceHandle(Service);
    CloseServiceHandle(SCManager);
  end;

procedure TForm3.ExecuteStartService(ServiceName: String);
var
 SCManagerHandle, SCHandle  : THandle;
 p : PChar;
begin
 SCManagerHandle := OpenSCManager(nil, nil, GENERIC_READ);
 SCHandle := OpenService(SCManagerHandle, PChar(ServiceName), SERVICE_ALL_ACCESS);
 p := nil;
 StartService(SCHandle, 0, p);
 CloseServiceHandle(SCHandle);
 CloseServiceHandle(SCManagerHandle);
end;


end.
