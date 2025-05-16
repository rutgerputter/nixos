{ pkgs, ... }:

let
    rputterConfig = import ./rputter { inherit pkgs; };
in
{
    users = {
        mutableUsers = true;
        users = {
            rputter = rputterConfig.rputter;
        };
    };
}
