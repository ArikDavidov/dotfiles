
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_PREFIX="${BoldRed}(${ResetColor}"  # start of the git info string
  GIT_PROMPT_SUFFIX="${BoldRed})${ResetColor}"  # the end of the git info string
  GIT_PROMPT_SEPARATOR="|"                      # separates each item
  GIT_PROMPT_BRANCH="${BoldRed}"                # the git branch that is active in the current directory
  GIT_PROMPT_STAGED="${BoldGreen}● "            # the number of staged files/directories
  GIT_PROMPT_CONFLICTS="${BoldRed}✖ "           # the number of files in conflict
  GIT_PROMPT_CHANGED="${BoldBlue}+"             # the number of changed files

  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${White}${Time12a}${ResetColor} ${BoldBlue}${PathShort}${ResetColor}"
  GIT_PROMPT_START_ROOT="_LAST_COMMAND_INDICATOR_ ${GIT_PROMPT_START_USER}"
  GIT_PROMPT_END_USER="$ "
  GIT_PROMPT_END_ROOT="# "

  GIT_PROMPT_SYMBOLS_AHEAD="↑"                  # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="↓"                 # The symbol for "n versions behind of origin"
}

reload_git_prompt_colors "Custom"

