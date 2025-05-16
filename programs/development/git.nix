{ ... }:

{
    programs.git = {
        enable = true;
        config = {
            # init.defaultBranch = "main";
            # commit.gpgsign = true;
            # gpg.format = "ssh";
            # tag.gpgsign = true;
        };
        lfs = {
            enable = true;
        };
        prompt = {
            enable = false;
        };
    };
}