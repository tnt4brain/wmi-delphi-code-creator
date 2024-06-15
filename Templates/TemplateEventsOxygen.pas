//-----------------------------------------------------------------------------------------------------
//     This code was generated by the Wmi Delphi Code Creator (WDCC) Version [VERSIONAPP]
//     https://github.com/RRUZ/wmi-delphi-code-creator
//     Blog http://theroadtodelphi.wordpress.com/wmi-delphi-code-creator/
//     Author Rodrigo Ruz V. (RRUZ) Copyright (C) 2011-2023
//----------------------------------------------------------------------------------------------------- 
//
//     LIABILITY DISCLAIMER
//     THIS GENERATED CODE IS DISTRIBUTED "AS IS". NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.
//     YOU USE IT AT YOUR OWN RISK. THE AUTHOR NOT WILL BE LIABLE FOR DATA LOSS,
//     DAMAGES AND LOSS OF PROFITS OR ANY OTHER KIND OF LOSS WHILE USING OR MISUSING THIS CODE.
//
//----------------------------------------------------------------------------------------------------
namespace GetWMI_Info;

interface

uses
    System.Management;

type
  ConsoleApp = class
  public
    class method Main(args: array of string);
    class method WmiEventHandler(sender: System.Object; e: EventArrivedEventArgs);
  end;

implementation


class method ConsoleApp.WmiEventHandler(sender: System.Object; e: EventArrivedEventArgs);
begin  
[OXYGENEVENTSOUT]  
end;


class method ConsoleApp.Main(args: array of string);
const
  sComputerName = 'localhost';
var
  WmiQuery: String;
  Conn: ConnectionOptions;
  Scope: System.Management.ManagementScope;
  Watcher: ManagementEventWatcher;
begin
  Console.WriteLine('Listening Wmi Event - Press enter to exit');
  try
      
	Conn  := new ConnectionOptions();
    if sComputerName<>'localhost' then
    begin
      Conn.Username  := '';
      Conn.Password  := '';
      Conn.Authority := 'ntlmdomain:DOMAIN';
      Scope := New ManagementScope(String.Format('\\{0}\[WMINAMESPACE]',sComputerName), Conn);
    end
    else
    Scope := New ManagementScope(String.Format('\\{0}\[WMINAMESPACE]',sComputerName), nil);
    Scope.Connect();
	
    [OXYGENEVENTSWQL]
      Watcher := new ManagementEventWatcher(Scope, new EventQuery(WmiQuery));
      Watcher.EventArrived += new EventArrivedEventHandler(WmiEventHandler);
      Watcher.Start();
	  Console.Read();
      Watcher.Stop();
 except on  E: Exception do
    begin
      Console.WriteLine('An error occurred while trying to execute the WMI event: '+E.Message);
      Console.WriteLine('Trace '+E.StackTrace );
	  Console.Read();
    end;
 end;
end;

end.
