
{
    # TODO: Install the `pkgs.words` package.

    environment.etc."share/dict/words".source = "${pkgs.words}/share/dict/american-english";

    # TODO: Create a file in a $PATH directory called `gen-hostname` with the contents
    # ```bash
    # shuf -n 1 /usr/share/dict/words | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]'
    # ```
}
