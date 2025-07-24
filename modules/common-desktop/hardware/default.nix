{ ... }:
{
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson ET-2712";
        location = "Kantoor";
        deviceUri = "ipp://192.168.1.234/ipp";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Epson ET-2712";
  };
}
