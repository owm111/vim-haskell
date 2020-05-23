{ pkgs ? import <nixpkgs> {}, lib ? pkgs.lib }:

let
  # Data
  groups = {
    haskellPragma = {
      region = { start = "{-#"; end = "#-}"; };
    };

    haskellTodo = {
      keywords = [ "TODO" "FIXME" "XXX" ];
      contained = true;
    };

    haskellCommentBlock = {
      region = { start = "{-"; end = "-}"; };
      contains = [ "haskellCommentBlock" "haskellTodo" ];
    };
    haskellCommentInline = {
      region = { start = ''--\+[-!#$%&\*\+./<=>\?@\\^|~]\@!''; end = ''\n''; };
      contains = [ "haskellTodo" ];
    };

    haskellModuleDefinition = {
      region = { start = ''\<module\>''; end = ''\<where\>''; };
      contains = [ "haskellModuleKeywordModule" ];
      keepend = true;
    };
    haskellModuleKeywordModule = {
      keywords = [ "module" ];
      contained = true;
      next = [ "haskellModuleName" ];
    };
    haskellModuleName = {
      match = ''\(\u\w*\.\)*\u\w*'';
      contained = true;
      next = [ "haskellModuleKeywordWhere" "haskellModuleListDelimiterOpen" ];
    };
    haskellModuleKeywordWhere = {
      keywords = [ "where" ];
      contained = true;
    };
    haskellModuleListDelimiterOpen = {
      match = "(";
      contained = true;
      next = [ "haskellModuleListDelimiterClose" "haskellModuleListComma" "haskellModuleListSpecialDotDot" "haskellModuleListIdentifier" "haskellModuleListType" "haskellModuleListDelimiterOperatorOpen" ];
    };
    haskellModuleListSpecialDotDot = {
      match = ''\.\.'';
      contained = true;
      next = [ "haskellModuleListDelimiterClose" ];
    };
    haskellModuleListDelimiterClose = {
      match = ")";
      contained = true;
      next = [ "haskellModuleKeywordWhere" ];
    };
    haskellModuleListDelimiterComma = {
      match = ",";
      contained = true;
      next = [ "haskellModuleListIdentifier" "haskellModuleListType" "haskellModuleListDelimiterOperatorOpen" ];
    };
    haskellModuleListIdentifier = {
      match = ''\l[A-Za-z0-9_']*'';
      contained = true;
      next = [ "haskellModuleListDelimiterComma" "haskellModuleListDelimiterClose" ];
    };
    haskellModuleListType = {
      match = ''\u[A-Za-z0-9_']*'';
      contained = true;
      next = [ "haskellModuleListDelimiterComma" "haskellModuleListDelimiterClose" "haskellModuleSublistDelimiterOpen" ];
    };
    haskellModuleListDelimiterOperatorOpen = {
      match = "(";
      contained = true;
      next = [ "haskellModuleListOperator" ];
    };
    haskellModuleListOperator = {
      match = ''[-!#$%&\*\+/<=>\?@\\^|~:.]\+'';
      contained = true;
      next = [ "haskellModuleListDelimiterOperatorClose" ];
    };
    haskellModuleListDelimiterOperatorClose = {
      match = ")";
      contained = true;
      next = [ "haskellModuleListDelimiterComma" "haskellModuleListDelimiterClose" ];
    };
    haskellModuleSublistDelimiterOpen = {
      match = "(";
      contained = true;
      next = [ "haskellModuleSublistDelimiterClose" "haskellModuleSublistComma" "haskellModuleSublistSpecialDotDot" "haskellModuleSublistIdentifier" "haskellModuleSublistType" "haskellModuleSublistDelimiterOperatorOpen" ];
    };
    haskellModuleSublistSpecialDotDot = {
      match = ''\.\.'';
      contained = true;
      next = [ "haskellModuleSublistDelimiterClose" ];
    };
    haskellModuleSublistDelimiterClose = {
      match = ")";
      contained = true;
      next = [ "haskellModuleListDelimiterClose" "haskellModuleListDelimiterComma" ];
    };
    haskellModuleSublistDelimiterComma = {
      match = ",";
      contained = true;
      next = [ "haskellModuleSublistIdentifier" "haskellModuleSublistType" "haskellModuleSublistDelimiterOperatorOpen" ];
    };
    haskellModuleSublistIdentifier = {
      match = ''\l[A-Za-z0-9_']*'';
      contained = true;
      next = [ "haskellModuleSublistDelimiterComma" "haskellModuleSublistDelimiterClose" ];
    };
    haskellModuleSublistType = {
      match = ''\u[A-Za-z0-9_']*'';
      contained = true;
      next = [ "haskellModuleSublistDelimiterComma" "haskellModuleSublistDelimiterClose" ];
    };
    haskellModuleSublistDelimiterOperatorOpen = {
      match = "(";
      contained = true;
      next = [ "haskellModuleSublistOperator" ];
    };
    haskellModuleSublistOperator = {
      match = ''[-!#$%&\*\+/<=>\?@\\^|~:.]\+'';
      contained = true;
      next = [ "haskellModuleSublistDelimiterOperatorClose" ];
    };
    haskellModuleSublistDelimiterOperatorClose = {
      match = ")";
      contained = true;
      next = [ "haskellModuleSublistDelimiterComma" "haskellModuleSublistDelimiterClose" ];
    };
  };
  highlights = {
    haskellComment = "Comment";
    haskellKeyword = "Keyword";
    haskellOperator = "Operator";
    haskellIdentifier = "Identifier";
    # Since functions and constants are basically the same, Function is being used for constructors.
    haskellConstructor = "Function";
    haskellModule = "Identifier";
    haskellType = "Type";
    haskellSpecial = "Special";
    haskellDelimiter = "Delimiter";
    haskellTodo = "Todo";

    haskellPragma = "haskellSpecial";

    haskellCommentInline = "haskellComment";
    haskellCommentBlock = "haskellComment";

    haskellModuleKeyword = "haskellKeyword";
    haskellModuleKeywordModule = "haskellModuleKeyword";
    haskellModuleKeywordWhere = "haskellModuleKeyword";
    haskellModuleName = "haskellModule";

    haskellModuleListDelimiter = "haskellDelimiter";

    haskellModuleListDelimiterOpen = "haskellModuleListDelimiter";
    haskellModuleListDelimiterClose = "haskellModuleListDelimiter";
    haskellModuleListDelimiterComma = "haskellModuleListDelimiter";
    haskellModuleListDelimiterOperatorOpen = "haskellModuleListDelimiter";
    haskellModuleListDelimiterOperatorClose = "haskellModuleListDelimiter";
    haskellModuleSublistDelimiterOpen = "haskellModuleListDelimiter";
    haskellModuleSublistDelimiterClose = "haskellModuleListDelimiter";
    haskellModuleSublistDelimiterComma = "haskellModuleListDelimiter";
    haskellModuleSublistDelimiterOperatorOpen = "haskellModuleListDelimiter";
    haskellModuleSublistDelimiterOperatorClose = "haskellModuleListDelimiter";

    haskellModuleListSpecialDotDot = "haskellSpecial";
    haskellModuleSublistSpecialDotDot = "haskellModuleListSpecialDotDot";

    haskellModuleListIdentifier = "haskellIdentifier";
    haskellModuleListType = "haskellType";
    haskellModuleListOperator = "haskellOperator";
    haskellModuleListConstructor = "haskellConstructor";
    haskellModuleSublistIdentifier = "haskellModuleListIdentifier";
    haskellModuleSublistType = "haskellModuleListConstructor";
    haskellModuleSublistOperator = "haskellModuleListOperator";
  };

  # File functions and values
  unmentionedGroupNames = lib.subtractLists (builtins.attrNames groups) (builtins.attrNames highlights);
  unmentionedGroups = map unmentionedGroupF unmentionedGroupNames;
  unmentionedGroupF = x:
    let
      highlightLinks = chaseHighlight [] x;
      highlightLinksStr = lib.concatStringsSep " -> " highlightLinks;
    in
      ''
      " ${x}
      " Highlight links: ${highlightLinksStr}
      '';


  groupsList = lib.sort (a: b: a < b) (lib.mapAttrsToList groupF groups ++ unmentionedGroups);
  groupsStr = lib.concatStringsSep "\n" (groupsList);

  groupF = k: v:
    let
      # Syntax
      syntaxCall =
        if v ? "region" then
          "syntax region ${k} start='${v.region.start}' end='${v.region.end}'"
        else if v ? "keywords" then
          "syntax keyword ${k} ${lib.concatStringsSep " " v.keywords}"
        else if v ? "match" then
          "syntax match ${k} '${v.match}'"
        else
          null;

      # Syntax arguments
      contained = lib.optional (v ? "contained" && v.contained) "contained";

      contains = lib.optional (v ? "contains") (
        "contains=${lib.concatStringsSep "," (map containsF v.contains)}"
      );
      containsF = x: 
        assert lib.assertMsg (builtins.elem x (builtins.attrNames groups)) "${k} wants to contain ${x}, but it doesn't exist!";
        x;

      nextgroup = lib.optional (v ? "next")
        "nextgroup=${lib.concatStringsSep "," v.next}";

      skipwhite = lib.optional (nextgroup != [] && (v ? "skipwhite" -> v.skipwhite)) "skipwhite";
      skipempty = lib.optional (nextgroup != [] && (v ? "skipempty" -> v.skipempty)) "skipempty";
      keepend = lib.optional (v ? "keepend" && v.keepend) "keepend";

      optionsList = contained ++ contains ++ nextgroup ++ skipwhite ++ skipempty ++ keepend;
      optionsStr = lib.concatStringsSep " " optionsList;

      # Highlight comment
      highlightLinks = chaseHighlight [] k;
      highlightLinksStr =
        if builtins.elem k (builtins.attrNames highlights) then
          [''" Highlink links: ${lib.concatStringsSep " -> " highlightLinks}'' ]
        else
          builtins.trace "${k} is not highlighted!" [];

      # Contains comment
      containsComment = lib.optional (contains != [])
        ''" Contains: ${lib.concatStringsSep ", " v.contains}'';

      # Next comment
      nextComment = lib.optional (nextgroup != [])
        ''" Next: ${lib.concatStringsSep ", " v.next}'';

      prevComment =
        let
          isNextFor = xk: xv: xv ? "next" && builtins.elem k xv.next;
          prevAttrs = lib.filterAttrs isNextFor groups;
          prevNames = builtins.attrNames prevAttrs;
          prevNamesStr = lib.concatStringsSep ", " prevNames;
        in
          lib.optional (prevAttrs != {}) ''" Prev: ${prevNamesStr}'';

      commentsList = ["\" ${k}"] ++ highlightLinksStr ++ containsComment ++ nextComment ++ prevComment;
      commentsStr =  lib.concatStringsSep "\n" commentsList;
    in
    assert lib.assertMsg (syntaxCall != null) "No syntax call for 'groups.${k}'!";
    ''
      ${commentsStr}
      ${syntaxCall} ${optionsStr}
    '';

  chaseHighlight = xs: x:
    assert lib.assertMsg (builtins.elem x (builtins.attrNames highlights)) "No highlight link defined for '${x}'!";
    # TODO: error on infinite recursion.
    let
      y = highlights."${x}";
      yChars = lib.stringToCharacters y;
      firstChar = lib.head yChars;
      newList = xs ++ [y];
    in
    if firstChar == lib.toUpper firstChar then
      newList
    else
      chaseHighlight newList y;

  highlightsList = lib.mapAttrsToList highlightF highlights;
  highlightsStr = lib.concatStringsSep "\n" highlightsList;

  highlightF = k: v: "highlight default link ${k} ${v}";

  file = builtins.toFile "syntax.vim" ''
    " Generated with Nix 

    syntax clear
    highlight clear

    """"""""""""""""""""""""""""""""""""""
    " Syntax groups
    """"""""""""""""""""""""""""""""""""""

    ${groupsStr}

    """"""""""""""""""""""""""""""""""""""
    " Highlight links
    """"""""""""""""""""""""""""""""""""""

    ${highlightsStr}
  '';
in
  pkgs.runCommand "vim-fuck" { inherit file; } ''
    install -Dv "$file" "$out"
    echo -e "colorscheme sublimemonokai\nexe 'hi Identifier cterm=italic ctermfg=' . g:sublimemonokai_white.cterm\nexe 'hi Todo ctermbg=' . g:sublimemonokai_yellow.cterm\nhi link Include SublimePink\nfunction! SynStack()\nif !exists('*synstack')\nreturn\nendif\necho map(synstack(line('.'), col('.')), 'synIDattr(v:val, \"name\")')\nendfunction\nnoremap <leader>s :call SynStack()<cr>" >> "$out"
  ''
