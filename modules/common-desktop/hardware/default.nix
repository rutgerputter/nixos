{ pkgs, ... }:
{
  services.printing.drivers = [ pkgs.epson-escpr ];
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_ET2712";
        location = "Kantoor";
        deviceUri = "socket://192.168.1.234:9100";
        model = "epson-inkjet-printer-escpr/Epson-ET-2710_Series-epson-escpr-en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Epson_ET2712";
  };
}
